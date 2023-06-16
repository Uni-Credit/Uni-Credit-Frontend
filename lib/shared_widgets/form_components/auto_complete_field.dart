import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_credit/shared_widgets/list_value_notifier.dart';
import '../listing/multi_child_scroll_view.dart';
import 'form_input_configuration.dart';

// #Todo remember => update events class

// #TODO FIX DROPDWON BEHAVIOUR

class AutoCompleteField extends StatefulWidget {
  final ListValueNotifier<String>? listNotifier;
  final bool showItems;
  final double dropdownWidth;

  final bool Function(List<String> currentItems)? willUpdateList;
  final TextEditingController? textController;
  final Function(String option)? onselected;

  final ScrollController? scrollController;

  final bool updateOnScrollEnd;
  final bool updateOnInput;
  final bool updateOnSelected;

  final Future Function()? onScrollEnd;

  final bool filtersBySearch;
  final bool updateOnClick;

  final FormInputConfiguration? inputConfiguration;

  const AutoCompleteField({
    Key? key,
    required this.dropdownWidth,
    this.willUpdateList,
    this.scrollController,
    required this.optionsBuilder,
    required this.inputBuilder,
    this.onselected,
    this.inputConfiguration,
    this.updateOnInput = false,
    this.updateOnSelected = false,
    this.filtersBySearch = true,
    this.updateOnClick = false,
    this.updateOnScrollEnd = false,
    this.onScrollEnd,
    this.textController,
    this.showItems = true,
    this.listNotifier,
  }) : super(key: key);

  final Future<List<String>> Function() optionsBuilder;
  final Widget Function(AutoCompleteBuilderArgs) inputBuilder;

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  TextEditingController? textController;
  FocusNode focusNode = FocusNode();

  List<String>? _options;

  int selectedDropDownItem = -1;
  ScrollController? scrollController;
  double? lastScroll;

  TimedCallSearchController? callController;

  bool refresh = false;
  bool updating = false;
  bool ignoreNextTextForUpdate = false;

  @override
  initState() {
    super.initState();

    textController = widget.textController ?? TextEditingController();

    if (widget.inputConfiguration != null) {
      textController!.text = widget.inputConfiguration!.read() ?? "";
    }

    callController = TimedCallSearchController(update: refreshOptions);

    if (widget.updateOnClick) {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          _options = null;
          updateOptions();
        }
      });
    }

    if (widget.updateOnScrollEnd) {
      scrollController ??= ScrollController();

      if (lastScroll != null) {
        scrollController!.position.jumpTo(lastScroll!);
        lastScroll = null;
      }

      setScrollController();

      //
    }

    if (widget.updateOnInput && widget.textController != null) {
      // #TODO : test delay between searching WITH backend
      widget.textController!.addListener(() {
        debugPrint("seearch " + widget.textController!.text.toString());

        if (ignoreNextTextForUpdate) {
          ignoreNextTextForUpdate = false;
          return;
        }

        callController!.onChange(widget.textController?.text);
      });
    }
  }

  void setScrollController() {
    scrollController!.addListener(() async {
      debugPrint("scroller controller update listener ");

      if (!scrollController!.hasClients) {
        return;
      }

      if (widget.scrollController != null) {
        widget.scrollController!.notifyListeners();
      }

      bool shouldNotScroll = _options != null && _options!.length < 7;
      if (shouldNotScroll) {
        return;
      }

      if (scrollController!.position.pixels != 0) {
        lastScroll = scrollController!.position.pixels;
      }

      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        await onLastScroll();
      }
    });
  }

  Future<void> onLastScroll() async {
    if (widget.onScrollEnd != null) {
      await widget.onScrollEnd!();
    }

    await refreshOptions();

    setState(() {
      scrollController = ScrollController(initialScrollOffset: lastScroll!);
      setScrollController();
    });
  }

  Future refreshOptions() async {
    //debugPrint("refresh is now true ");

    setState(() {
      updating = true;
    });
    await updateOptions();
    refresh = false;

    setState(() {
      updating = false;
      if (widget.textController != null) {
        widget.textController!.notifyListeners();
      }
    });
  }

  updateOptions() async {
    if (widget.textController != null) {
      debugPrint(
          "uupdate by search : " + widget.textController!.text.toString());
    }

    _options = await widget.optionsBuilder();

    debugPrint("_Options list : " + _options.toString());
    if (widget.listNotifier != null) {
      //widget.listNotifier!.value = _options;
    }
    try {} catch (err) {
      debugPrint("error in auto complete field load options");
      debugPrint(err.toString());
    }
  }

  Future<List<String>> getOptions() async {
    if (refresh) {
      await updateOptions();
      refresh = false;

      return _options as List<String>;
    }

    if (_options == null && !refresh) {
      await updateOptions();
    }

    debugPrint("returning _options with" + _options.toString());
    return _options as List<String>;
  }

  ListValueNotifier<String> list = ListValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete(
      textEditingController: textController,
      focusNode: textController == null ? null : focusNode,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        List<String> options = await getOptions();

        if (widget.filtersBySearch) {
          options = options
              .where((String option) => option
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase()))
              .cast<String>()
              .toList();
        }

        return options;
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        AutoCompleteBuilderArgs builderArgs = AutoCompleteBuilderArgs(
            getOptions: () => _options,
            onFieldSubmitted: onFieldSubmitted,
            context: context,
            focusNode: fieldFocusNode,
            textController: fieldTextEditingController,
            updatingSearch: updating);

        return widget.inputBuilder(builderArgs);
      },
      optionsViewBuilder: (context, onSelected, options) {
        list.value = options.toList();

        return AutoCompleteScroller(
            scrollController: scrollController,
            focusNode: focusNode,
            onSelected: onSelected,
            lastScroll: lastScroll,
            list: list,
            widget: widget);
      },
    );
  }
}

class AutoCompleteScroller extends StatefulWidget {
  const AutoCompleteScroller({
    super.key,
    required this.scrollController,
    required this.focusNode,
    required this.list,
    required this.widget,
    required this.onSelected,
    double? this.lastScroll,
  });

  final ScrollController? scrollController;
  final FocusNode focusNode;
  final double? lastScroll;
  final ListValueNotifier<String> list;
  final AutoCompleteField widget;
  final AutocompleteOnSelected<String> onSelected;

  @override
  State<AutoCompleteScroller> createState() => _AutoCompleteScrollerState();
}

class _AutoCompleteScrollerState extends State<AutoCompleteScroller> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
          //color: Colors.white,
          child: SelectorList(
              scrollController: widget.scrollController,
              focusNode: widget.focusNode,
              options: widget.list,
              onSelected: (String option) {
                // ignoreNextTextForUpdate = true;
                widget.onSelected(option);

//                    if (widget.updateOnSelected) {}
              },
              dropdownWidth: widget.widget.dropdownWidth)),
    );
  }
}

class SelectorList extends StatefulWidget {
  final double dropdownWidth;
  final AutocompleteOnSelected<String> onSelected;
  final ListValueNotifier<String> options;
  final FocusNode focusNode;
  final ScrollController? scrollController;

  final double? lastScroll;

  const SelectorList(
      {Key? key,
      required this.options,
      required this.onSelected,
      required this.focusNode,
      this.scrollController,
      this.lastScroll,
      required this.dropdownWidth})
      : super(key: key);

  @override
  State<SelectorList> createState() => _SelectorListState();
}

class _SelectorListState extends State<SelectorList> {
  int selectedDropDownItem = -1;

  // Handles the key events from the Focus widget and updates the
  // _message.
  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      selectedDropDownItem -= 1;
      setState(() {});
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      selectedDropDownItem += 1;
      selectedDropDownItem =
          min(selectedDropDownItem, widget.options.value.length);
      setState(() {});
    }

    return event.logicalKey == LogicalKeyboardKey.arrowUp ||
            event.logicalKey == LogicalKeyboardKey.arrowDown
        ? KeyEventResult.handled
        : KeyEventResult.ignored;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      //     focusNode: widget.focusNode,
      //  onKey: _handleKeyEvent,
      child: MultiChildScrollView(
        scrollController: widget.scrollController,
        scrollWidth: widget.dropdownWidth,
        scrollHeight: MediaQuery.of(context).size.height * 0.6,
        children: [
          for (int i = 0; i < widget.options.value.length; i++)
            Container(
                color: Colors.white,
                width: widget.dropdownWidth,
                child: Selector(
                  option: widget.options.value.elementAt(i),
                  hovered: selectedDropDownItem == i,
                  onHover: (bool entering) {
                    if (entering) {
                      selectedDropDownItem = i;
                    }
                    setState(() {});
                  },
                  onSelected: (String v) {
                    widget.onSelected(v);

                    setState(() {});
                  },
                ))
        ],
      ),
    );
  }
}

class Selector extends StatefulWidget {
  final Function(String) onSelected;
  final String option;
  final bool hovered;
  final Function(bool entering) onHover;
  const Selector(
      {required this.option,
      required this.onSelected,
      Key? key,
      required this.hovered,
      required this.onHover})
      : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    double heightSpacing = MediaQuery.of(context).size.height * 0.02;
    return GestureDetector(
      onTap: () {
        widget.onSelected(widget.option);
      },
      child: Container(
        color: widget.hovered ? Color(0xffcccccc) : Colors.white,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (p) {
            widget.onHover(true);
          },
          onExit: (p) {
            widget.onHover(false);
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                top: heightSpacing,
                right: 6,
                bottom: heightSpacing),
            child: Text(widget.option,
                style: const TextStyle(
                    color: Color(0xff333333),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    decoration: TextDecoration.none)),
          ),
        ),
      ),
    );
  }
}

class AutoCompleteBuilderArgs {
  BuildContext context;
  TextEditingController? textController;
  FocusNode? focusNode;
  VoidCallback? onFieldSubmitted;
  Function()? getOptions;
  bool updatingSearch;

  AutoCompleteBuilderArgs({
    required this.getOptions,
    required this.onFieldSubmitted,
    required this.context,
    required this.focusNode,
    required this.textController,
    this.updatingSearch = false,
  });
}

class TimedCallSearchController {
  Future Function() update;
  int calls = 0;

  static const int typingInterval = 1000;

  static const int letterCountBasedInterval = 1000;

  static const int letterWeight = 225;

  TimedCallSearchController(
      {required this.update, this.useExtraLetterCountTime = true});

  String? lastText;
  bool useExtraLetterCountTime;

  onChange(String? text) async {
    debugPrint("search: " + (text ?? ""));
    debugPrint("last search: " + (lastText ?? ""));

    if (lastText == text) {
      return;
    }

    if (text == null) {
      return;
    }

    calls += 1;
    if (calls > 100) {
      calls = 0;
    }

    int lastCalls = calls;

    int delay = typingInterval;

    if (text.isNotEmpty && useExtraLetterCountTime) {
      delay += max(0, letterCountBasedInterval - text.length * letterWeight);
    }

    lastText = text;
    await Future.delayed(Duration(milliseconds: delay));

    if (calls != lastCalls) {
      return;
    }
    debugPrint("update: ");
    await update();
  }
}

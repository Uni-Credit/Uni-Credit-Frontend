import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:framework/models/extensions/basic_types/for_string.dart';

import '../card_button.dart';
import '../item_sizes.dart';
import '../responsive/media_queries.dart';
import 'form_controller_utility.dart';

class FileUploaderButton extends StatefulWidget {
  FileUploaderButton({
    Key? key,
    required this.builderChildButton,
    this.onChange,
    this.size = double.infinity,
    this.allowMultiple = false,
    this.withReadStream = false,
    this.onUploaded,
    this.isUploaded,
    this.canSelectNone = true,
    this.defaultName = "",
  }) : super(key: key);

  final bool allowMultiple;
  final bool withReadStream;
  Function? onChange;

  final double? size;
  bool canSelectNone;
  bool? isUploaded;
  String defaultName;

  final Function(FileUploaderButtonState)? onUploaded;
  final Widget Function(
    IconData iconData,
    Color color,
    Future<void> Function() getFile,
  ) builderChildButton;
  @override
  State<FileUploaderButton> createState() => FileUploaderButtonState();
}

class FileUploaderButtonState extends State<FileUploaderButton> {
  bool _fileUploaded = false;
  PlatformFile? _file;

  @override
  void initState() {
    super.initState();
  }

  fileIsUploaded() {
    return widget.isUploaded ?? _fileUploaded;
  }

  getIcon() {
    return fileIsUploaded() ? Icons.check : Icons.create_new_folder;
  }

  getColor() {
    return fileIsUploaded()
        ?
        //getUserPrimaryColor()
        Colors.blueAccent
        :
        //BrandColors.studentYellow
        Colors.yellowAccent;
  }

  Future<void> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultiple,
      withReadStream: widget.withReadStream,
      type: FileType.custom,
      allowedExtensions: ["jpeg", "jpg", "png", "pdf"],
    );

    setState(() {
      if (result != null) {
        for (PlatformFile file in result.files) {
          if (widget.onChange != null) {
            widget.onChange!(file);
          }
        }

        _fileUploaded = true;
      } else {
        if (widget.onChange != null) {
          widget.onChange!(null);
        }
        _fileUploaded = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      child: widget.builderChildButton == null
          ? FilePickCard(
              fileName: !(widget.isUploaded != null && widget.isUploaded!)
                  ? widget.defaultName
                  : _file!.name,
              iconData: getIcon(),
              color: getColor(),
              getFile: getFile,
              fileNameSizeLimit: null,
            )
          : widget.builderChildButton(getIcon(), getColor(), getFile),
    );
  }
}

class FilePickCard extends StatelessWidget {
  final dynamic iconData;
  final Color? color;
  final dynamic Function()? getFile;
  final String fileName;

  final ItemSize cardSize;

  final Widget Function(String)? cardBuilder;

  final int? fileNameSizeLimit;

  const FilePickCard({
    required this.fileName,
    this.cardSize = ItemSize.normal,
    this.cardBuilder,
    this.iconData,
    this.color,
    this.getFile,
    Key? key,
    this.fileNameSizeLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fileDivision = fileName.lastIndexOf(".");

    String fileType = fileDivision == -1
        ? ""
        : fileName.substring(fileDivision + 1, fileName.length);
    String file =
        fileDivision == -1 ? fileName : fileName.substring(0, fileDivision);

    String text = returnAppropriate(
      context,
      defaultResult: file.hideInfo(
          maxLength: fileNameSizeLimit ?? 28,
          suffix: fileType == "" ? "" : ".$fileType"), /*mobile: ""*/
    );

    if (cardBuilder != null) {
      return cardBuilder!(text);
    }

    // multiply height
    return CardButton(
        onPress: getFile,
        titleAlignment: Alignment.centerLeft,
        buttonSize: cardSize,
        /*     padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 19)), */
        backgroundColor: color,
        trailingIcon: iconData,
        title: LabelText(
          content: text,
        ));
  }
}

class InputFileTextCard extends StatelessWidget {
  final String text;
  final Function() getFile;
  final dynamic iconData;
  const InputFileTextCard(
      {Key? key, required this.text, required this.getFile, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardButton(
      title: LabelText(
        content: text,
      ),
      titlePadding: const EdgeInsets.only(left: LabelText.labelLeftPadding),
      titleFlex: 40,
      trailingFlex: 8,
      leadingIconFlex: 0,
      useLeadingSpacing: false,
      titleAlignment: Alignment.centerLeft,
      onPress: getFile,
      titleWeight: FontWeight.normal,

      trailingIcon: iconData,
      backgroundColor:

          //getAppBackgroundColor()
          Colors.white70, //color,
      borderShape: BeveledRectangleBorder(
          side: BorderSide(color: Color(0xff9b9b9b /*d4d4d4*/), width: 0.5),
          borderRadius: BorderRadius.circular(4)),
      buttonSize: ItemSize.normal,
      heightMultiply: 1.2,
    );
  }
}

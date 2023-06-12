import '../../list_value_notifier.dart';

class ItemsSelection<T> {
  bool inToggleMode;
  bool canChangeToggle;
  late ListValueNotifier<T> itemsToggled;
  final Function(dynamic)? pressed;
  Function(List<T> toggledItems)? onToggleSelection;
  ItemsSelection(
      {this.inToggleMode = false,
      this.canChangeToggle = true,
      this.pressed,
      this.onToggleSelection,
      ListValueNotifier<T>? itemsSelected}) {
    this.itemsToggled = itemsSelected ?? ListValueNotifier([]);
  }

  changeToggleMode() {
    inToggleMode = !inToggleMode;

    if (!inToggleMode) {
      itemsToggled.clear();
    }
  }
}

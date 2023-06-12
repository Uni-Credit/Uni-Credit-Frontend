class Listing<T> {
  List<T> items;
  Function(T) onPress;

  Listing({required this.items, required this.onPress});
}

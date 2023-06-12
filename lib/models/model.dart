class ModelElement {
  ModelElement({required Model model}) {
    model.elements.add(this);
  }
}

class Model<T extends ModelElement> {
  List<T> elements = [];
}

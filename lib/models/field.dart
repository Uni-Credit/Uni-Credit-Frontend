class Field<T> {
  T? _data;

  dynamic whenNull;

  Field(this._data, {this.whenNull});

  get data => _data ?? whenNull;

  set data(newData) {
    _data = data;
  }

  bool isIncomplete() {
    return _data == null;
  }
}

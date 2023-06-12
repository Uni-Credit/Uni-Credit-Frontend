enum HttpMethod { get, post, put, delete, head, patch, trace, options, connect }

extension HttpMethodEnum on HttpMethod {
  string() {
    return name.toUpperCase();
  }
}

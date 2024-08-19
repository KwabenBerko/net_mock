/// Represents HTTP methods or verbs in `net_mock`.
enum Method {
  get("GET"),
  head("HEAD"),
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  connect("CONNECT"),
  options("OPTIONS"),
  trace("TRACE"),
  patch("PATCH");

  final String name;

  const Method(this.name);

  /// Returns an instance of Method based on the provided HTTP method name.
  /// [name] should be the name of an HTTP verb.
  factory Method.from(String name) {
    return Method.values.firstWhere((method) {
      return method.name.toLowerCase() == name.toLowerCase();
    });
  }
}

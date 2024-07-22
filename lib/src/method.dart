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

  factory Method.from(String name) {
    return Method.values.firstWhere((method) {
      return method.name.toLowerCase() == name.toLowerCase();
    });
  }
}
class HTTPException implements Exception {
  HTTPException(this.msg);
  final String msg;

  @override
  String toString() {
    return msg;
  }
}

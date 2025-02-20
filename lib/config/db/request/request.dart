class Request<T> {
  final int code;
  final String message;
  final T? data;

  Request({required this.code, required this.message, required this.data});
}

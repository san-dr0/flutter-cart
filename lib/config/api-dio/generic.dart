class GenericModel<T> {
  int statusCode;
  String message;
  T? data;

  GenericModel({
    required this.statusCode, required this.message, this.data
  });

  factory GenericModel.factory(Map<String, dynamic> genericData) {
    return GenericModel(
      statusCode: genericData['statusCode'] ?? 0, 
      message: genericData['message'] ?? '',
      data: genericData['data'] ?? '',
    );
  }
}

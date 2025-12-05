class ApiConstants {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";
  static const String postsEndpoint = "/posts";
  static const String commentsEndpoint = "/comments";
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
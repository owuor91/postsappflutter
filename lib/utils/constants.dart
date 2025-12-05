class ApiConstants {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";
  static const String postsEndpoint = "/posts";
  static String postEndpoint(int postId) => "/posts/$postId";
  static String commentsEndpoint(int postId) => "/posts/$postId/comments";
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
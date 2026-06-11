class ApiEndpoints {
  static const String baseUrl = 'https://api.jollyshop.example.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Products
  static const String products = '/products';
  static String productDetail(String id) => '/products/$id';

  // Categories
  static const String categories = '/categories';

  // Cart
  static const String cart = '/cart';
  static String cartItem(String id) => '/cart/$id';

  // Orders
  static const String orders = '/orders';
  static String orderDetail(String id) => '/orders/$id';

  // Profile
  static const String profile = '/users/me';
}

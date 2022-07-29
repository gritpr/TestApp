import '../../../../__lib.dart';

class ApiEndPoints {
  static String get baseUrl => BuildConfig.isDev
      ? 'https://westmarket.herokuapp.com/api/v1'
      : AppKeys.baseUrl;

//AUTH

  static const String createAccount = '/user/register';
  static const String initiateVerification = '/v1/auth/verify/email/initiate';
  static const String verifyEmail = '/user/verify-email';
  static const String login = '/user/login';
  static const String passwordResetRequest = '/user/password-reset-request';
  static const String resetPassword = '/user/reset-password';

  //USER

  //FUNDING

  static String fundWallet(String userId) => '/user/wallet/$userId/recharge';

  //CART

  static String getProductListings(String userId, String? productId) => productId==null? '/user/$userId/products':'/user/$userId/products?_id=$productId';
  static String addToCart = '/user/cart/add-item';
  static String getCart(String userId, String? orderId) => orderId == null
      ? '/user/$userId/cart'
      : '/user/$userId/cart?orderId=$orderId';
  static String checkOut = '/user/cart/checkout';

  // static const String = '';
  // static const String = '';

}

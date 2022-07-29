import '../../../__lib.dart';
import './services/__services.remote.repo.dart' as http;

abstract class CartRepo {
  Future<EmptyResponse> getProducts(
      {required String userId, String? productId});
  Future<EmptyResponse> getCart({required String userId});
  Future<EmptyResponse> addToCart({
    required String userId,
    required String productId,
    required String quantity,
  });
  Future<EmptyResponse> checkOut(
      {required String userId, required String orderId});
}

class CartRepoImp extends CartRepo {
  @override
  Future<EmptyResponse> addToCart(
      {required String userId,
      required String productId,
      required String quantity}) async {
    final data = {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
    final result =
        await http.post(path: http.ApiEndPoints.addToCart, data: data);
    if (result['cart']['success'] == false) {
      return ErrorResponse.fromJson(result['cart']);
    }
    return AddToCartResponse.fromJson(result['cart']);
  }

  @override
  Future<EmptyResponse> checkOut(
      {required String userId, required String orderId}) async {
    final data = {
      'userId': userId,
      'orderId': orderId,
    };
    final result =
        await http.post(path: http.ApiEndPoints.checkOut, data: data);
    if (result['cart']['success'] == false) {
      return ErrorResponse.fromJson(result['cart']);
    }
    return CheckOutResponse.fromJson(result['cart']);
  }

  @override
  Future<EmptyResponse> getCart(
      {required String userId, String? orderId}) async {
    final result =
        await http.get(path: http.ApiEndPoints.getCart(userId, orderId));
    if (result['cart']['success'] == false) {
      return ErrorResponse.fromJson(result['cart']);
    }
    return GetCartResponse.fromJson(result['cart']);
  }

  @override
  Future<EmptyResponse> getProducts(
      {required String userId, String? productId}) async {
    final result = await http.get(
        path: ApiEndPoints.getProductListings(userId, productId));
    if (result['products']['success'] == false) {
      return ErrorResponse.fromJson(result['products']);
    }
    return GetProductResponse.fromJson(result['products']);
  }
}

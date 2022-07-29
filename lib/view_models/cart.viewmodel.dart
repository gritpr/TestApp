import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../__lib.dart';

final cartViewModel = ChangeNotifierProvider<CartViewModel>(
  (ref) => CartViewModel(
    cartRepo: CartRepoImp(),
  ),
);

class CartViewModel extends ChangeNotifier {
  final CartRepo cartRepo;
  String? _walletBalance;
  String? get walletBalance => _walletBalance;
  CartViewModel({required this.cartRepo});

  List<CartData>? _cartData;

  List<CartData>? get cartData => _cartData;

  List<Product>? _products;

  List<Product>? get products => _products;

  final context = Get.context;

  String? get userId => context!.read(authViewModel).userId;

  init() {
    fetchCartData();
    fetchProducts();
    pollProductsLst();
  }

  Future fetchCartData() async {
    final result = await cartRepo.getCart(userId: userId ?? '');
    if (result is ErrorResponse) {
      showErrorSnackbar('Could not fetch cart data');
    } else {
      result as GetCartResponse;
      _cartData = result.data;
    }
    notifyListeners();
  }

  Future fetchProducts() async {
    final result = await cartRepo.getProducts(userId: userId ?? '');
    if (result is ErrorResponse) {
      showErrorSnackbar('Could not fetch cart data');
    } else {
      result as GetProductResponse;
      _products = result.data;
    }
    notifyListeners();
  }

  Timer? _timer;
  pollProductsLst() {
    log('polling started');
    _timer = Timer.periodic(const Duration(seconds: 60), (t) {
      fetchProducts();
    });
  }

  stopPolling() {
    log('polling stopped');
    _timer?.cancel();
  }

  void setWalletBalance(String amount) {
    _walletBalance = amount;
    notifyListeners();
  }
}

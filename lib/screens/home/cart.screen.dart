import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../__lib.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();
  CartRepo cartRepo = CartRepoImp();
  bool isLoading = false;

  updateIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (BuildContext context, watch, Widget? child) {
                  final cartData = watch(cartViewModel).cartData;
                  return cartData == null
                      ? Center(
                          child: text('Could not fetch cart data'),
                        )
                      : cartData.isEmpty
                          ? Center(
                              child: text('You have not opened any cart'),
                            )
                          : ListView.builder(
                              itemCount: cartData.length,
                              itemBuilder: (c, i) {
                                final item = cartData[i];
                                return Card(
                                  child: col(children: [
                                    Padding(
                                      padding: pad(both: 8),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            col(children: [
                                              text(
                                                item.orderId,
                                                weight: FontWeight.w600,
                                              ),
                                              verticalSpace(height: 4),
                                              text(
                                                  'Total: ${item.total} \t\t Status:  ${item.status}'),
                                            ]),
                                            if (item.status == 'pending')
                                              IconButton(
                                                onPressed: () =>
                                                    showConfirmationDialog(
                                                        item.orderId ?? ''),
                                                icon: const Icon(Icons
                                                    .shopping_cart_checkout_rounded),
                                                color: Colors.blue,
                                              )
                                          ]),
                                    )
                                  ]),
                                );
                              },
                            );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  showConfirmationDialog(String orderId) {
    Get.defaultDialog(
      title: "Are you sure you want to check out?",
      middleText: "You will be debited",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black),
      middleTextStyle: const TextStyle(color: Colors.black54),
      textConfirm: "Confirm",
      textCancel: "Cancel",
      cancelTextColor: Colors.blue,
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      barrierDismissible: false,
      radius: 4,
      titlePadding: pad(horiz: 16, vert: 16),
      contentPadding: pad(horiz: 16, vert: 16),
      onCancel: () => pop(),
      onConfirm: () => checkOut(orderId),
    );
  }

  checkOut(String orderId) async {
    pop();
    final result = await cartRepo.checkOut(
        userId: context.read(cartViewModel).userId ?? '', orderId: orderId);
    if (result is ErrorResponse) {
      showErrorSnackbar('${result.message}');
    } else {
      result as CheckOutResponse;
      context.read(cartViewModel).fetchCartData();
      showSuccessSnackbar('${result.message}');
    }
  }
}

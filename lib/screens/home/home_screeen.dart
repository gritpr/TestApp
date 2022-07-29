import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../__lib.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CartRepo cartRepo = CartRepoImp();

  bool isLoading = false;

  @override
  void initState() {
    context.read(cartViewModel).init();
    super.initState();
  }

  updateIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void addToCart({required String productId}) async {
    updateIsLoading();
    final result = await cartRepo.addToCart(
        userId: context.read(authViewModel).userId ?? '',
        productId: productId,
        quantity: '1');
    updateIsLoading();
    if (result is ErrorResponse) {
      final snackBar = GetSnackBar(
        messageText: text(
          result.message,
          textAlign: TextAlign.center,
          color: Colors.white,
        ),
        forwardAnimationCurve: Curves.easeOutBack,
        duration: const Duration(seconds: 1),
        margin: pad(horiz: 100, vert: 60),
        backgroundColor: Colors.black87,
        borderRadius: 24,
      );
      Get.showSnackbar(snackBar);
    } else {
      context.read(cartViewModel).fetchCartData();
      final snackBar = GetSnackBar(
        messageText: text('Added to cart!',
            color: Colors.white, textAlign: TextAlign.center),
        forwardAnimationCurve: Curves.easeOutBack,
        duration: const Duration(seconds: 1),
        margin: pad(horiz: 100, vert: 60),
        backgroundColor: Colors.black54,
        borderRadius: 24,
      );
      Get.showSnackbar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            walletBalance(),
            IconButton(
              onPressed: () {
                pushScreen(const FundWalletScreen());
              },
              icon: const Icon(Icons.account_balance_wallet),
            ),
            cartBadge()
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(
                  builder: (BuildContext context, watch, Widget? child) {
                    final products = watch(cartViewModel).products;
                    return products == null
                        ? Center(
                            child: text('Could not fetch product'),
                          )
                        : products.isEmpty
                            ? Center(
                                child: text(
                                    'There are no products. Contact support.'),
                              )
                            : ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (c, i) {
                                  final item = products[i];
                                  return Card(
                                    child: col(children: [
                                      verticalSpace(height: 4),
                                      Padding(
                                        padding: pad(both: 8),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              col(children: [
                                                text(
                                                  item.name,
                                                  weight: FontWeight.w600,
                                                ),
                                                verticalSpace(height: 4),
                                                text(
                                                    '${item.initialQuantity} units available \t ${item.soldQuantity} sold'),
                                              ]),
                                              IconButton(
                                                onPressed: isLoading
                                                    ? null
                                                    : () => addToCart(
                                                        productId:
                                                            item.sId ?? ''),
                                                icon: const Icon(
                                                    Icons.shopping_cart),
                                                color: isLoading
                                                    ? Colors.grey
                                                    : Colors.blue,
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
      ),
    );
  }

  Widget cartBadge() {
    return Consumer(builder: (BuildContext context, watch, child) {
      final cartData = watch(cartViewModel).cartData;
      int? numberOfCartItems;
      if (cartData != null) {
        numberOfCartItems = cartData[0].items!.length;
      }

      return Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
              onPressed: () {
                pushScreen(const CartScreen());
              },
              icon: const Icon(Icons.shopping_cart)),
          Positioned(
            top: 6,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.blue)),
              padding: pad(both: 4),
              child: text(numberOfCartItems ?? '0',
                  size: 8, weight: FontWeight.w500),
            ),
          ),
        ],
      );
    });
  }
}

walletBalance() {
  return Consumer(builder: (BuildContext context, watch, child) {
    final balance = watch(cartViewModel).walletBalance;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: text(
          balance ?? '0.00',
          color: Colors.white,
          size: 16,
          weight: FontWeight.w600,
          textAlign: TextAlign.center,
        ),
      ),
    );
  });
}

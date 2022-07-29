import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../__lib.dart';

class FundWalletScreen extends StatefulWidget {
  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  AuthRemoteRepo authRemoteRepo = AuthRemoteRepoImp();

  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  updateIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  fund() async {
    updateIsLoading();
    final result = await authRemoteRepo.fundWallet(
        amount: controller.text.trim(),
        userId: context.read(authViewModel).userId ?? '');
    updateIsLoading();
    if (result is ErrorResponse) {
      showErrorSnackbar('${result.message}');
    } else {
      controller.clear();
      result as FundWalletResponse;
      context
          .read(cartViewModel)
          .setWalletBalance(result.data!.wallet.toString());
      showSuccessSnackbar(result.message ?? 'Wallet Funded!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fund Wallet'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: col(children: [
            verticalSpace(),
            inputFeild(
                label: 'How much do you wish to fund', controller: controller),
            verticalSpace(height: 64),
            wideButton(
                isLoading: isLoading, onPressed: fund, label: 'Fund Wallet')
          ]),
        ),
      ),
    );
  }
}

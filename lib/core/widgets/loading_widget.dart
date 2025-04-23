// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.withMaterial = false});
  final bool withMaterial;
  @override
  Widget build(BuildContext context) {
    if (withMaterial) {
      return Material(
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }
    return Center(child: Center(child: CircularProgressIndicator.adaptive()));
  }
}

void showLoading() {
  BotToast.showCustomLoading(
    toastBuilder: (cancelFunc) {
      return const LoadingWidget(withMaterial: false);
    },
  );
}

void hideLoading() {
  BotToast.closeAllLoading();
}

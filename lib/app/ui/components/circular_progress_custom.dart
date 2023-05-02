import 'package:flutter/material.dart';

class ShowCircularProgress extends StatelessWidget {
  bool isLoading;
  ShowCircularProgress(this.isLoading, {super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
          child: Container(
            alignment: const Alignment(0, 0.3),
            child: const CircularProgressIndicator(),
          ));
    }
    return const SizedBox(
      height: 0.0,
      width: 0.0,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_tcg_calculator/view/widgets/app_bar.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(height: 150),
      body: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';

class CardTab extends StatelessWidget {
  const CardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow,
        child: const Center(
          child: Text('Card'),
        ),
      ),
    );
  }
}

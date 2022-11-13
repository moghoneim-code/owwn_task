import 'package:flutter/material.dart';
// import 'package:nb_utils/src/extensions/int_extensions.dart';

class EmptyWidget extends StatelessWidget {
  EmptyWidget({required this.text, Key? key}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/empty.png',
              height: 120,
            ),
            //  12,
            Text(
              text ?? '',
              style: TextStyle(fontSize: 18),
            ),
            //50.height,
          ],
        ),
      ),
    );
  }
}

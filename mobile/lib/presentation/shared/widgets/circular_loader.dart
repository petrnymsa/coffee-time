import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: const CircularProgressIndicator(strokeWidth: 1),
      ),
    );
  }
}

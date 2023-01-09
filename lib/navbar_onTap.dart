import 'package:flutter/material.dart';

class DialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Navigation Bar'),
        ),
        body: Center(
          child: Text('Navigation Bar ile Sayfa Değiştirdiniz'),
        ));
  }
}

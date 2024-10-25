import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, required this.asset, required this.error});

  final String asset;
  final String error;

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("- Error: ${widget.error}"),
          Image.asset(
            widget.asset,
            width: 200,
            height: 200,
          )
        ],
      ),
    );
  }
}

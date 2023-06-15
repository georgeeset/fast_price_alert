import 'package:flutter/material.dart';

///snackbar for notifications
void showSnackBar({required BuildContext context, required String message}) {
  var snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.black87,
    padding: const EdgeInsets.all(20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

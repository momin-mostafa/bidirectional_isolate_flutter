import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

num calculateFactorial(int n) {
  // This function does the heavy computation
  num result = 1;
  for (int i = 2; i <= n; i++) {
    print(i);
    result *= i;
  }
  print("result: $result");
  return result;
}

Future<void> computeExample(BuildContext context) async {
  log("Compute method started", name: "computeExample");

  final futureFactorial = compute(calculateFactorial, 5000);

  // Wait for the result without blocking the UI
  await futureFactorial.then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Factorial of 3665 is $value'),
      ),
    );
  });
  log("Compute method finished", name: "computeExample");
}

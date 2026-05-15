import 'package:flutter/material.dart';

TextStyle? displayBase(BuildContext context) {
  return Theme.of(
    context,
  ).textTheme.headlineLarge?.copyWith(color: Colors.black, letterSpacing: -0.5);
}

TextStyle? headline(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge?.copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle? bodyMedium(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium?.copyWith(
    color: Colors.black87,
    height: 1.5,
  );
}

TextStyle? subhead(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium?.copyWith(
    color: Theme.of(context).primaryColor,
    fontWeight: FontWeight.w600,
  );
}

TextStyle? caption(BuildContext context) {
  return Theme.of(
    context,
  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600], fontSize: 12);
}

TextStyle? buttonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge?.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );
}

import 'package:flutter/material.dart';

/// Design-er 'Yellow/Amber' theme-er sathe match kore typography helper
TextStyle? displayBase(BuildContext context) {
  // Screen-er main heading (e.g., 'Menu Details' or 'Add Items')
  return Theme.of(
    context,
  ).textTheme.headlineLarge?.copyWith(color: Colors.black, letterSpacing: -0.5);
}

TextStyle? headline(BuildContext context) {
  // Product titles (e.g., 'Cheeseburger', 'Veggies Burger')
  return Theme.of(context).textTheme.titleLarge?.copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

TextStyle? bodyMedium(BuildContext context) {
  // Description text ba menu list-er item names
  return Theme.of(context).textTheme.bodyMedium?.copyWith(
    color: Colors.black87,
    height: 1.5, // Halka line spacing design-ke clean rakhbe
  );
}

TextStyle? subhead(BuildContext context) {
  // Price ba secondary details (e.g., '$10.00' or 'Extra Cheese')
  return Theme.of(context).textTheme.titleMedium?.copyWith(
    color: Theme.of(context).primaryColor, // Yellow/Amber color focus korbe
    fontWeight: FontWeight.w600,
  );
}

TextStyle? caption(BuildContext context) {
  // Choto hint text ba timing (e.g., 'Ingredients' title)
  return Theme.of(
    context,
  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600], fontSize: 12);
}

/// Extra: Button-er vitorer text-er jonno
TextStyle? buttonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge?.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );
}

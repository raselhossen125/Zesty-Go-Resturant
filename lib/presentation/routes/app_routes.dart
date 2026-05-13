abstract class RouteName {
  RouteName._();

  static const String _SPLASH_SCREEN = "/splash";
  static const String _LOGIN_SCREEN = "/login";
  static const String _BOTTOM_NAV_SCREEN = "/bottom_nav"; // Updated name
  static const String _VIEW_DETAILS =
      "/view_details"; // Added for better navigation
  static const String _ADD_MENU = "/add_menu";
  static const String _EDIT_PROFILE = "/edit_profile";

  static String get SPLASH_SCREEN => _SPLASH_SCREEN;
  static String get LOGIN_SCREEN => _LOGIN_SCREEN;
  static String get BOTTOM_NAV_SCREEN => _BOTTOM_NAV_SCREEN;
  static String get VIEW_DETAILS => _VIEW_DETAILS;
  static String get ADD_MENU => _ADD_MENU;
  static String get EDIT_PROFILE => _EDIT_PROFILE;
}

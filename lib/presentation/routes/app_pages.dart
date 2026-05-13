import 'package:zesty_go_resturant/presentation/pages/menu/screen/add_menu_screen.dart';
import 'package:zesty_go_resturant/presentation/pages/profile/screen/edit_profile_screen.dart';

import '../pages/login/screen/login_screen.dart';
import '../pages/splash/screen/splash_screen.dart';
import '../pages/navbar/screen/navbar_screen.dart';
import '../pages/viewDetails/screen/view_details_screen.dart';
import 'app_routes.dart';

abstract class RoutePages {
  static final pageBuilder = {
    RouteName.SPLASH_SCREEN: (context) => const SplashScreen(),
    RouteName.LOGIN_SCREEN: (context) => const LoginScreen(),
    RouteName.BOTTOM_NAV_SCREEN: (context) => const BottomNavBarScreen(),
    RouteName.VIEW_DETAILS: (context) => const ViewDetailsScreen(),
    RouteName.ADD_MENU: (context) => const AddMenuScreen(),
    RouteName.EDIT_PROFILE: (context) => const EditProfileScreen(),
  };
}

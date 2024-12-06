import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/screens/screens.dart';
import 'package:shoplocalclubcard/widgets/custom_bottom_navigation.dart';

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == AppRoutes.splash) {
    return animatePage(const SplashScreen());
  } else if (settings.name == AppRoutes.signUp) {
    return animatePage(const SignUpScreen());
  } else if (settings.name == AppRoutes.signIn) {
    return animatePage(const SignInScreen());
  } else if (settings.name == AppRoutes.pwdResetByLink) {
    return animatePage(const ResetPwdByLink());
  } else if (settings.name == AppRoutes.reSetPwd) {
    final List<String> list = settings.arguments as List<String>;
    return animatePage(ResetPwdScreen(
      email: list.first,
      token: list.elementAt(1),
    ));
  } else if (settings.name == AppRoutes.location) {
    return animatePage(const LocationScreen());
  } else if (settings.name == AppRoutes.locationCongratulation) {
    return animatePage(const LocationCongrulationScreen());
  } else if (settings.name == AppRoutes.customBottomNavigation) {
    return animatePage(const CustomBottomNavigation());
  } else if (settings.name == AppRoutes.home) {
    return animatePage(const HomeScreen());
  } else if (settings.name == AppRoutes.categories) {
    final categories = settings.arguments as List<Category>;
    return animatePage(AllCategoriesScreen(categories: categories));
  } else if (settings.name == AppRoutes.stampCards) {
    return animatePage(const StampCardsScreen());
  } else if (settings.name == AppRoutes.shopProcessing) {
    return animatePage(const ShopProcessingScreen());
  } else if (settings.name == AppRoutes.favorties) {
    return animatePage(const FavortiesScreen());
  } else if (settings.name == AppRoutes.notifications) {
    return animatePage(const NotificationScreen());
  } else if (settings.name == AppRoutes.profile) {
    return animatePage(const ProfileScreen());
  } else if (settings.name == AppRoutes.updateProfile) {
    return animatePage(const UpdateUserProfile());
  } else if (settings.name == AppRoutes.cardMemberShip) {
    final name = settings.arguments as String;
    return animatePage(CardMemberShipScreen(
      userName: name,
    ));
  } else {
    return animatePage(const SplashScreen());
  }
}

PageRouteBuilder animatePage(Widget widget) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (_, __, ___) => widget,
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return customLeftSlideTransition(animation, child);
    },
  );
}

Widget customLeftSlideTransition(Animation<double> animation, Widget child) {
  Tween<Offset> tween =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
  return SlideTransition(
    position: tween.animate(animation),
    child: child,
  );
}

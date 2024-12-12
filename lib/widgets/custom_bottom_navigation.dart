import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/constants/app_colors.dart';
import 'package:shoplocalclubcard/constants/app_images.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
import 'package:shoplocalclubcard/screens/screens.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  static late NavigationProvider navigationProvider;
  static late int bottomNavIndex;
  @override
  Widget build(BuildContext context) {
    navigationProvider = Provider.of<NavigationProvider>(context);
    bottomNavIndex = navigationProvider.currentIndex;

    final List<BottomNavigationBarItem> icons = [
      BottomNavigationBarItem(
          icon: _buildImg(
            AppImages.homeIcon,
            bottomNavIndex == 0 ? AppColors.primary : AppColors.grey,
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: _buildImg(
            AppImages.stamCardIcon,
            bottomNavIndex == 1 ? AppColors.primary : AppColors.grey,
          ),
          label: 'Stamp Card'),
      BottomNavigationBarItem(
          icon: _buildImg(
            AppImages.voucherIcon,
            bottomNavIndex == 2 ? AppColors.primary : AppColors.grey,
          ),
          label: 'Vouchers'),
      BottomNavigationBarItem(
          icon: _buildImg(
            AppImages.favouritesIcon,
            bottomNavIndex == 3 ? AppColors.primary : AppColors.grey,
          ),
          label: 'Favourties'),
      BottomNavigationBarItem(
          icon: _buildImg(
            AppImages.shopProcessingIcon,
            bottomNavIndex == 4 ? AppColors.primary : AppColors.grey,
          ),
          label: 'Shop'),
      BottomNavigationBarItem(
          icon: _buildImg(
            AppImages.profileIcon,
            bottomNavIndex == 5 ? AppColors.primary : AppColors.grey,
          ),
          label: 'Profile'),
    ];

    final List<Widget> screens = [
      const HomeScreen(),
      const StampCardsScreen(),
      const VouchersScreen(),
      const FavoritesScreen(),
      const ShopProcessingScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: icons,
        currentIndex: bottomNavIndex,
        backgroundColor: AppColors.white,
        onTap: (index) => navigationProvider.setCurrentIndex(index),
        selectedItemColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.grey,
      ),
    );
  }

  Widget _buildImg(String icon, Color color) {
    return Image.asset(
      icon,
      width: 24,
      height: 24,
      color: color,
    );
  }
}

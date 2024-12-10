import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class FavortiesScreen extends StatelessWidget {
  const FavortiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favourites',
        isLeadingNeeded: false,
        // actionOnPressed: () => Navigator.pushNamed(
        //   context,
        //   AppRoutes.notifications,
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Column(
            children: [
              ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Robitics Advancement',
                shopCategory: "",
                distance: '67Km',
                address: 'Street 1, Model town A, Bahawalpur, Punjab, Pakistan',
                isFavorite: true,
                activePoints: '99',
                points: "09",
                aboutShop:
                    'Fredd’s Coffee prides itself in providing locally sourced produce in a friendly atmosphere',
                isCheckIn: true,
                onCheckInToggle: () {},
                onFavoriteToggle: () {},
                stampcardUsers: const [],
              ),
              const Gap(10),
              ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Robitics Advancement',
                shopCategory: "",
                distance: '67Km',
                address: 'Street 1, Model town A, Bahawalpur, Punjab, Pakistan',
                isFavorite: true,
                points: '99',
                activePoints: "08",
                aboutShop:
                    'Fredd’s Coffee prides itself in providing locally sourced produce in a friendly atmosphere',
                onCheckInToggle: () {},
                onFavoriteToggle: () {},
                isCheckIn: true,
                stampcardUsers: const [],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

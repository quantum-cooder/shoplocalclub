import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class FavortiesScreen extends StatelessWidget {
  const FavortiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Favourites',
        isLeadingNeeded: false,
        // actionOnPressed: () => Navigator.pushNamed(
        //   context,
        //   AppRoutes.notifications,
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Column(
            children: [
              ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Robitics Advancement',
                distance: '67Km',
                address: 'Street 1, Model town A, Bahawalpur, Punjab, Pakistan',
                isFavorite: true,
                points: '99',
                aboutShop:
                    'Fredd’s Coffee prides itself in providing locally sourced produce in a friendly atmosphere',
                vouchers: [],
                stampcardUsers: [],
                isCheckIn: true,
              ),
              Gap(10),
              ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Robitics Advancement',
                distance: '67Km',
                address: 'Street 1, Model town A, Bahawalpur, Punjab, Pakistan',
                isFavorite: true,
                points: '99',
                aboutShop:
                    'Fredd’s Coffee prides itself in providing locally sourced produce in a friendly atmosphere',
                vouchers: [],
                isCheckIn: true,
                stampcardUsers: [],
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

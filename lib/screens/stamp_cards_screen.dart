import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class StampCardsScreen extends StatefulWidget {
  const StampCardsScreen({super.key});

  @override
  State<StampCardsScreen> createState() => _StampCardsScreenState();
}

class _StampCardsScreenState extends State<StampCardsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Stamp Cards',
        isLeadingNeeded: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(10),
              Container(
                height: 40,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildText('Near Me'),
                    SizedBox(
                      height: 25,
                      child: FittedBox(
                        child: Switch(
                          value: true,
                          onChanged: (newValue) {},
                        ),
                      ),
                    ),
                    _buildText('A - Z'),
                    Image.asset(AppImages.arrorIndicator),
                    _buildText('Active'),
                    SizedBox(
                      height: 25,
                      child: FittedBox(
                        child: Switch(
                          value: true,
                          onChanged: (newValue) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Meta Lab',
                shopCategory: "",
                distance: '75Km from east',
                address: 'California, United States',
                isFavorite: true,
                points: '65',
                aboutShop:
                    'Fredd’s Coffee prides itself in providing locally sourced produce in a friendly atmosphere',
                vouchers: [],
                isCheckIn: true,
                stampcardUsers: [],
              ),
              const Gap(20),
              const ShopCustomWidget(
                img: AppImages.cafePlaceHolderImg,
                shopName: 'Google Advanced Lab',
                shopCategory: "",
                distance: '90KM from south',
                address: 'California, United States',
                isFavorite: true,
                points: '60',
                aboutShop:
                    'Fredd’s Coffee prides itself in providing locally sourced produce in a friendly atmosphere',
                vouchers: [],
                isCheckIn: true,
                stampcardUsers: [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String title) {
    return CustomText(
      title: title,
      fontWeight: FontWeight.w700,
      fontSize: AppFontSize.xxsmall,
      color: Colors.black,
    );
  }
}

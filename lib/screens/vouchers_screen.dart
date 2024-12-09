import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Voucher',
        isLeadingNeeded: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: Column(
            children: [
              const Gap(10),
              Container(
                height: 40,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF8F8F8),
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
              const Gap(10),
              const ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Shafiq d hutti',
                shopCategory: "",
                distance: '97 km',
                address: 'outerk pur',
                isFavorite: true,
                points: '98',
                aboutShop:
                    'dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,',
                stampcardUsers: [],
                isCheckIn: true,
                vouchers: [],
              ),
              const Gap(10),
              const ShopCustomWidget(
                img: AppImages.girlPlaceHolder,
                shopName: 'Shafiq d hutti',
                shopCategory: "",
                distance: '97 km',
                address: 'outerk pur',
                isFavorite: true,
                points: '98',
                aboutShop:
                    'dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,dhugs of outruk pur,',
                stampcardUsers: [],
                isCheckIn: true,
                vouchers: [],
              )
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/models/stamp_card_model.dart';
import 'package:shoplocalclubcard/utils/open_url.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ShopCustomWidget extends StatelessWidget {
  const ShopCustomWidget({
    super.key,
    required this.img,
    required this.shopName,
    required this.distance,
    required this.address,
    required this.isFavorite,
    this.points = "0",
    required this.activePoints,
    required this.aboutShop,
    required this.isCheckIn,
    required this.shopCategory,
    required this.onFavoriteToggle,
    required this.onCheckInToggle,
    required this.stampcardUsers,
    this.membershipCardVouchers = const [],
    this.phone = '',
    this.website = '',
  });

  final String img,
      shopName,
      shopCategory,
      distance,
      address,
      activePoints,
      points,
      aboutShop,
      phone,
      website;
  final List<StampCardUser> stampcardUsers;
  final List<MembershipCardVoucher> membershipCardVouchers;

  final bool isFavorite, isCheckIn;
  final void Function() onFavoriteToggle;
  final void Function() onCheckInToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.8),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x23000000),
            blurRadius: 14.92,
            offset: Offset(0, 3.92),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          _buildPointsSection(),
          const Gap(20),
          _buildDetailsSection(),
          _buildActionsSection(),
          _buildAboutSection(),
          ////this works for home stamp card screen for its vouchers and offers where we need to pass stamp cards users list
          if (stampcardUsers.isNotEmpty) ...[
            _buildStampCardScreenVoucherList(),
            _buildShopOfferWidget(stampcardUsers.first.stampcard!, context),
          ],
          ////this works for vouchers screen for its vouchers where we need to pass membershipcardVouchers list
          if (membershipCardVouchers.isNotEmpty)
            _buildVoucherScreenVoucherList(),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(9.8),
        topRight: Radius.circular(9.8),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: img,
            fit: BoxFit.fill,
            width: double.infinity,
            height: 150,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton.filled(
              onPressed: () => onFavoriteToggle(),
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                foregroundColor: WidgetStateProperty.all(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsSection() {
    return Container(
      width: 61,
      height: 23,
      padding: const EdgeInsets.only(top: 3),
      decoration: const ShapeDecoration(
        color: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      child: CustomText(
        title: '$activePoints points',
        textAlign: TextAlign.center,
        color: AppColors.white,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customBodyText(shopName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title: shopCategory),
              Row(
                children: [
                  const CustomText(title: 'Check-in  '),
                  Switch(value: isCheckIn, onChanged: (_) => onCheckInToggle()),
                ],
              )
            ],
          ),
          Divider(
            height: 5,
            color: AppColors.grey.withOpacity(0.5),
            indent: 4,
            endIndent: 4,
          ),
          const Gap(5),
          CustomText(
            title: "$distance km away from you",
            fontSize: AppFontSize.small,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            title: address,
          ),
          const Gap(5),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: Row(
        children: [
          CustomFilledBtn(
            assetImage: AppImages.callImg,
            onPressed: () async {
              await openUrl('tel:$phone');
            },
          ),
          const Gap(15),
          CustomFilledBtn(
            assetImage: AppImages.locationIcon,
            onPressed: () {},
          ),
          const Gap(15),
          CustomFilledBtn(
            assetImage: AppImages.globeIcon,
            onPressed: () async {
              await openUrl(website);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customBodyText('About us:'),
          CustomText(
            title: aboutShop,
          ),
        ],
      ),
    );
  }

  Widget _buildStampCardScreenVoucherList() {
    return ListView.builder(
      itemCount: stampcardUsers.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final voucher = stampcardUsers[index];
        return _buildVoucherWidget(
          voucherDescription: voucher.description ?? '',
          voucherExpiryDate: voucher.expiresAt ?? '',
          voucherID: voucher.id?.toString() ?? '',
          voucherPrice: voucher.points?.toString() ?? '',
        );
      },
    );
  }

  Widget _buildVoucherScreenVoucherList() {
    return ListView.builder(
      itemCount: membershipCardVouchers.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final voucher = membershipCardVouchers[index];
        return _buildVoucherWidget(
          voucherDescription: voucher.message ?? '',
          voucherExpiryDate: voucher.expiresAt ?? '',
          voucherID: voucher.id?.toString() ?? '',
          voucherPrice: voucher.value?.toString() ?? '',
          code: voucher.code,
        );
      },
    );
  }

  Widget _buildShopOfferWidget(StampCard stampCard, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            title: "Shop Offer",
            fontSize: AppFontSize.medium,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
          CustomText(
            title: stampCard.description ?? '',
            fontSize: AppFontSize.medium,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
          const Gap(5),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: GridView.builder(
              itemCount: stampcardUsers.last.stampsTotal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, gridIndex) {
                final stampsTotal = stampcardUsers.last.stampsTotal ?? 0;
                if (gridIndex >= stampsTotal) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundColor: stampsTotal - 1 == gridIndex
                          ? AppColors.white
                          : AppColors.primary,
                      child: stampsTotal - 1 == gridIndex
                          ? Image.asset(AppImages.giftIcon)
                          : CustomText(
                              title: "${gridIndex + 1}",
                              color: AppColors.white,
                              fontSize: AppFontSize.small,
                              fontWeight: FontWeight.w400,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(10),
          Divider(
            color: AppColors.grey.withOpacity(0.3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomFilledBtn(
                    width: 23,
                    height: 23,
                    childHeight: 18,
                    childWidth: 18,
                    btnBackgroundColor: AppColors.primary,
                    assetImage: AppImages.calendarIcon,
                    onPressed: () {},
                  ),
                  const Gap(5),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Expires: ',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: AppFontSize.xxsmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "${stampCard.expireDays} days",
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: AppFontSize.xxsmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CustomFilledBtn(
                    width: 23,
                    height: 23,
                    childHeight: 18,
                    childWidth: 18,
                    btnBackgroundColor: AppColors.primary,
                    assetImage: AppImages.idIcon,
                    onPressed: () {},
                  ),
                  const Gap(5),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'ID: ',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: AppFontSize.xxsmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: stampCard.id.toString() ?? "",
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: AppFontSize.xxsmall,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    );
  }

  Column _buildVoucherWidget({
    required String voucherDescription,
    required String voucherPrice,
    required String voucherExpiryDate,
    required String voucherID,
    String? code,
  }) {
    return Column(
      children: [
        Divider(
          color: AppColors.grey.withOpacity(0.3),
        ),
        const Gap(20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          margin: const EdgeInsets.symmetric(horizontal: 18),
          decoration: ShapeDecoration(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.primary)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    title: 'Voucher (Point)',
                    fontSize: AppFontSize.medium,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  CustomText(
                    title: '\$$voucherPrice',
                    fontSize: AppFontSize.medium,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ],
              ),
              const Gap(5),
              const DottedLineDivider(),
              const Gap(10),
              CustomText(
                title: voucherDescription,
                fontSize: AppFontSize.xxsmall,
                fontWeight: FontWeight.w400,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomFilledBtn(
                        width: 23,
                        height: 23,
                        childHeight: 18,
                        childWidth: 18,
                        btnBackgroundColor: AppColors.primary,
                        assetImage: AppImages.calendarIcon,
                        onPressed: () {},
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Expires: ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppFontSize.xxsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: voucherExpiryDate,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: AppFontSize.xxsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomFilledBtn(
                        width: 23,
                        height: 23,
                        childHeight: 18,
                        childWidth: 18,
                        btnBackgroundColor: AppColors.primary,
                        assetImage: AppImages.idIcon,
                        onPressed: () {},
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'ID: ',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppFontSize.xxsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: voucherID,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: AppFontSize.xxsmall,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(5),
              if (code != null)
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    title: code,
                    fontSize: AppFontSize.xxsmall,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                ),
              const Gap(2)
            ],
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

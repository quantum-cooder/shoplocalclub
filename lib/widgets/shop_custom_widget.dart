import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/models/stamp_card_model.dart';
import 'package:shoplocalclubcard/utils/open_url.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ShopCustomWidget extends StatefulWidget {
  const ShopCustomWidget({
    super.key,
    required this.img,
    required this.shopName,
    required this.distance,
    required this.address,
    required this.isFavorite,
    required this.points,
    required this.aboutShop,
    required this.vouchers,
    required this.stampcardUsers,
    required this.isCheckIn,
    required this.shopCategory,
    required this.onFavoriteToggle,
    required this.onCheckInToggle,
    this.phone = '',
    this.website = '',
  });

  final String img,
      shopName,
      shopCategory,
      distance,
      address,
      points,
      aboutShop,
      phone,
      website;
  final List<Voucher> vouchers;
  final List<StampCardUser>? stampcardUsers;
  final bool isFavorite, isCheckIn;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onCheckInToggle;
  static List<int> freeOffers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  State<ShopCustomWidget> createState() => _ShopCustomWidgetState();
}

class _ShopCustomWidgetState extends State<ShopCustomWidget> {
  static late Size size;
  late bool isFavorite;
  late bool isCheckIn;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    isCheckIn = widget.isCheckIn;
  }

  void _toggleFavorite() async {
    widget.onFavoriteToggle();
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _toggleCheckIn() async {
    widget.onCheckInToggle();
    setState(() {
      isCheckIn = !isCheckIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.8),
              topRight: Radius.circular(9.8),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton.filled(
                    onPressed: widget.onFavoriteToggle,
                    icon: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      foregroundColor:
                          WidgetStateProperty.all(AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
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
              title: '${widget.points} points',
              textAlign: TextAlign.center,
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: customBodyText(widget.shopName)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: widget.shopCategory),
                Row(
                  children: [
                    const CustomText(title: 'Check-in  '),
                    Switch(
                      value: widget.isCheckIn,
                      onChanged: (_) => widget.onCheckInToggle(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 5,
            color: AppColors.grey.withOpacity(0.5),
            indent: 4,
            endIndent: 4,
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: CustomText(
              title: widget.distance,
              fontSize: AppFontSize.small,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: CustomText(
              title: widget.address,
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: Row(
              children: [
                CustomFilledBtn(
                  assetImage: AppImages.callImg,
                  onPressed: () async {
                    await openUrl('tel:${widget.phone}');
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
                    await openUrl(widget.website);
                  },
                ),
              ],
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: customBodyText('About us:'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19.0),
            child: CustomText(
              title: widget.aboutShop,
            ),
          ),
          const Gap(5),
          if (widget.vouchers.isNotEmpty)
            ListView.builder(
              itemCount: widget.vouchers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _buildVoucherWidget(
                voucherDescription: widget.vouchers[index].message ?? '',
                voucherExpiryDate:
                    widget.vouchers[index].expireDays?.toString() ?? '',
                voucherID: widget.vouchers[index].id?.toString() ?? '',
                voucherPrice: widget.vouchers[index].value?.toString() ?? '',
              ),
            ),
          if (widget.stampcardUsers!.isNotEmpty)
            _buidlShopOfferWidget(
                size: size, stampCardUsers: widget.stampcardUsers),
        ],
      ),
    );
  }

  _buidlShopOfferWidget({
    required Size size,
    required List<StampCardUser>? stampCardUsers,
  }) {
    return ListView.builder(
        itemCount: stampCardUsers!.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Divider(
                    color: AppColors.grey.withOpacity(0.3),
                  ),
                  const Gap(5),
                  CustomText(
                    title: stampCardUsers[index].description!,
                    fontSize: AppFontSize.medium,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  const Gap(5),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.1,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            AppImages.cafePlaceHolderImg,
                            fit: BoxFit.cover,
                            width: size.width * 0.23,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Buy 9 Coffee and get the 10th ',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: AppFontSize.xsmall,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'FREE',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: AppFontSize.small,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    height: size.height * 0.15,
                    child: GridView.builder(
                      itemCount: ShopCustomWidget.freeOffers.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          color: Colors.transparent,
                          child: CircleAvatar(
                              backgroundColor:
                                  ShopCustomWidget.freeOffers.length - 1 ==
                                          index
                                      ? AppColors.white
                                      : AppColors.primary,
                              child: ShopCustomWidget.freeOffers.length - 1 ==
                                      index
                                  ? Image.asset(AppImages.giftIcon)
                                  : CustomText(
                                      title:
                                          '0${ShopCustomWidget.freeOffers[index]}',
                                      color: AppColors.white,
                                      fontSize: AppFontSize.small,
                                      fontWeight: FontWeight.w400,
                                    )),
                        ),
                      ),
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
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Expires: ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: AppFontSize.xxsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: '25/07/24',
                                  style: TextStyle(
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
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'ID: ',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: AppFontSize.xxsmall,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: '1223',
                                  style: TextStyle(
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
            ));
  }

  Column _buildVoucherWidget({
    required String voucherDescription,
    required String voucherPrice,
    required String voucherExpiryDate,
    required String voucherID,
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
              const Gap(10),
              const DottedLineDivider(),
              const Gap(10),
              const CustomText(
                title:
                    'Thank you for your continued support, Please  accept this voucher as a token of our heartfelt gratitude and thank you for supporting local indie shops.',
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
              const Gap(10)
            ],
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

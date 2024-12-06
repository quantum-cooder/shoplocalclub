import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class CardMemberShipScreen extends StatefulWidget {
  const CardMemberShipScreen({
    super.key,
    required this.userName,
  });
  final String userName;

  @override
  State<CardMemberShipScreen> createState() => _CardMemberShipScreenState();
}

class _CardMemberShipScreenState extends State<CardMemberShipScreen> {
  late TextEditingController _nbrController;
  late Size size;
  late ValueNotifier<bool> _claimNotifier;
  late ValueNotifier<bool> _createNotifier;
  late ValueNotifier<String?> _newNumberNotifier;
  late final Future<bool> future;

  @override
  void initState() {
    super.initState();
    _nbrController = TextEditingController();
    _claimNotifier = ValueNotifier(false);
    _createNotifier = ValueNotifier(false);
    _newNumberNotifier = ValueNotifier(null);
    future = CardMembershipApis.doesCardExists();
  }

  @override
  void dispose() {
    super.dispose();
    _nbrController.dispose();
    _claimNotifier.dispose();
    _createNotifier.dispose();
    _newNumberNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build is called in card_member_ship_Screen');
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Card MemberShip',
        isIconNeeded: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: CustomText(
                        title: 'Something went wrong',
                      ),
                    );
                  }
                  return Column(
                    children: [
                      const Gap(10),
                      const CustomText(
                          title:
                              'If you have been given your unique Membership Number then enter it here and click \'Claim Your Card\'. If you do not have a membership number yet then click \'Create a New Membership Number button below to be allocated one.'),
                      const Gap(20),
                      Container(
                        width: double.infinity,
                        height: 200,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: ShapeDecoration(
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title: 'Loyalty Links',
                                      color: AppColors.white,
                                      fontSize: AppFontSize.large,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    Gap(5),
                                  ],
                                ),
                                Image.asset(
                                  AppImages.whiteLogo,
                                  width: 58.67,
                                  height: 66.50,
                                ),
                              ],
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: CustomText(
                                        title: widget.userName,
                                        color: AppColors.white,
                                        fontSize: AppFontSize.large,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Gap(5),
                                    SizedBox(
                                      width: size.width * 0.6,
                                      child: CustomTextField(
                                        controller: _nbrController,
                                        hintText: 'MemberShip Number',
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: 60.67,
                                  height: 60.50,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 2,
                                    vertical: 2,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Image.asset(
                                    AppImages.qrcode,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      ValueListenableBuilder(
                        valueListenable: _newNumberNotifier,
                        builder: (context, newNumber, child) =>
                            ValueListenableBuilder(
                          valueListenable: _claimNotifier,
                          builder: (context, isLoading, child) => CustomBtn(
                            btnTitle: newNumber != null
                                ? 'Continue'
                                : 'Claim your card',
                            isLoading: isLoading,
                            onPressed: () async {
                              if (newNumber == null) {
                                _claimNotifier.value = true;
                                await CardMembershipApis.claimCard(
                                    _nbrController.text.trim());

                                _claimNotifier.value = false;
                              } else {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.location,
                                  (route) => false,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _newNumberNotifier,
                        builder: (context, newNumber, child) {
                          return newNumber == null
                              ? Column(
                                  children: [
                                    const Gap(20),
                                    customBodyText('---- OR ----'),
                                    const Gap(20),
                                    ValueListenableBuilder(
                                      valueListenable: _createNotifier,
                                      builder: (context, isLoading, child) =>
                                          CustomBtn(
                                        btnTitle: 'Create a new number',
                                        isLoading: isLoading,
                                        onPressed: () async {
                                          _createNotifier.value = true;
                                          final newNbr =
                                              await CardMembershipApis
                                                  .makeCard();
                                          if (newNbr != null) {
                                            _nbrController.text = newNbr;
                                            _newNumberNotifier.value = newNbr;
                                          }
                                          _createNotifier.value = false;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink();
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

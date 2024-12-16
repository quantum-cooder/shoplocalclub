import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/user_profile_model.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static late Size size;
  static ValueNotifier<bool> isCheckedIn = ValueNotifier(true);
  final imgUrl2 =
      'https://cdn.pixabay.com/photo/2024/05/08/17/45/animal-8748794_1280.jpg';
  late String token;

  @override
  void initState() {
    super.initState();
    // StoreApiToken.deleteToke();
    UserApiToken.getToken().then((val) {
      token = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    final height = size.height;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        isLeadingNeeded: false,
      ),
      body: FutureBuilder(
        future: ProfileApi.getprofileData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(
              child: customBodyText('Error loading profile data'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            UserProfileModel userProfile = UserProfileModel.instance;
            log(userProfile.toString());
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
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
                                  CustomText(
                                    title: 'Membership Card',
                                    color: AppColors.white,
                                    fontSize: AppFontSize.small,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                      title: userProfile.name ?? 'Your name',
                                      color: AppColors.white,
                                      fontSize: AppFontSize.large,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Gap(5),
                                  CustomText(
                                    title: userProfile.membershipCard!.code!,
                                    color: AppColors.white,
                                    fontSize: AppFontSize.small,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Container(
                                width: 60.67,
                                height: 60.50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 4,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: builQrImage(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    customBodyText('Account Information'),
                    const Gap(5),
                    _builImgdTile(
                      height: height,
                      img: userProfile.avatarFullUrl ?? imgUrl2,
                      title: userProfile.name ?? 'User name',
                      email: userProfile.email ?? 'User email',
                    ),
                    const Gap(10),
                    _buildMenuTile(
                      assetImg: AppImages.radiusIcon,
                      title: 'Shop Search Radius',
                      trailing: userProfile.country!.distance.toString(),
                      height: height,
                    ),
                    const Gap(10),
                    _buildMenuTile(
                      assetImg: AppImages.globeprofileIcon,
                      title: 'Country',
                      trailing: userProfile.country!.name!,
                      height: height,
                    ),
                    const Gap(10),
                    _buildMenuTile(
                      assetImg: AppImages.postalCodeIcon,
                      title: 'Postal code',
                      trailing: userProfile.zipcode ?? 'Add Zip code',
                      height: height,
                    ),
                    const Gap(10),
                    _buildMenuTile(
                      assetImg: AppImages.passwordIcon,
                      title: 'Change Password',
                      trailing: '******',
                      height: height,
                      onTap: () => Navigator.pushNamed(
                          context, AppRoutes.reSetPwd,
                          arguments: <String>[
                            userProfile.email!,
                            token,
                          ]),
                    ),
                    const Gap(5),
                    _builImgdTile(
                      img: userProfile.avatarFullUrl ?? imgUrl2,
                      title: userProfile.name ?? 'User name',
                      email: userProfile.email ?? 'User email',
                      height: height,
                      hasSwitch: true,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        width: double.infinity,
                        height: height > 850 ? height * 0.11 : height * 0.15,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const CustomText(
                          title:
                              'We hope you enjoyed using the loyalty links mobile app. If you are a Business owner and wish to join Loyalty Links, please use our webapp',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Gap(5),
                    _buildMenuTile(
                      assetImg: AppImages.computer,
                      title: 'Go To Webapp',
                      titleColor: AppColors.primary,
                      trailing: '',
                      height: height,
                      onTap: () async => await openUrl(AppTexts.websiteUrl),
                    ),
                    const Gap(5),
                    _buildMenuTile(
                      assetImg: AppImages.computer,
                      title: 'Update Profile',
                      titleColor: AppColors.primary,
                      trailing: '',
                      height: height,
                      onTap: () async =>
                          Navigator.pushNamed(context, AppRoutes.updateProfile),
                    ),
                    const Gap(5),
                    _buildMenuTile(
                      assetImg: AppImages.logout,
                      title: 'Logout',
                      titleColor: AppColors.primary,
                      trailing: '',
                      height: height,
                      onTap: () async => await Authentication.logout(context),
                      iconColor: AppColors.primary,
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _builImgdTile({
    required double height,
    required String img,
    required String title,
    required String email,

    ///below check is applied to have switch as subtitle instead of email
    bool hasSwitch = false,
  }) {
    return Card(
      elevation: 3,
      child: Container(
        width: double.infinity,
        height: height > 850 ? height * 0.12 : height * 0.15,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                img,
                width: 115,
                height: 95,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CupertinoActivityIndicator();
                  }
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error_outline_sharp),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: title,
                    fontSize: AppFontSize.small,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  const Gap(5),
                  hasSwitch
                      ? Row(
                          children: [
                            const CustomText(
                              title: 'Check-in',
                              fontSize: AppFontSize.small,
                              fontWeight: FontWeight.w700,
                            ),
                            const Gap(5),
                            ValueListenableBuilder<bool>(
                              valueListenable: isCheckedIn,
                              builder: (context, value, child) => SizedBox(
                                height: 30,
                                child: FittedBox(
                                  child: Switch(
                                    value: isCheckedIn.value,
                                    onChanged: (newValue) {
                                      isCheckedIn.value = newValue;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Email:\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: AppFontSize.xsmall,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: email,
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required String assetImg,
    required String title,
    required String trailing,
    required double height,
    Color titleColor = AppColors.grey,
    Color iconColor = AppColors.grey,
    void Function()? onTap,
  }) {
    return Card(
      elevation: 3,
      child: SizedBox(
        height: height > 850 ? height * 0.06 : height * 0.08,
        width: double.infinity,
        child: ListTile(
          tileColor: AppColors.white,
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: Image.asset(
            assetImg,
            width: 30,
            height: 30,
          ),
          title: CustomText(
            title: title,
            fontSize: AppFontSize.xsmall,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    flex: 4,
                    child: CustomText(
                      title: trailing,
                      fontWeight: FontWeight.w400,
                    )),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                ),
                const Gap(15),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}

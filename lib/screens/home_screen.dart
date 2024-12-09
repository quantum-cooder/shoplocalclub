import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/categories_model.dart' as ca;
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/models/shop_model.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  static late Size size;

  late Future<void> fetchData;
  List<Location> locations = [];
  List<bool> checkedInList = [];
  List<bool> favShopList = [];
  List<ca.Category>? categories;

  @override
  void initState() {
    super.initState();
    locations.clear();
    checkedInList.clear();
    favShopList.clear();
    _searchController = TextEditingController();
    fetchData = _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      final token = await UserApiToken.getToken();
      // Fetch user profile
      await ProfileApi.getprofileData();
      final userProfile = UserProfileModel.instance;

      // Fetch categories and nearby shops
      await Future.wait([
        CategoriesApi.getAllCategories(),
        ShopApi.getNearByShops(
          token: token!,
          latitude: userProfile.latitude!,
          longitude: userProfile.longitude!,
        ),
      ]);

      categories = CategoriesModel.instance?.data?.categories;

      if (ShopModel.instance != null && ShopModel.instance!.result!) {
        locations = ShopModel.instance!.data?.locations ?? [];

        for (final location in locations) {
          final isFavorite = location.isFavorite != null;
          favShopList.add(isFavorite);

          // Assuming this checks for the current user's check-in status
          final isCheckedIn = await Authentication.checkInLocation(
            token: token,
            locationId: location.id!,
          );
          checkedInList.add(isCheckedIn);
        }
      }
    } catch (e) {
      log('Error fetching data: $e');
      handleError(error: e);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 200,
        actionPaddingFromRight: 15,
        leadingWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.homeVector),
            const Gap(20),
            const CustomText(
              title: 'Good morning',
              color: AppColors.white,
              fontSize: AppFontSize.medium,
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: CustomText(title: 'Error fetching data, please try again'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      hintText: 'Search any Product..',
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      suffixIcon: const Icon(
                        Icons.mic_none,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customBodyText('Categories'),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.categories,
                              arguments: categories ?? [],
                            ),
                            child: const CustomText(title: 'See All >'),
                          ),
                        ],
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        height: 90,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories?.length ?? 0,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.categories,
                              ),
                              child: CustomContainer(
                                containerTitle: categories?[index].title ?? '',
                                avatarBgColor: const Color(0xffFFF6E3),
                                imageAsset:
                                    AppImages.allCategoriesImages[index],
                                index: index,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: customBodyText('All Shops'),
                ),
                const Gap(10),
                if (locations.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19.0),
                    child: ListView.builder(
                      itemCount: locations.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        final shop = location.shop;

                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ShopCustomWidget(
                            img: shop?.logoFullUrl ?? '',
                            shopName: shop?.name?.cleanName() ?? '',
                            shopCategory: shop?.categoryId ?? "",
                            distance:
                                '${location.distanceKm?.toStringAsFixed(2)} km',
                            address: location.address?.cleanName() ?? '',
                            isFavorite: favShopList[index],
                            isCheckIn: checkedInList[index],
                            phone: shop?.phone ?? '',
                            website: shop?.website ?? '',
                            points: location.activePoints ?? "0",
                            aboutShop: shop?.description?.cleanName() ?? '',
                            vouchers: const [],
                            stampcardUsers: const [],
                          ),
                        );
                      },
                    ),
                  ),
                if (locations.isEmpty)
                  const Center(
                    child: CustomText(title: 'No shop found'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

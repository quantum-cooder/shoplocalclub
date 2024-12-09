import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/categories_model.dart' as ca;
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/models/shop_model.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
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
  List<ca.Category>? categories;
  late ShopProvider shopProvider;
  late String? token;

  @override
  void initState() {
    super.initState();
    locations.clear();
    shopProvider = Provider.of<ShopProvider>(context, listen: false);

    _searchController = TextEditingController();
    fetchData = _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      token = await UserApiToken.getToken();
      await ProfileApi.getprofileData();
      final userProfile = UserProfileModel.instance;

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
        shopProvider.setLocations(ShopModel.instance!.data?.locations ?? []);
      }
    } catch (e) {
      log('Error fetching _fetchAllData : $e');
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
                      key: const ValueKey(
                          'locations_list'), // Helps ListView recognize its state
                      itemCount: locations.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Consumer<ShopProvider>(
                          builder: (context, provider, child) {
                            final location = provider.locations[index];
                            return ShopCustomWidget(
                              img: location.shop?.logoFullUrl ?? '',
                              shopName: location.shop?.name?.cleanName() ?? '',
                              shopCategory: location.shop?.categoryId ?? "",
                              distance:
                                  '${location.distanceKm?.toStringAsFixed(2)} km',
                              address: location.address?.cleanName() ?? '',
                              isFavorite: location.isFavorite != null,
                              isCheckIn: location.isCheckedIn!,
                              points: location.activePoints ?? "0",
                              aboutShop:
                                  location.shop?.description?.cleanName() ?? '',
                              onFavoriteToggle: () async {
                                await provider.toggleFavorite(
                                    token: token!, location: location);
                              },
                              onCheckInToggle: () async {
                                await provider.toggleCheckIn(
                                    token: token!, location: location);
                              },
                              vouchers: const [],
                              stampcardUsers: const [],
                            );
                          },
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

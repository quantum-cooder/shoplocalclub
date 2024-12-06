import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/apis/categories_api.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
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
  Shop? shop;
  List<Shop> shops = [];
  bool isCheckedIn = false;
  List<bool> checkedInList = [];
  bool isFavShop = false;
  List<bool> favShopList = [];
  List<Category>? categories;
  List<Voucher>? vouchers;

  @override
  void initState() {
    super.initState();
    // Authentication.logout(context);
    shops.clear();
    checkedInList.clear();
    favShopList.clear();
    _searchController = TextEditingController();
    fetchData = _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      final token = await UserApiToken.getToken();
      await Future.wait([
        CategoriesApi.getAllCategories(),
        ShopApi.getShops(token: token!),
      ]);

      categories = CategoriesModel.instance?.data?.categories;

      if (ShopModel.instance != null && ShopModel.instance!.result!) {
        shop = ShopModel.instance?.data?.shop;

        if (shop != null) {
          shops.add(shop!);
          isFavShop = await AddRemoveShopFromFav.addShopToFav(
            token: token,
            shopId: shop!.id!,
          );
          favShopList.add(isFavShop);
          isCheckedIn = await Authentication.checkInLocation(
            token: token,
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
                if (shops.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19.0),
                    child: ListView.builder(
                      itemCount: shops.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ShopCustomWidget(
                        img: shop!.logoFullUrl ?? '',
                        shopName: shop!.name ?? '',
                        distance: shop!.description
                                ?.replaceAll('<p>', '')
                                .replaceAll('</p>', '') ??
                            '',
                        address: shop!.description
                                ?.replaceAll('<p>', '')
                                .replaceAll('</p>', '') ??
                            '',
                        isFavorite: favShopList[index],
                        isCheckIn: checkedInList[index],
                        phone: shop!.phone ?? '',
                        website: shop!.website ?? '',
                        points: vouchers?.first.minPoints?.toString() ?? '0',
                        aboutShop: shop!.description
                                ?.replaceAll('<p>', '')
                                .replaceAll('</p>', '') ??
                            '',
                        vouchers: vouchers ?? [],
                        stampcardUsers: const [],
                      ),
                    ),
                  ),
                if (shops.isEmpty)
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

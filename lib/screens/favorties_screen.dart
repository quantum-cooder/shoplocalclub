import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/providers/favorite_shops_provider.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  late Future<void> fetchFavorites;
  String? token;

  @override
  void initState() {
    super.initState();
    fetchFavorites = _fetchFavoriteShops();
  }

  Future<void> _fetchFavoriteShops() async {
    try {
      token = await UserApiToken.getToken();
      final userProfile = UserProfileModel.instance;

      await ShopApi.getFavoriteShops(
        token: token!,
        latitude: userProfile.latitude!,
        longitude: userProfile.longitude!,
      );

      if (FavoriteShopsModel.hasData &&
          FavoriteShopsModel.instance!.result == true) {
        final favoriteLocations =
            FavoriteShopsModel.instance!.data?.locations ?? [];
        Provider.of<FavoriteShopsProvider>(context, listen: false)
            .setLocations(favoriteLocations);
      }
    } catch (e) {
      log('Error fetching favorite shops: $e');
      handleError(error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Favorite Shops',
        isLeadingNeeded: false,
      ),
      body: FutureBuilder(
        future: fetchFavorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return const Center(
              child: CustomText(
                  title: 'Error fetching favorites, please try again'),
            );
          }

          return Consumer<FavoriteShopsProvider>(
            builder: (context, provider, child) {
              final favoriteLocations = provider.locations;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                  child: favoriteLocations.isNotEmpty
                      ? Column(
                          children: [
                            ListView.builder(
                              key: const ValueKey('favorite_locations_list'),
                              itemCount: favoriteLocations.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final location = favoriteLocations[index];
                                final shop = location.shop;

                                return ShopCustomWidget(
                                  img: shop.logoFullUrl,
                                  shopName: shop.name,
                                  shopCategory: shop.category.title,
                                  distance:
                                      location.distanceKm.toStringAsFixed(2),
                                  address: location.address,
                                  isFavorite: location.isFavorite != null,
                                  isCheckIn: location.isCheckedIn,
                                  aboutShop: shop.description,
                                  phone: shop.phone,
                                  website: shop.website,
                                  onFavoriteToggle: () async {
                                    await provider.toggleFavorite(
                                      token: token!,
                                      location: location,
                                    );
                                  },
                                  onCheckInToggle: () async {
                                    await provider.toggleCheckIn(
                                      token: token!,
                                      location: location,
                                    );
                                  },
                                  stampcardUsers: const [],
                                  activePoints: location.activePoints ?? "0",
                                );
                              },
                            ),
                          ],
                        )
                      : const Center(
                          child: CustomText(title: 'No favorite shops found'),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';

class FavoriteShopsProvider with ChangeNotifier {
  List<FavShopsLocation> _locations = [];

  List<FavShopsLocation> get locations => _locations;

  void setLocations(List<FavShopsLocation> locations) {
    _locations = locations;
    notifyListeners();
  }

  void updateLocation(FavShopsLocation updatedLocation) {
    final index = _locations.indexWhere((loc) => loc.id == updatedLocation.id);
    if (index != -1) {
      _locations[index] = updatedLocation;
      log('Location updated: ${updatedLocation.id}');
      notifyListeners();
    }
  }

  Future<void> toggleFavorite({
    required String token,
    required FavShopsLocation location,
  }) async {
    try {
      if (location.isFavorite != null) {
        // Remove from favorites
        await AddRemoveShopFromFavApi.removeShopfromFav(
          token: token,
          shopId: location.shopId.toString(),
        );
        location.isFavorite = null;
        log("toggleFavorite: Removed shopid = ${location.shopId}ShopFromFav");
      } else {
        // Add to favorites
        await AddRemoveShopFromFavApi.addShopToFav(
          token: token,
          shopId: location.shopId,
          locationId: location.id,
        );
        location.isFavorite = FavShopsIsFavorite(
          id: DateTime.now().millisecondsSinceEpoch,
          userId: 1,
          shopId: location.shopId,
          locationId: location.id,
          createdAt: DateTime.now().toString(),
          updatedAt: DateTime.now().toString(),
        );
      }
      log("toggleFavorite: added shopId ${location.shopId} ShopFromFav");

      updateLocation(location);
    } catch (e) {
      log('Error toggling favorite: $e');
    }
  }

  Future<void> toggleCheckIn({
    required String token,
    required FavShopsLocation location,
  }) async {
    try {
      if (location.isCheckedIn == true) {
        await CheckedInOutApi.checkOutLocation(
          token: token,
          locationId: location.id,
        );
        log("toggleFavorite : checked out location for location.id! = ${location.id}");
        location.isCheckedIn = false;
      } else {
        await CheckedInOutApi.checkInLocation(
          token: token,
          locationId: location.id,
        );
        log("toggleFavorite : checked in location for location.id! = ${location.id}");

        location.isCheckedIn = true;
      }
      updateLocation(location);
    } catch (e) {
      log('Error toggling check-in: $e');
    }
  }
}

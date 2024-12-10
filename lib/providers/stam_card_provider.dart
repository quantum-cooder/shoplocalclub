import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/stamp_card_model.dart';

class StampCardProvider with ChangeNotifier {
  List<StampCardUser> _stampCards = [];

  List<StampCardUser> get stampCards => _stampCards;

  void setStampCards(List<StampCardUser> cards) {
    _stampCards = cards;
    notifyListeners();
  }

  Future<void> toggleCheckIn({
    required String token,
    required int locationId,
    required bool isCheckIn,
  }) async {
    if (isCheckIn) {
      await CheckedInOutApi.checkOutLocation(
        token: token,
        locationId: locationId,
      );
    } else {
      await CheckedInOutApi.checkInLocation(
        token: token,
        locationId: locationId,
      );
    }
    notifyListeners();
  }

  Future<void> toggleFavorite({
    required String token,
    required int shopId,
    required int locationId,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      await AddRemoveShopFromFavApi.removeShopfromFav(
          token: token, shopId: shopId.toString());
    } else {
      await AddRemoveShopFromFavApi.addShopToFav(
        token: token,
        shopId: shopId,
        locationId: locationId,
      );
    }
    notifyListeners();
  }
}

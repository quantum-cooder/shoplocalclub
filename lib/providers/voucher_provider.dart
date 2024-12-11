import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/models/models.dart';

class VoucherProvider with ChangeNotifier {
  List<MembershipCardVoucher> _memberShipCardVouchers = [];

  List<MembershipCardVoucher> get memberShipCardVouchers =>
      _memberShipCardVouchers;

  void setMemberShipCardVouchers(
      List<MembershipCardVoucher> memberShipCardVouchers) {
    _memberShipCardVouchers = memberShipCardVouchers;
    notifyListeners();
  }

  Future<void> toggleCheckIn({
    required String token,
    required int locationId,
    required bool isCheckIn,
    required String memberShipVoucherCode,
  }) async {
    log("before toggleCheckIn: value for locationId $locationId = $isCheckIn");

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

    // Update the local state
    final index = _memberShipCardVouchers.indexWhere(
      (memberShipCardVoucher) =>
          memberShipCardVoucher.code == memberShipVoucherCode,
    );
    if (index != -1) {
      _memberShipCardVouchers[index].shop?.closestLocation?.isCheckedIn =
          !isCheckIn;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite({
    required String token,
    required int shopId,
    required int locationId,
    required bool isFavorite,
    required String memberShipVoucherCode,
  }) async {
    log("before toggleFavorite: value for $locationId and $shopId = $isFavorite");

    if (isFavorite) {
      await AddRemoveShopFromFavApi.removeShopfromFav(
        token: token,
        shopId: shopId.toString(),
      );
    } else {
      await AddRemoveShopFromFavApi.addShopToFav(
        token: token,
        shopId: shopId,
        locationId: locationId,
      );
    }

    // Update the local state
    final index = _memberShipCardVouchers.indexWhere(
      (memberShipCardVoucher) =>
          memberShipCardVoucher.code == memberShipVoucherCode,
    );
    if (index != -1) {
      _memberShipCardVouchers[index].isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}

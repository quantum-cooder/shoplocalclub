import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/models/shop_processing_model.dart';

class ShopProcessingProvider extends ChangeNotifier {
  ShopProcessingModel? _shopProcessingModel;
  ShopProcessingShop? _selectedShop;

  ShopProcessingModel? get shopProcessingModel => _shopProcessingModel;
  ShopProcessingShop? get selectedShop => _selectedShop;

  void updateShops(ShopProcessingModel model) {
    _shopProcessingModel = model;
    _selectedShop =
        model.data?.shops.isNotEmpty == true ? model.data!.shops.first : null;
    notifyListeners();
  }

  void updateSelectedShop(ShopProcessingShop shop) {
    _selectedShop = shop;
    notifyListeners();
  }
}

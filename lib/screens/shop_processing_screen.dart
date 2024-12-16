import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/apis/shop_processing_api.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/shop_processing_model.dart';
import 'package:shoplocalclubcard/providers/shop_processing_provider.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ShopProcessingScreen extends StatefulWidget {
  const ShopProcessingScreen({super.key});

  @override
  State<ShopProcessingScreen> createState() => _ShopProcessingScreenState();
}

class _ShopProcessingScreenState extends State<ShopProcessingScreen> {
  late Future<ShopProcessingModel?> _futureShops;

  @override
  void initState() {
    super.initState();
    _futureShops = _loadShops();
  }

  Future<ShopProcessingModel?> _loadShops() async {
    final response = await ShopProcessingApi.getShopsOperatedByUser();
    if (response != null) {
      // Update provider only after data is fetched
      Provider.of<ShopProcessingProvider>(context, listen: false)
          .updateShops(response);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Processing"),
      ),
      body: FutureBuilder<ShopProcessingModel?>(
        future: _futureShops,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Error loading shops."));
          }

          return Consumer<ShopProcessingProvider>(
            builder: (context, provider, _) {
              final shops = provider.shopProcessingModel?.data?.shops ?? [];
              final selectedShop = provider.selectedShop;

              if (shops.isEmpty) {
                return const Center(child: Text("No shops available."));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    const CustomText(
                      title:
                          "Processing screen allows you to process stamp cards and vouchers for your shop. Please start by selecting a store and selecting a location you wish to administrate.",
                    ),
                    const Gap(10),

                    // Dropdown for selecting a shop
                    DropdownButton<ShopProcessingShop>(
                      value: selectedShop,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      isExpanded: true,
                      onChanged: (shop) {
                        if (shop != null) {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            provider.updateSelectedShop(shop);
                          });
                        }
                      },
                      items: shops.map((shop) {
                        return DropdownMenuItem<ShopProcessingShop>(
                          value: shop,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              title: shop.name,
                              color: Colors.black,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Shop image
                    if (selectedShop?.logoFullUrl != null) ...[
                      const Gap(10),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: selectedShop!.logoFullUrl,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator.adaptive()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                      const Gap(10),
                    ],
                    const Gap(10),

                    customBodyText('Shop Locations'),
                    const Gap(10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedShop?.locations.length ?? 0,
                        itemBuilder: (context, index) {
                          final location = selectedShop!.locations[index];
                          return _buildTile(
                            title: location.name,
                            description: location.address,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  _buildTile({
    required String title,
    required String description,
  }) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        title: customBodyText(title),
        subtitle: CustomText(
          title: description,
          color: AppColors.grey,
          fontSize: AppFontSize.xsmall,
          fontWeight: FontWeight.w400,
        ),
        trailing: InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.operateLocation),
          child: const CustomText(
            title: 'OPERATE',
            color: AppColors.primary,
            fontSize: AppFontSize.medium,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

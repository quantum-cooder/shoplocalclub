// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/apis/stamp_card_api.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/stamp_card_model.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class StampCardsScreen extends StatefulWidget {
  const StampCardsScreen({super.key});

  @override
  State<StampCardsScreen> createState() => _StampCardsScreenState();
}

class _StampCardsScreenState extends State<StampCardsScreen> {
  final ValueNotifier<String> _selectedFilter =
      ValueNotifier<String>('Near Me');
  late Future<List<StampCardUser>> _futureStampCards;
  late String token;

  @override
  void initState() {
    super.initState();

    _selectedFilter.addListener(_onFilterChanged);

    // Initialize _futureStampCards with a default filter
    _futureStampCards = _fetchStampCards(isArchived: false);

    // Optionally fetch initial data to update the provider
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await UserApiToken.getToken() ?? '';
      final cards = await _futureStampCards;
      Provider.of<StampCardProvider>(context, listen: false)
          .setStampCards(cards);
    });
  }

  @override
  void dispose() {
    _selectedFilter.removeListener(_onFilterChanged);
    _selectedFilter.dispose();
    super.dispose();
  }

  Future<List<StampCardUser>> _fetchStampCards(
      {required bool isArchived}) async {
    final response =
        await StampCardApi.getUsersStampCards(isArchived: isArchived);
    // Ensure `offers` and `vouchers` are included in the StampCardUser instances
    return response;
  }

  void _onFilterChanged() {
    final filter = _selectedFilter.value;
    final isArchived = filter == 'Archived';
    setState(() {
      _futureStampCards = _fetchStampCards(isArchived: isArchived);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Stamp Cards',
        isLeadingNeeded: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            const Gap(10),
            _buildFilters(),
            const Gap(10),
            Expanded(
              child: FutureBuilder<List<StampCardUser>>(
                future: _futureStampCards,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Stamp Cards Found'));
                  } else {
                    return ValueListenableBuilder<String>(
                      valueListenable: _selectedFilter,
                      builder: (context, filter, _) {
                        final filteredCards = _applyFilters(
                          snapshot.data!,
                          filter,
                        );
                        return Consumer<StampCardProvider>(
                          builder: (context, stampCardProvider, _) {
                            final filteredCards = _applyFilters(
                              stampCardProvider.stampCards,
                              _selectedFilter.value,
                            );
                            if (filteredCards.isEmpty) {
                              return const Center(
                                  child: Text('No Stamp Cards Found'));
                            }
                            return ListView.builder(
                              itemCount: filteredCards.length,
                              itemBuilder: (context, index) {
                                final stampCardUser = filteredCards[index];
                                return ShopCustomWidget(
                                  img: stampCardUser.shop?.logoFullUrl ??
                                      AppImages.cafePlaceHolderImg,
                                  shopName: stampCardUser.shop?.name ?? '',
                                  isCheckIn: stampCardUser
                                          .shop?.closestLocation?.isCheckedIn ??
                                      false,
                                  distance: stampCardUser
                                          .shop?.closestLocation?.distanceKm
                                          ?.toStringAsFixed(2) ??
                                      '0',
                                  address: stampCardUser
                                          .shop?.closestLocation?.address ??
                                      'No address available',
                                  activePoints:
                                      stampCardUser.activePoints ?? '0',
                                  aboutShop:
                                      stampCardUser.shop?.description ?? '',
                                  shopCategory:
                                      stampCardUser.shop?.category?.title ?? '',
                                  stampcardUsers: [stampCardUser],
                                  isFavorite:
                                      stampCardUser.shop?.isFavorite ?? false,
                                  onCheckInToggle: () async {
                                    final isCheckIn = stampCardUser.shop
                                            ?.closestLocation?.isCheckedIn ??
                                        false;
                                    await Provider.of<StampCardProvider>(
                                            context,
                                            listen: false)
                                        .toggleCheckIn(
                                            token:
                                                token, // Replace with actual token
                                            locationId: stampCardUser
                                                .shop!.closestLocation!.shopId!,
                                            isCheckIn: isCheckIn);
                                  },
                                  onFavoriteToggle: () async {
                                    final isFavorite =
                                        stampCardUser.shop?.isFavorite ?? false;
                                    await Provider.of<StampCardProvider>(
                                            context,
                                            listen: false)
                                        .toggleFavorite(
                                            token:
                                                token, // Replace with actual token
                                            shopId: stampCardUser.shop!.id!,
                                            locationId: stampCardUser.shop!.id!,
                                            isFavorite: isFavorite);
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    const filters = ['Near Me', 'A-Z', 'Active', 'Archived'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: filters.map((filter) {
        return GestureDetector(
          onTap: () {
            _selectedFilter.value = filter;
          },
          child: ValueListenableBuilder<String>(
            valueListenable: _selectedFilter,
            builder: (context, selectedFilter, _) {
              final isSelected = filter == selectedFilter;
              return Text(
                filter,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isSelected ? Colors.red : Colors.black,
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  List<StampCardUser> _applyFilters(
    List<StampCardUser> stampCards,
    String filter,
  ) {
    switch (filter) {
      case 'Near Me':
        return stampCards
            .where((card) =>
                (card.shop?.closestLocation?.distanceKm ?? double.infinity) <=
                5.0)
            .toList();
      case 'A-Z':
        return stampCards
          ..sort((a, b) => (a.shop?.name ?? '').compareTo(b.shop?.name ?? ''));
      case 'Active':
        return stampCards.where((card) => card.isActive == 1).toList();
      case 'Archived':
        return stampCards; // Data is already filtered by the API
      default:
        return stampCards;
    }
  }
}

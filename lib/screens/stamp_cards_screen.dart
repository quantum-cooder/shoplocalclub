import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/apis/stamp_card_api.dart';
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
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  late String token;
  late StampCardProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<StampCardProvider>(context, listen: false);
    _selectedFilter.addListener(_onFilterChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await UserApiToken.getToken() ?? '';
      await _fetchAndSetStampCards(isArchived: false); // Default filter
    });
  }

  @override
  void dispose() {
    _selectedFilter.removeListener(_onFilterChanged);
    _selectedFilter.dispose();
    _isLoading.dispose(); // Dispose the loading notifier
    super.dispose();
  }

  Future<void> _fetchAndSetStampCards({required bool isArchived}) async {
    _isLoading.value = true;
    final response =
        await StampCardApi.getUsersStampCards(isArchived: isArchived);
    provider.setStampCards(response);
    _isLoading.value = false;
  }

  void _onFilterChanged() async {
    final filter = _selectedFilter.value;
    final isArchived = filter == 'Archived';
    await _fetchAndSetStampCards(isArchived: isArchived);
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
              child: ValueListenableBuilder<bool>(
                valueListenable: _isLoading, // Listen to loading state
                builder: (context, isLoading, _) {
                  if (isLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  return Consumer<StampCardProvider>(
                    builder: (context, provider, child) {
                      final stampCards = provider.stampCards;

                      if (stampCards.isEmpty) {
                        return const Center(
                            child: Text('No Stamp Cards Found'));
                      }

                      return ListView.builder(
                        itemCount: stampCards.length,
                        itemBuilder: (context, index) {
                          final stampCardUser = stampCards[index];
                          return ShopCustomWidget(
                            img: stampCardUser.shop?.logoFullUrl ?? "",
                            shopName: stampCardUser.shop?.name ?? '',
                            distance: stampCardUser
                                    .shop?.closestLocation?.distanceKm
                                    ?.toStringAsFixed(2) ??
                                '0',
                            address:
                                stampCardUser.shop?.closestLocation?.address ??
                                    'No address available',
                            activePoints: stampCardUser.activePoints ?? '0',
                            aboutShop: stampCardUser.shop?.description ?? '',
                            shopCategory:
                                stampCardUser.shop?.category?.title ?? '',
                            isCheckIn: stampCardUser
                                    .shop?.closestLocation?.isCheckedIn ??
                                false,
                            isFavorite: stampCardUser.shop?.isFavorite ?? false,
                            website: stampCardUser.shop?.website ?? "",
                            phone: stampCardUser.shop?.phone ?? "",
                            stampcardUsers: [stampCardUser],
                            onCheckInToggle: () async {
                              await provider.toggleCheckIn(
                                token: token,
                                locationId:
                                    stampCardUser.shop!.closestLocation!.id!,
                                isCheckIn: stampCardUser
                                    .shop!.closestLocation!.isCheckedIn!,
                              );
                            },
                            onFavoriteToggle: () async {
                              await provider.toggleFavorite(
                                token: token,
                                shopId: stampCardUser.shop!.id!,
                                locationId:
                                    stampCardUser.shop!.closestLocation!.id!,
                                isFavorite: stampCardUser.shop!.isFavorite!,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
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
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/providers/providers.dart';
import 'package:shoplocalclubcard/utils/utils.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  final ValueNotifier<String> _selectedFilter =
      ValueNotifier<String>('Near Me');
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  late String token;
  late VoucherProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<VoucherProvider>(context, listen: false);
    _selectedFilter.addListener(_onFilterChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await UserApiToken.getToken() ?? '';
      await _fetchAndSetStampCards(isArchived: false);
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
        await VoucherApi.getVouchersForShop(isArchived: isArchived);
    provider.setMemberShipCardVouchers(response!);
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
        title: 'Voucher',
        isLeadingNeeded: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const Gap(10),
                  _buildFilters(),
                  const Gap(10),
                  Consumer<VoucherProvider>(
                    builder: (context, provider, child) {
                      final memberShipCardVouchers =
                          provider.memberShipCardVouchers;
                      if (memberShipCardVouchers.isEmpty) {
                        return const Center(child: Text('No Vouchers Found'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: memberShipCardVouchers.length,
                        itemBuilder: (context, index) {
                          final voucher = memberShipCardVouchers[index];
                          return ShopCustomWidget(
                            img: voucher.shop?.logoFullUrl ?? "",
                            shopName: voucher.shop?.name ?? '',
                            distance: voucher.shop?.closestLocation?.distanceKm
                                    ?.toStringAsFixed(2) ??
                                '0',
                            address: voucher.shop?.closestLocation?.address ??
                                'No address available',
                            activePoints: voucher.activePoints ?? '0',
                            aboutShop: voucher.shop?.description ?? '',
                            shopCategory:
                                voucher.shop?.categoryId?.toString() ?? '',
                            isCheckIn:
                                voucher.shop?.closestLocation?.isCheckedIn ??
                                    false,
                            isFavorite: voucher.isFavorite ?? false,
                            website: voucher.shop?.website ?? "",
                            phone: voucher.shop?.phone ?? "",
                            stampcardUsers: const [],
                            membershipCardVouchers: [
                              memberShipCardVouchers[index]
                            ],
                            onCheckInToggle: () async {
                              await provider.toggleCheckIn(
                                token: token,
                                locationId: voucher.shop!.closestLocation!.id!,
                                isCheckIn:
                                    voucher.shop!.closestLocation!.isCheckedIn!,
                                memberShipVoucherCode: voucher.code!,
                              );
                            },
                            onFavoriteToggle: () async {
                              await provider.toggleFavorite(
                                token: token,
                                shopId: voucher.shop!.id!,
                                locationId: voucher.shop!.closestLocation!.id!,
                                isFavorite: voucher.isFavorite!,
                                memberShipVoucherCode: voucher.code!,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return const SizedBox.shrink(); // Invisible when not loading
            },
          ),
        ],
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

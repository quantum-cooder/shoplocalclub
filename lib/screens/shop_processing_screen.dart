import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class ShopProcessingScreen extends StatelessWidget {
  const ShopProcessingScreen({super.key});
  static late Size size;
  static String selectedValue = '1';
  static DropdownMenuItem<dynamic> item1 = DropdownMenuItem(
      value: '1', child: customBodyText('Coffee Shop - Sample'));
  static DropdownMenuItem<dynamic> item2 =
      DropdownMenuItem(value: '2', child: customBodyText('Coffee Shop - Beta'));
  static DropdownMenuItem<dynamic> item3 =
      DropdownMenuItem(value: '3', child: customBodyText('Stable'));
  static DropdownMenuItem<dynamic> item4 =
      DropdownMenuItem(value: '4', child: customBodyText('Deployed'));
  static List<DropdownMenuItem<dynamic>>? itemsList = [
    item1,
    item2,
    item3,
    item4
  ];

  static ValueNotifier<String> newValurNotifier = ValueNotifier(selectedValue);
  final imgUrl =
      'https://images.pexels.com/photos/26146666/pexels-photo-26146666/free-photo-of-a-small-bird-is-standing-on-the-ground.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Shop Processing',
        isLeadingNeeded: false,
        // actionOnPressed: () =>
        //     Navigator.pushNamed(context, AppRoutes.favorties),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
              customBodyText('Shop Selection'),
              Card(
                elevation: 4,
                child: Container(
                  width: double.infinity,
                  height: height > 850 ? height * 0.2 : height * 0.25,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: ShapeDecoration(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: newValurNotifier,
                        builder: (context, value, child) =>
                            DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: newValurNotifier.value,
                            items: itemsList,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 30,
                            ),
                            padding: EdgeInsets.zero,
                            onChanged: (newValue) {
                              newValurNotifier.value = newValue;
                            },
                          ),
                        ),
                      ),
                      Divider(
                        color: AppColors.grey.withOpacity(0.5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              imgUrl,
                              width: 115,
                              height: 95,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const CupertinoActivityIndicator();
                                }
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error_outline_sharp),
                            ),
                          ),
                          const Gap(10),
                          const Expanded(
                            child: CustomText(
                              title: 'New Jersy Shop',
                              color: AppColors.grey,
                              fontSize: AppFontSize.medium,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              customBodyText('Shop Locations'),
              const Gap(10),
              _buildTile(title: 'Marple', description: 'Marple,Sk6 6BD'),
              const Gap(10),
              _buildTile(title: 'Warrington', description: 'Marple,Sk6 6BD'),
              const Gap(10),
              _buildTile(title: 'Oswestry', description: 'Marple,Sk6 6BD'),
              const Gap(10),
              _buildTile(title: 'Chester', description: 'Marple,Sk6 6BD'),
            ],
          ),
        ),
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
          vertical: 5,
          horizontal: 20,
        ),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: customBodyText(title),
            ),
            Expanded(
              child: CustomText(
                title: description,
                color: AppColors.grey,
                fontSize: AppFontSize.xsmall,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        trailing: const CustomText(
          title: 'OPERATE',
          color: AppColors.primary,
          fontSize: AppFontSize.medium,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

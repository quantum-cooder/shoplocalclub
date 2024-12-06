import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/models/models.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({
    super.key,
    required this.categories,
  });
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Categories',
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: CategoriesModel.instance?.data?.categories?.length ?? 0,
        padding: const EdgeInsets.all(19),
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.stampCards,
          ),
          child: CustomContainer(
            avatarBgColor: AppColors.grey,
            imageAsset: AppImages.allCategoriesImages[index],
            containerTitle: categories[index].title!,
            index: index + 1,
            isBadgeNeeded: true,
          ),
        ),
      ),
    );
  }
}

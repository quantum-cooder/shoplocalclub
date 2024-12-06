import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoplocalclubcard/constants/constants.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static ValueNotifier<bool> isCheckedIn = ValueNotifier(true);
  final imgUrl =
      'https://images.pexels.com/photos/26146666/pexels-photo-26146666/free-photo-of-a-small-bird-is-standing-on-the-ground.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';
  final imgUrl2 =
      'https://cdn.pixabay.com/photo/2024/05/08/17/45/animal-8748794_1280.jpg';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notifications',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const Gap(10),
            Card(
              elevation: 3,
              child: Container(
                width: double.infinity,
                height: height > 850 ? height * 0.12 : height * 0.15,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customBodyText('Allow Notifications'),
                        const CustomText(
                          title:
                              'Please allow notifications \nto get customized notifications',
                          color: AppColors.grey,
                          fontSize: AppFontSize.xsmall,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isCheckedIn,
                      builder: (context, value, child) => SizedBox(
                        height: 30,
                        child: FittedBox(
                          child: Switch(
                            value: isCheckedIn.value,
                            onChanged: (newValue) {
                              isCheckedIn.value = newValue;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(5),
            _buildTile(
              height: height,
              title: '03 Shops',
              description: 'Lorem ipsum dolor sit amet, consetetur sadi',
              img: imgUrl,
            ),
            const Gap(5),
            _buildTile(
              height: height,
              title: '03 Shops',
              description: 'Lorem ipsum dolor sit amet, consetetur sadi',
              img: imgUrl2,
            ),
            const Gap(5),
            _buildTile(
              height: height,
              title: '03 Shops',
              description: 'Lorem ipsum dolor sit amet, consetetur sadi',
              img: imgUrl,
            ),
            const Gap(5),
            _buildTile(
              height: height,
              title: '03 Shops',
              description: 'Lorem ipsum dolor sit amet, consetetur sadi',
              img: imgUrl2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required double height,
    required String img,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 3,
      child: Container(
        width: double.infinity,
        height: height > 850 ? height * 0.12 : height * 0.15,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 15,
        ),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                img,
                width: 115,
                height: 95,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
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
            const Gap(5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customBodyText(title),
                  CustomText(
                    title: description,
                    fontSize: AppFontSize.xxsmall,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

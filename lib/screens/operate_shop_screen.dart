import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalclubcard/apis/apis.dart';
import 'package:shoplocalclubcard/widgets/widgets.dart';

class OperateShopScreen extends StatefulWidget {
  const OperateShopScreen({
    super.key,
    required this.list,
  });
  final List<dynamic> list;
  @override
  State<OperateShopScreen> createState() => _OperateShopScreenState();
}

class _OperateShopScreenState extends State<OperateShopScreen> {
  late Future _future;
  @override
  void initState() {
    super.initState();
    log("list received from constructor = ${widget.list}");
    _future = _fetchData();
  }

  _fetchData() async {
    await Future.wait(
      [
        ShopProcessingApi.getSpecificShop(widget.list.first),
        ShopProcessingApi.hasCheckedInSpecificShop(widget.list.first),
        ShopProcessingApi.getShopOperatorUserData(widget.list[1]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BackButton(),
              CircleAvatar(
                child: CachedNetworkImage(imageUrl: "imageUrl"),
              ),
            ],
          ),
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customBodyText(
                "Name",
                color: Colors.white,
              ),
              CustomText(
                title: "00000000000",
                color: Colors.white,
              )
            ],
          ),
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (!snapshot.hasData) {
              return Center(child: CustomText(title: "No data found"));
            } else if (snapshot.hasError) {
              return Center(
                child:
                    CustomText(title: "Something went wrong, please try again"),
              );
            }
            return Center(child: CustomText(title: "data is found"));
          },
        ));
  }
}

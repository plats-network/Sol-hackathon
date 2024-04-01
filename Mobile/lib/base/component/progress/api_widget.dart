import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiWidget extends StatelessWidget {
  const ApiWidget({Key? key, required this.data, required this.widget}) : super(key: key);

  final Rx<NetworkResource> data;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (data.value.isSuccess()) {
        return widget;
      } else if(data.value.isLoading()) {
        return const Center(
          heightFactor: dimen4,
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimen52,
      child: Padding(
        padding: const EdgeInsets.all(dimen0),
        child: Container(
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(dimen8),
            boxShadow: const [
              BoxShadow(
                color: colorE4E1E1,
                blurRadius: dimen0,
                offset: Offset(dimen0, dimen1),
              ),
            ],
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: dimen16),
                child: Icon(
                  Icons.search,
                  color: color9C9896,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: dimen8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'searching_for'.tr,
                      hintStyle: const TextStyle(color: color9C9896),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class LocationItem extends StatelessWidget {
  const LocationItem({
    Key? key,
    this.isActive = false,
    required this.name,
    required this.address,
    this.onTap,
  }) : super(key: key);

  final String address;
  final String name;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: dimen16, vertical: dimen8),
              decoration: BoxDecoration(
                  color: isActive ? color469B59 : colorF3F1F1,
                  border: Border.all(color: colorWhite),
                  boxShadow: [
                    isActive
                        ? BoxShadow(
                            color: color2A2A64.withOpacity(0.24),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          )
                        : const BoxShadow(),
                  ],
                  borderRadius: BorderRadius.circular(dimen12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: isActive ? text14_white_600.copyWith(fontSize: 13): text14_32302D_600.copyWith(fontSize: 13)),
                  verticalSpace4,
                  Text(
                    address,
                    style: isActive
                        ? text12_white_400.copyWith(fontSize: 10)
                        : text12_625F5C_400.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

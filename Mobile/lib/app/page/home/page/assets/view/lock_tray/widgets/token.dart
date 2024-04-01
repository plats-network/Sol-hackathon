import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/controller/lock_tray_controller.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class TokenContainer extends StatefulWidget {
  const TokenContainer({super.key});

  @override
  State<TokenContainer> createState() => _TokenContainerState();
}

class _TokenContainerState extends State<TokenContainer> {
  final LockTrayController lockTrayController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => lockTrayController.assetList.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace50,
                  Container(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(
                        getAssetImage(AssetImagePath.empry_box),
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                  ),
                  Text(
                    'No Assets',
                    style: GoogleFonts.quicksand(
                      color: colorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace4,
                  Text(
                    'When you have assets you’ll see them here.',
                    style: GoogleFonts.quicksand(
                      color: color4E5260,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: dimen8),
                itemBuilder: (context, index) => Container(
                  decoration: const BoxDecoration(color: colorWhite),
                  padding: const EdgeInsets.symmetric(
                      horizontal: dimen24, vertical: dimen12),
                  child: Row(children: [
                    SizedBox(
                      height: dimen35,
                      width: dimen35,
                      child: AppCachedImage(
                        imageUrl:
                            lockTrayController.assetList[index].image ?? '',
                        width: double.infinity,
                        height: dimen35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    horizontalSpace10,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${lockTrayController.assetList[index].name}',
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            '342910.5301.92',
                            style: TextStyle(
                              color: color9C9896,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${lockTrayController.assetList[index].amount} ${lockTrayController.assetList[index].symbol}',
                      style: const TextStyle(
                        color: color27AE60,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => verticalSpace8,
                itemCount: lockTrayController.assetList.length,
              ),
            ),
    );
  }
}

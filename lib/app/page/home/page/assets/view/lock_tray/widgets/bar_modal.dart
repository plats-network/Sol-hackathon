import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BarModal {
  Future<void> send({
    String? iconWallet,
    String? nameWallet,
    VoidCallback? onTap,
  }) {
    return showBarModalBottomSheet(
      // expand: true,
      context: Get.context!,
      backgroundColor: colorWhite,
      builder: (context) => Container(
        padding: const EdgeInsets.only(
          left: dimen24,
          right: dimen24,
          top: dimen24,
        ),
        width: MediaQuery.of(context).size.width,
        // height: dimen300,
        child: Container(
          color: colorWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: dimen20),
                child: Center(
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              verticalSpace40,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Near Account ID',
                  //     style: const TextStyle(
                  //       color: color625F5C,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: ' *',
                  //         style: GoogleFonts.outfit(
                  //           fontWeight: FontWeight.bold,
                  //           color: colorF20200,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 70,
                    child: Center(
                      child: TextField(
                        // controller: _myController,
                        textAlign: TextAlign.center,
                        showCursor: true,
                        style: GoogleFonts.notoSans(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                        // Disable the default soft keybaord
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(color: colorDCDCDC),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace30,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: dimen16,
                  vertical: dimen12,
                ),
                decoration: BoxDecoration(
                  color: colorE8F2FC,
                  borderRadius: BorderRadius.circular(dimen24),
                ),
                child: const Text(
                  'User Max',
                  style: TextStyle(
                    color: color1D71F2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              verticalSpace40,
              Container(
                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.symmetric(
                //   horizontal: dimen16,
                //   vertical: dimen12,
                // ),
                padding: const EdgeInsets.symmetric(
                  horizontal: dimen16,
                  vertical: dimen20,
                ),
                decoration: BoxDecoration(
                  color: colorFAF9F9,
                  borderRadius: BorderRadius.circular(dimen12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Available to Send',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '120.89485 NEAR',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              verticalSpace40,
              Container(
                padding: const EdgeInsets.only(
                  // left: dimen24,
                  // right: dimen24,
                  bottom: dimen20,
                  top: dimen20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: dimen16),
                    decoration: BoxDecoration(
                      color: color1D71F2,
                      borderRadius: BorderRadius.circular(dimen24),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          color: color1D71F2.withOpacity(0.4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: color898989,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace30,
            ],
          ),
        ),
      ),
    );
  }
}

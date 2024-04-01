import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SponsorDetailScreen extends StatefulWidget {
  const SponsorDetailScreen({super.key});

  @override
  State<SponsorDetailScreen> createState() => _SponsorDetailScreenState();
}

class _SponsorDetailScreenState extends State<SponsorDetailScreen> {
  bool isSwitch = true;
  void switchButton(bool switchStatus) {
    setState(() {
      isSwitch = switchStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              left: dimen16,
              right: dimen16,
              top: dimen40,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become a sponsor to',
                    style: GoogleFonts.quicksand(
                      color: colorBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace10,
                  Text(
                    'Cardano Coffee Lounge Hanoi',
                    style: GoogleFonts.quicksand(
                      color: colorBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace30,
                  Text(
                    '✨Privilege',
                    style: GoogleFonts.quicksand(
                      color: colorBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace10,
                  Text(
                    '- It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout\n- Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.\n- Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    style: GoogleFonts.quicksand(
                      color: colorBlack,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace30,
                  Row(
                    children: [
                      Text(
                        '💖Current sponsors',
                        style: GoogleFonts.quicksand(
                          color: colorBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      horizontalSpace10,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: dimen10, vertical: dimen1),
                        decoration: BoxDecoration(
                          color: colorE5E5E5,
                          borderRadius: BorderRadius.circular(dimen30),
                        ),
                        child: Text(
                          '4',
                          style: GoogleFonts.quicksand(
                            color: colorBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace10,
                  // Expanded(
                  //   child: Container(
                  //     // height: 100,
                  //     margin: const EdgeInsets.symmetric(horizontal: 15),
                  //     child: Wrap(
                  //       spacing: 12,
                  //       runSpacing: 12,
                  //       children: [
                  //         ...List.generate(
                  //           100,
                  //           (index) {
                  //             return randomAvatar(
                  //               '$index',
                  //               height: 45,
                  //               width: 47,
                  //             );
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  verticalSpace30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sponsoring',
                        style: GoogleFonts.quicksand(
                          color: colorBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorDCDCDC),
                          borderRadius: BorderRadius.circular(dimen6),
                        ),
                        width: dimen120,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  switchButton(true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: dimen4),
                                  decoration: BoxDecoration(
                                    color: isSwitch ? color1DA5F2 : colorWhite,
                                    borderRadius: BorderRadius.circular(dimen4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Default',
                                      style: GoogleFonts.quicksand(
                                        color:
                                            isSwitch ? colorWhite : colorBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  switchButton(false);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: dimen4),
                                  decoration: BoxDecoration(
                                    color: isSwitch ? colorWhite : color1DA5F2,
                                    borderRadius: BorderRadius.circular(dimen4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Flexible',
                                      style: GoogleFonts.quicksand(
                                        color:
                                            isSwitch ? colorBlack : colorWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  verticalSpace10,
                  isSwitch
                      ? Column(
                          children: [
                            rankSponsor(
                              rank: 'Silver',
                              value: 'below 500',
                              decription:
                                  '- It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                            ),
                            rankSponsor(
                              rank: 'Gold',
                              value: 'about 500 to 1000',
                              decription:
                                  '- It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout\n- Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
                            ),
                            rankSponsor(
                              rank: 'Diamond',
                              value: 'over 1000',
                              decription:
                                  '- It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout\n- Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.\n- Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            ),
                          ],
                        )
                      : flexibleSponsor(),
                ],
              ),
            ),
          ),
          Positioned(
            top: dimen10,
            right: dimen10,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                getAssetImage(AssetImagePath.clear),
                width: dimen25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget flexibleSponsor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorDCDCDC),
        borderRadius: BorderRadius.circular(dimen6),
      ),
      margin: const EdgeInsets.only(bottom: dimen16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: colorE4E1E1,
            padding: const EdgeInsets.all(dimen16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: dimen160,
                  child: TextFormField(
                    // controller: qAController,
                    style: GoogleFonts.quicksand(
                      fontSize: dimen14,
                      color: colorBlack,
                      fontWeight: FontWeight.w600,
                    ),

                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(
                        top: dimen6,
                        bottom: dimen6,
                        left: dimen10,
                        right: dimen10,
                      ),
                      icon: Text(
                        'ADA',
                        style: GoogleFonts.quicksand(
                          color: colorBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      counter: const SizedBox(),
                      hintStyle: GoogleFonts.quicksand(
                        fontSize: dimen13,
                        color: colorTextHint,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: "Enter quantity.",
                      fillColor: colorWhite,
                      filled: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(dimen4)),
                        borderSide: BorderSide(
                          color: colorWhite,
                          width: 0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(dimen4)),
                        borderSide: BorderSide(
                          color: colorWhite,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(dimen4)),
                        borderSide: BorderSide(
                          color: colorWhite,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: dimen16, vertical: dimen6),
                  decoration: BoxDecoration(
                    color: color30A1DB,
                    borderRadius: BorderRadius.circular(dimen4),
                  ),
                  child: Text(
                    'Select',
                    style: GoogleFonts.quicksand(
                      color: colorWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(dimen16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose a custom amount. There are no rewards associated with this sponsorship.',
                  style: GoogleFonts.quicksand(
                    color: colorBlack,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rankSponsor({String? rank, String? value, String? decription}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorDCDCDC),
        borderRadius: BorderRadius.circular(dimen6),
      ),
      margin: const EdgeInsets.only(bottom: dimen16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color171716,
              image: DecorationImage(
                // color
                image: AssetImage(getAssetImage(AssetImagePath.theme_1)),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(dimen6),
                topRight: Radius.circular(dimen6),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: -35,
                  child: Text(
                    rank ?? '',
                    style: GoogleFonts.quicksand(
                      color: color66FFFFFF,
                      fontSize: 70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(dimen6),
                    topRight: Radius.circular(dimen6),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Container(
                      padding: const EdgeInsets.all(dimen16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   rank ?? '',
                              //   style: GoogleFonts.quicksand(
                              //     color: colorBlack,
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              GradientText(
                                rank ?? '',
                                style: GoogleFonts.quicksand(
                                  // color: colorBlack,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                gradientType: GradientType.linear,
                                gradientDirection: GradientDirection.ttb,
                                radius: 2.5,
                                colors: rank == 'Silver'
                                    ? [
                                        const Color.fromRGBO(203, 203, 203, 1),
                                        const Color.fromRGBO(
                                            255, 255, 255, 0.9),
                                        const Color.fromRGBO(250, 250, 250, 1),
                                        const Color.fromRGBO(
                                            245, 245, 245, 0.77),
                                        const Color.fromRGBO(
                                            248, 248, 249, 0.86),
                                        const Color.fromRGBO(255, 255, 255, 1),
                                        const Color.fromRGBO(
                                            255, 255, 255, 0.62),
                                        const Color.fromRGBO(255, 255, 255, 1),
                                        const Color.fromRGBO(
                                            255, 255, 255, 0.9),
                                        const Color.fromRGBO(
                                            239, 239, 239, 0.81),
                                        const Color.fromRGBO(126, 126, 129, 1),
                                      ]
                                    : rank == 'Gold'
                                        ? [
                                            const Color(0xFFB99B00),
                                            const Color(0xFFFAEA9A),
                                            const Color(0xFFFFF09E),
                                            const Color(0xFFA48900),
                                            const Color(0xFFFFEC8B),
                                            const Color(0xFFFEFEFE),
                                          ]
                                        // : widget.sum >= 18000 && widget.sum < 25000
                                        //     ? [
                                        //         Color.fromRGBO(203, 203, 203, 1),
                                        //         Color.fromRGBO(255, 255, 255, 0.9),
                                        //         Color.fromRGBO(250, 250, 250, 1),
                                        //         Color.fromRGBO(245, 245, 245, 0.77),
                                        //         Color.fromRGBO(248, 248, 249, 0.86),
                                        //         Color.fromRGBO(255, 255, 255, 1),
                                        //         Color.fromRGBO(255, 255, 255, 0.62),
                                        //         Color.fromRGBO(255, 255, 255, 1),
                                        //         Color.fromRGBO(255, 255, 255, 0.9),
                                        //         Color.fromRGBO(239, 239, 239, 0.81),
                                        //         Color.fromRGBO(126, 126, 129, 1),
                                        //       ]
                                        : rank == 'Diamond'
                                            ? [
                                                const Color.fromRGBO(
                                                    28, 78, 255, 1),
                                                const Color.fromRGBO(
                                                    209, 219, 255, 0.86),
                                                const Color.fromARGB(
                                                    226, 252, 177, 255),
                                                const Color.fromRGBO(
                                                    223, 230, 255, 0.48),
                                                const Color.fromARGB(
                                                    199, 255, 255, 255),
                                                const Color.fromARGB(
                                                    218, 255, 255, 255),
                                                const Color.fromRGBO(
                                                    206, 217, 255, 0.68),
                                                const Color.fromARGB(
                                                    239, 176, 227, 255),
                                                const Color.fromRGBO(
                                                    3, 0, 154, 1),
                                                const Color.fromRGBO(
                                                    253, 177, 255, 0.77),
                                              ]
                                            : [
                                                const Color.fromRGBO(
                                                    126, 61, 0, 1),
                                                const Color.fromRGBO(
                                                    178, 116, 58, 0.8),
                                                const Color.fromRGBO(
                                                    245, 185, 129, 0.85),
                                                const Color.fromRGBO(
                                                    203, 133, 51, 0.9),
                                                const Color.fromRGBO(
                                                    254, 201, 139, 0.95),
                                                const Color.fromRGBO(
                                                    160, 78, 2, 1),
                                              ],
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Sponsor ',
                                      style: GoogleFonts.quicksand(
                                        color: colorWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: value ?? '',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14,
                                        color: color1DA5F2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ADA',
                                      style: GoogleFonts.quicksand(
                                        color: colorWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: dimen16, vertical: dimen6),
                            decoration: BoxDecoration(
                              color: color30A1DB,
                              borderRadius: BorderRadius.circular(dimen4),
                            ),
                            child: Text(
                              'Select',
                              style: GoogleFonts.quicksand(
                                color: colorWhite,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(dimen16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Benefits',
                  style: GoogleFonts.quicksand(
                    color: colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace2,
                Text(
                  decription ?? '',
                  style: GoogleFonts.quicksand(
                    color: colorBlack,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

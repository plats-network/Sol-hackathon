import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/controller/lock_tray_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/widgets/bar_modal.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/widgets/token.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/app/widgets/app_modern_tabbar.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Asset extends StatefulWidget {
  const Asset({super.key});

  @override
  State<Asset> createState() => _AssetState();
}

class _AssetState extends State<Asset> with TickerProviderStateMixin {
  final LockTrayController lockTrayController = Get.find();
  late TabController tabController;
  final menuItemList = [
    'Transaction History',
    'Tokens',
    'NFTs',
    'Vouchers',
    'Boxes'
  ];
  @override
  void initState() {
    super.initState();
    lockTrayController.fetchAssetList();
    tabController = TabController(length: menuItemList.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool isShowBalance = false;
  void changeShowBalance() {
    setState(() {
      isShowBalance = !isShowBalance;
    });
  }

  bool isConnectWallet = false;
  void changeConnectWallet() {
    setState(() {
      isConnectWallet = !isConnectWallet;
    });
  }

  final TextEditingController accController = TextEditingController();
  final FocusNode _nodeAccount = FocusNode();
  final TextEditingController keyController = TextEditingController();
  final FocusNode _nodeKey = FocusNode();

  @override
  Widget build(BuildContext context) {
    Widget accIDWidget = AppInputView(
      controller: accController,
      hint: 'Near Account ID'.tr,
      // validationMessage: emailValidationMessage.value,
      // prefixImage: Image(
      //   image: AssetImage(
      //     getAssetImage(AssetImagePath.user_icon),
      //   ),
      //   color: color878998,
      //   width: dimen24,
      //   height: dimen24,
      // ),
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        // isShowError = true;
        // resetValidationMessage();
        // _validateEmail();
        // isShowError = false;
        // _nodePassword.requestFocus();
      },
      keyboardType: TextInputType.emailAddress,
      nodeTextField: _nodeAccount,
    );
    Widget keyWidget = AppInputView(
      controller: keyController,
      hint: 'Near Key'.tr,
      // validationMessage: emailValidationMessage.value,
      // prefixImage: Image(
      //   image: AssetImage(
      //     getAssetImage(AssetImagePath.user_icon),
      //   ),
      //   color: color878998,
      //   width: dimen24,
      //   height: dimen24,
      // ),
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        // isShowError = true;
        // resetValidationMessage();
        // _validateEmail();
        // isShowError = false;
        // _nodePassword.requestFocus();
      },
      keyboardType: TextInputType.emailAddress,
      nodeTextField: _nodeKey,
    );

    Future<void> connectWallet({
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
                      'Connect Near Wallet',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                verticalSpace10,
                Container(
                  padding: const EdgeInsets.all(dimen5),
                  width: dimen60,
                  height: dimen60,
                  child: Image(
                    image: AssetImage(
                      iconWallet ?? '',
                    ),
                  ),
                ),
                verticalSpace40,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Near Account ID',
                        style: const TextStyle(
                          color: color625F5C,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: colorF20200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace6,
                    accIDWidget,
                    verticalSpace14,
                    RichText(
                      text: TextSpan(
                        text: 'Near Private Key',
                        style: const TextStyle(
                          color: color625F5C,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: colorF20200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Text(
                    //   'Near Private Key',
                    //   style: TextStyle(
                    //     color: color625F5C,
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w400,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   maxLines: 2,
                    // ),
                    verticalSpace6,
                    keyWidget,
                  ],
                ),
                const Spacer(),
                verticalSpace10,
                Container(
                  padding: const EdgeInsets.only(
                    left: dimen24,
                    right: dimen24,
                    bottom: dimen16,
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
                        borderRadius: BorderRadius.circular(dimen26),
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
                          'Connect Wallet',
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
              ],
            ),
          ),
        ),
      );
    }

    Future<void> selectWallet() {
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
          height: dimen300,
          child: Container(
            color: colorWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: dimen20),
                  child: Center(
                    child: Text(
                      'Select wallet to connect',
                      style: TextStyle(
                        color: colorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                walletContainer(
                  nameWallet: 'Near Wallet',
                  iconWallet: getAssetImage(AssetImagePath.near_wallet),
                  onTap: () {
                    Get.back();
                    connectWallet(
                      nameWallet: 'Near Wallet',
                      iconWallet: getAssetImage(AssetImagePath.near_wallet),
                      onTap: () {},
                    );
                  },
                ),
                verticalSpace10,
                const Text(
                  'Choose the wallet you want to connect.',
                  style: TextStyle(
                    color: color625F5C,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
                const Spacer(),
                verticalSpace10,
                Container(
                  padding: const EdgeInsets.only(
                    left: dimen24,
                    right: dimen24,
                    bottom: dimen16,
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
                        borderRadius: BorderRadius.circular(dimen26),
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
                          'Next',
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
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // isConnectWallet
          //     ? Container(
          //         margin: const EdgeInsets.symmetric(
          //           horizontal: dimen24,
          //           vertical: dimen20,
          //         ),
          //         padding: const EdgeInsets.only(
          //           left: dimen16,
          //           right: dimen16,
          //           top: dimen20,
          //           bottom: dimen16,
          //         ),
          //         decoration: BoxDecoration(
          //           color: colorF5F7F9,
          //           borderRadius: BorderRadius.circular(dimen16),
          //           boxShadow: const [
          //             BoxShadow(
          //               color: colorF5F7F9,
          //               blurRadius: dimen3,
          //               offset: Offset(0, 2),
          //             ),
          //           ],
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Row(
          //                   children: [
          //                     Image(
          //                       image: AssetImage(
          //                         getAssetImage(AssetImagePath.wallet),
          //                       ),
          //                       width: dimen25,
          //                       height: dimen25,
          //                     ),
          //                     horizontalSpace8,
          //                     const Text(
          //                       'Main Wallet',
          //                       style: TextStyle(
          //                         color: colorBlack,
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w600,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //                 Container(
          //                   width: dimen35,
          //                   height: dimen35,
          //                   decoration: const BoxDecoration(
          //                       color: color0E4B88,
          //                       shape: BoxShape.circle,
          //                       image: DecorationImage(
          //                         // ),
          //                         image: CachedNetworkImageProvider(
          //                           'https://www.getnews.info/uploads/3d165b8f6c3d58a8201098d8a5e27e0c.png'
          //                           '',
          //                         ),
          //                         fit: BoxFit.cover,
          //                       )),
          //                 )
          //               ],
          //             ),
          //             verticalSpace10,
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 const Text(
          //                   'Your balance',
          //                   style: TextStyle(
          //                     color: color9C9896,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //                 horizontalSpace6,
          //                 GestureDetector(
          //                   onTap: () {
          //                     changeShowBalance();
          //                   },
          //                   child: Image(
          //                     image: AssetImage(
          //                       isShowBalance
          //                           ? getAssetImage(AssetImagePath.eye)
          //                           : getAssetImage(
          //                               AssetImagePath.eye_disabled),
          //                     ),
          //                     width: dimen20,
          //                     height: dimen20,
          //                     color: color9C9896,
          //                   ),
          //                 )
          //               ],
          //             ),
          //             verticalSpace4,
          //             isShowBalance
          //                 ? RichText(
          //                     text: TextSpan(
          //                       text: '',
          //                       style: GoogleFonts.outfit(
          //                         color: colorBlack,
          //                         fontSize: 16,
          //                       ),
          //                       children: <TextSpan>[
          //                         TextSpan(
          //                           text: '1,235',
          //                           style: GoogleFonts.outfit(
          //                             fontWeight: FontWeight.w400,
          //                             fontSize: 35,
          //                           ),
          //                         ),
          //                         TextSpan(
          //                           text: '.085',
          //                           style: GoogleFonts.outfit(
          //                             fontWeight: FontWeight.w400,
          //                             fontSize: 20,
          //                             color: color4E4E4E,
          //                           ),
          //                         ),
          //                         const TextSpan(text: ' NEAR'),
          //                       ],
          //                     ),
          //                   )
          //                 : Padding(
          //                     padding: const EdgeInsets.only(top: dimen4),
          //                     child: Text(
          //                       '******',
          //                       style: GoogleFonts.outfit(
          //                         fontWeight: FontWeight.w600,
          //                         fontSize: 26,
          //                       ),
          //                     ),
          //                   ),
          //           ],
          //         ),
          //       )
          //     : GestureDetector(
          //         // onTap: () {
          //         //   changeConnectWallet();
          //         // },
          //         onTap: () => selectWallet(),
          //         child: Container(
          //           margin: const EdgeInsets.symmetric(
          //             horizontal: dimen24,
          //             vertical: dimen20,
          //           ),
          //           padding: const EdgeInsets.only(
          //             left: dimen16,
          //             right: dimen16,
          //             top: dimen20,
          //             bottom: dimen16,
          //           ),
          //           decoration: BoxDecoration(
          //             color: colorE8F2FC,
          //             borderRadius: BorderRadius.circular(dimen16),
          //             boxShadow: const [
          //               BoxShadow(
          //                 color: colorF5F7F9,
          //                 blurRadius: dimen10,
          //                 offset: Offset(0, 2),
          //               ),
          //             ],
          //           ),
          //           child: Row(
          //             children: [
          //               Image(
          //                 image: AssetImage(
          //                   getAssetImage(AssetImagePath.add_wallet),
          //                 ),
          //                 width: dimen30,
          //                 height: dimen30,
          //               ),
          //               horizontalSpace8,
          //               const Text(
          //                 'Connect Wallet!',
          //                 style: TextStyle(
          //                   color: colorBlack,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: dimen24),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () => BarModal().send(),
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: dimen16),
          //             decoration: BoxDecoration(
          //               color: colorE8F2FC,
          //               borderRadius: BorderRadius.circular(dimen12),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image(
          //                   image: AssetImage(
          //                     getAssetImage(AssetImagePath.up_arrow),
          //                   ),
          //                   width: dimen18,
          //                   height: dimen18,
          //                 ),
          //                 horizontalSpace6,
          //                 Text(
          //                   'Send',
          //                   style: GoogleFonts.outfit(
          //                     color: colorBlack,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       horizontalSpace24,
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () {},
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: dimen16),
          //             decoration: BoxDecoration(
          //               color: colorE8F2FC,
          //               borderRadius: BorderRadius.circular(dimen12),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Image(
          //                   image: AssetImage(
          //                     getAssetImage(AssetImagePath.down_arrow),
          //                   ),
          //                   width: dimen18,
          //                   height: dimen18,
          //                 ),
          //                 horizontalSpace6,
          //                 Text(
          //                   'Receive',
          //                   style: GoogleFonts.outfit(
          //                     color: colorBlack,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // verticalSpace30,
          SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            child: DefaultTabController(
              length: menuItemList.length,
              child: Scaffold(
                backgroundColor: colorWhite,
                body: Column(
                  children: <Widget>[
                    AppModernTabBar(
                      controller: tabController,
                      menuItemList: menuItemList,
                    ),

                    // create widgets for each tab bar here
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          TokenContainer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget walletContainer({
    String? iconWallet,
    String? nameWallet,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorF5F7F9,
          borderRadius: BorderRadius.circular(dimen12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: dimen20,
          vertical: dimen10,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(dimen5),
              width: dimen30,
              height: dimen30,
              child: Image(
                image: AssetImage(
                  iconWallet ?? '',
                ),
              ),
            ),
            horizontalSpace20,
            Text(
              nameWallet ?? '',
              style: const TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

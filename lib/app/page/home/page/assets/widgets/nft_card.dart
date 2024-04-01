import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class NftCard extends StatelessWidget {
  final String imageUrl;
  final String nftName;
  final String? artistName;
  final String? artistImageUrl;
  final String? price;
  final String? priceInDollar;

  const NftCard({
    Key? key,
    required this.imageUrl,
    required this.nftName,
    this.artistName,
    this.artistImageUrl,
    this.price,
    this.priceInDollar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color32302D.withOpacity(0.12),
            offset: Offset(0, 4),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: colorWhite,
        borderRadius: BorderRadius.all(Radius.circular(dimen16)),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.nftDetail),
          borderRadius: BorderRadius.all(Radius.circular(dimen16)),
          child: Container(
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Stack(
                  children: [
                    AppCachedImage(
                      cornerRadius: dimen16,
                      imageUrl: imageUrl,
                      height: dimen125,
                      width: context.width,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                        left: dimen12,
                        bottom: dimen16,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimen6, vertical: dimen2),
                          decoration: BoxDecoration(
                              color: color469B59,
                              borderRadius: BorderRadius.circular(dimen3)),
                          child: Center(
                            child: Text('image', style: text10_white_600),
                          ),
                        )),
                  ],
                ),
                Container(
                  height: dimen41,
                  padding: EdgeInsets.only(left: dimen16, right: dimen8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: dimen12),
                          child: Text(
                            nftName,
                            style: text16_32302D_700,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (artistImageUrl != null)
                          Container(
                            margin: EdgeInsets.only(bottom: dimen12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppCachedImage(
                                  imageUrl: artistImageUrl!,
                                  width: dimen28,
                                  height: dimen28,
                                  cornerRadius: dimen50,
                                ),
                                if (price != null &&
                                    priceInDollar != null &&
                                    artistName != null) ...[
                                  horizontalSpace8,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(artistName!,
                                          style: text10_9C9896_400),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: price,
                                            style: text12_469B59_700),
                                        TextSpan(
                                          text: ' \$$priceInDollar',
                                          style: text10_9C9896_400,
                                        ),
                                      ]))
                                    ],
                                  )
                                ]
                              ],
                            ),
                          ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

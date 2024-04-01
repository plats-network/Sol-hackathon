part of 'social_task_detail_page.dart';

extension TaskDetailControllerPageAction on _SocialTaskDetailPageState {
  void showCancelTaskBottomSheet() {
    GetXDefaultBottomSheet.rawBottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(dimen16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'canceling_your_task'.tr,
                style: text22_32302D_700,
                textAlign: TextAlign.center,
              ),
              verticalSpace24,
              ClipRRect(
                borderRadius: border16,
                child: Image.asset(
                  getAssetImage(AssetImagePath.ic_warning),
                  width: dimen80,
                ),
              ),
              verticalSpace24,
              Center(
                child: Text(
                  'are_you_sure_cancel_task'.tr,
                  style: text14_32302D_400,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace24,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'no'.tr,
                      isPrimaryStyle: false,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  horizontalSpace16,
                  Expanded(
                    child: AppButton(
                      title: 'yes'.tr,
                      onTap: () {
                        Get.back();
                        cancelTask();
                      },
                    ),
                  ),
                ],
              ),
              verticalSpace16,
            ],
          ),
        ),
      ),
    );
  }
}

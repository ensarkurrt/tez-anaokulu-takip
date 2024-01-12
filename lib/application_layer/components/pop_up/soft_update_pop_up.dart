import 'package:flutter/cupertino.dart';
import 'package:kindergarden_mobile/application_layer/components/pop_up/base_popUp.dart';
import 'package:kindergarden_mobile/service_layer/firebase/firebase_remote_config.dart';
import 'package:kindergarden_mobile/service_layer/localization/page_enum.dart';
import 'package:kindergarden_mobile/tools/constants/remote_config_constants.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';
import 'package:url_launcher/url_launcher.dart';

class SoftUpdatePopUp extends StatefulWidget {
  const SoftUpdatePopUp({super.key});

  @override
  State<SoftUpdatePopUp> createState() => _SoftUpdatePopUpState();
}

class _SoftUpdatePopUpState extends State<SoftUpdatePopUp> {
  @override
  Widget build(BuildContext context) {
    return BasePopUp(
      iconPath: IconPathEnums.download.path,
      title: popUp.updateInfoTitle.tr(),
      subTitle: popUp.updateInfoDescription.tr(),
      type: PopUpType.info,
      /* analyticEvent: AnalyticEvents.settingsClearHistoryConfirmPopUp, */
      actions: [
        PopUpAction(
          title: popUp.subscriptionInfoButton.tr(),
          onTap: () => Navigator.pop(context),
          type: PopUpActionType.negative,
        ),
        PopUpAction(
          title: popUp.updateInfoButton.tr(),
          onTap: () async {
            String storeUrl = FirebaseRemoteConfigService.instance.getString(RemoteConfigConstants.STORE_URL, locale: false);
            await launchUrl(Uri.parse(storeUrl), mode: LaunchMode.externalApplication);
          },
        ),
      ],
    );
  }
}

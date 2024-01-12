import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/pop_up/base_popUp.dart';
import 'package:kindergarden_mobile/application_layer/features/splash/splash_view.dart';
import 'package:kindergarden_mobile/service_layer/localization/page_enum.dart';
import 'package:kindergarden_mobile/service_layer/network/connectivity_manager.dart';
import 'package:kindergarden_mobile/tools/enums/icon_path_enums.dart';

class NoConnectionPopUp extends StatefulWidget {
  final bool? redirectToSplash;
  const NoConnectionPopUp({super.key, this.redirectToSplash = true});

  @override
  State<NoConnectionPopUp> createState() => _NoConnectionPopUpState();
}

class _NoConnectionPopUpState extends State<NoConnectionPopUp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityManager.instance.add((p0) {
        if (p0) {
          if (widget.redirectToSplash == true) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashView()), (route) => false);
          } else {
            Navigator.pop(context);
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePopUp(
      title: popUp.connectionErrorTitle.tr(),
      subTitle: popUp.connectionErrorDescription.tr(),
      iconPath: IconPathEnums.noConnection.path,
      type: PopUpType.error,
      actions: [
        PopUpAction(
          title: popUp.connectionErrorButton.tr(),
          onTap: () async {
            if (widget.redirectToSplash == true) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashView()), (route) => false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}

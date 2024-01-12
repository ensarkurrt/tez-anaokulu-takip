import 'package:flutter/cupertino.dart';
import 'package:kindergarden_mobile/application_layer/components/pop_up/base_popUp.dart';
import 'package:kindergarden_mobile/service_layer/localization/page_enum.dart';

class WarningPopUp extends StatefulWidget {
  final String title;
  final String subTitle;
  final String positiveTitle;
  final Function()? onPositive;
  const WarningPopUp({super.key, required this.title, required this.subTitle, this.onPositive, required this.positiveTitle});

  @override
  State<WarningPopUp> createState() => _WarningPopUpState();
}

class _WarningPopUpState extends State<WarningPopUp> {
  @override
  Widget build(BuildContext context) {
    return BasePopUp(
      title: widget.title,
      subTitle: widget.subTitle,
      /* analyticEvent: AnalyticEvents.settingsClearHistoryConfirmPopUp, */
      type: PopUpType.warning,
      actions: [
        PopUpAction(
          title: popUp.cancelButton.tr(),
          onTap: () => Navigator.pop(context),
          type: PopUpActionType.negative,
        ),
        PopUpAction(
          title: widget.positiveTitle,
          onTap: () => widget.onPositive == null ? Navigator.pop(context) : {widget.onPositive?.call(), Navigator.pop(context)},
          type: PopUpActionType.positive,
        ),
      ],
    );
  }
}

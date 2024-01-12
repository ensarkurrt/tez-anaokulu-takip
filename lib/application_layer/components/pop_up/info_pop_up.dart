import 'package:flutter/cupertino.dart';
import 'package:kindergarden_mobile/application_layer/components/pop_up/base_popUp.dart';

class InfoPopup extends StatefulWidget {
  final String title;
  final String subTitle;
  const InfoPopup({super.key, required this.title, required this.subTitle});

  @override
  State<InfoPopup> createState() => _InfoPopupState();
}

class _InfoPopupState extends State<InfoPopup> {
  @override
  Widget build(BuildContext context) {
    return BasePopUp(
      title: widget.title,
      subTitle: widget.subTitle,
      /* analyticEvent: AnalyticEvents.settingsClearHistoryConfirmPopUp, */
      actions: [
        PopUpAction(
          title: "Tamam",
          onTap: () => Navigator.pop(context),
          type: PopUpActionType.positive,
        ),
      ],
    );
  }
}

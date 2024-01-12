import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/activity_model.dart';
import 'package:kindergarden_mobile/tools/enums/radius_enums.dart';

class CustomActivityProgramComponent extends StatefulWidget {
  final ActivityModel activityModel;
  const CustomActivityProgramComponent({super.key, required this.activityModel});

  @override
  State<CustomActivityProgramComponent> createState() => _CustomActivityProgramComponentState();
}

class _CustomActivityProgramComponentState extends State<CustomActivityProgramComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: customBoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: leftSideDecoration(),
              height: context.height * 0.06,
              child: Center(
                child: Text(widget.activityModel.time,
                    style: context.fonts.body.copyWith(color: context.rTextColors.filledInputForm, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: rightSideDecoration(),
              height: context.height * 0.06,
              child: Center(
                child: Text(widget.activityModel.activityName,
                    style: context.fonts.body.copyWith(color: context.textColors.filledInputForm, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration rightSideDecoration() {
    return BoxDecoration(
      borderRadius: RadiusEnums.general.right(context),
      color: context.themeColors.main,
    );
  }

  BoxDecoration leftSideDecoration() {
    return BoxDecoration(
      borderRadius: RadiusEnums.general.left(context),
      color: context.themeColors.accent,
    );
  }

  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: context.themeColors.second, width: context.width * 0.002),
      borderRadius: RadiusEnums.general.all(context),
    );
  }
}

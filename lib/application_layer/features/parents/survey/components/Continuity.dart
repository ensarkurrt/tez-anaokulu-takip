import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';
import 'package:kindergarden_mobile/tools/enums/radius_enums.dart';

class Continuity extends StatelessWidget {
  const Continuity({super.key, required this.totalCount, this.monthly = false});
  final int totalCount;
  final bool monthly;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.themeColors.main,
          borderRadius: RadiusEnums.general.all(context),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              spreadRadius: -1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: PaddingEnums.cardPadding.all(context),
              decoration: BoxDecoration(
                color: context.themeColors.accent,
                borderRadius: RadiusEnums.general.all(context),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 15,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: context.height * 0.04,
                    height: context.height * 0.04,
                    decoration: BoxDecoration(
                      color: context.themeColors.main,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      totalCount.toString(),
                      style: context.fonts.body.copyWith(color: context.textColors.filledInputForm),
                    ),
                  ),
                  Text(
                    (monthly) ? "Tüm\nDevamsızlıklar" : "Aylık\nDevamsızlıklar",
                    textAlign: TextAlign.center,
                    style: context.fonts.body.copyWith(color: context.textColors.filledInputForm),
                  )
                ],
              ),
            ),
            context.addVerticalSpace(0.01),
            Padding(
              padding: PaddingEnums.cardPadding.all(context),
              child: Column(
                children: [
                  Text("01.02.2024", style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
                  const CustomDivider(),
                  Text("01.02.2024", style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
                  const CustomDivider(),
                  Text("01.02.2024", style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
                  const CustomDivider(),
                  Text("01.02.2024", style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
                  const CustomDivider(),
                  Text("01.02.2024", style: context.fonts.body.copyWith(color: context.textColors.filledInputForm)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      indent: 10,
      endIndent: 10,
    );
  }
}

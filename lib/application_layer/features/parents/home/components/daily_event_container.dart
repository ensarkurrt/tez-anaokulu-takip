import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class DailyEventContainer extends StatelessWidget {
  const DailyEventContainer(
      {super.key,
      required this.icon,
      required this.title,
      required this.description});
  final Widget icon;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.height * (1.2 / 100)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: context.width,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Colors.black12)
      ], borderRadius: BorderRadius.circular(5), color: Colors.orange),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: context.height * (1.5 / 100),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.height * (2 / 100),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: context.height * (1.8 / 100),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

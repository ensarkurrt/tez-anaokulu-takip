import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/pop_up/no_connection_popUp.dart';

import '../../components/indicators/circle_indicator.dart';

class NoConnectionView extends StatefulWidget {
  const NoConnectionView({
    Key? key,
  }) : super(key: key);
  @override
  State<NoConnectionView> createState() => _NoConnectionViewState();
}

class _NoConnectionViewState extends State<NoConnectionView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, barrierDismissible: false, builder: (builder) => const NoConnectionPopUp());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /*  decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePathEnums.splash.path),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ), */
        child: const Center(child: CircleIndicator()),
      ),
    );
  }
}

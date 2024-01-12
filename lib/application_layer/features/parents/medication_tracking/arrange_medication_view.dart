import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/app_bar.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class ArrangeMedicationView extends StatefulWidget {
  const ArrangeMedicationView({super.key});

  @override
  State<ArrangeMedicationView> createState() => _ArrangeMedicationViewState();
}

class _ArrangeMedicationViewState extends State<ArrangeMedicationView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.height * 0.07),
          child: const CustomAppBar(
            title: "İlaç Takibi",
          ),
        ),
        body: Container(width: 350,height: 350,color: Colors.pink,child: Text('İlaçları düzenleme sayfası',style: TextStyle(fontSize: 50),),),
      ),
    );
  }
}
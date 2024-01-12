import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

import 'components/payments_list_item.dart';

class PaymentsView extends StatefulWidget {
  const PaymentsView({super.key});

  @override
  State<PaymentsView> createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.materialAppBarSize,
          child: const MaterialCustomAppBar(
            title: "Duyurular",
          ),
        ),
        body: const PageLayout(
          child: VerticalListWithSpace(
            factor: 0.015,
            shrinkWrap: true,
            children: [
              InfoText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nibh ut tortor aliquam aliquet. "),
              PaymentsListItem(
                months: "Ocak",
                verified: true,
              ),
              PaymentsListItem(
                months: "Şubat",
                verified: true,
              ),
              PaymentsListItem(
                months: "Mart",
                verified: true,
              ),
              PaymentsListItem(
                months: "Nisan",
                verified: false,
              ),
              PaymentsListItem(
                months: "Mayıs",
                verified: false,
              ),
              PaymentsListItem(
                months: "Haziran",
                verified: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

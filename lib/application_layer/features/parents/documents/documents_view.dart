import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/components/info_text.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/padding_enums.dart';

import 'components/document_list_item.dart';

class DocumentsView extends StatefulWidget {
  const DocumentsView({super.key});

  @override
  State<DocumentsView> createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: context.materialAppBarSize,
        child: const MaterialCustomAppBar(
          title: "Dökümanlar",
        ),
      ),
      body: Container(
        padding: PaddingEnums.pagePadding.horizontal(context),
        margin: PaddingEnums.pagePaddingHalf.vertical(context),
        height: context.height,
        child: VerticalListWithSpace(
          shrinkWrap: true,
          factor: PaddingEnums.listPadding.factor,
          children: const [
            InfoText(
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nibh ut nunc aliquam aliquet. Sed vitae nibh ut nunc aliquam aliquet."),
            DocumentListItem(),
            DocumentListItem(),
            DocumentListItem(),
            DocumentListItem(),
            DocumentListItem(),
            DocumentListItem(),
          ],
        ),
      ),
    ));
  }
}

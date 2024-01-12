import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_list_with_space.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/parent_information/components/add_parent.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/settings/parent_information/components/edit_parent_sheet.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class ParentInfoView extends StatefulWidget {
  const ParentInfoView({super.key});

  @override
  State<ParentInfoView> createState() => _ParentInfoViewState();
}

class _ParentInfoViewState extends State<ParentInfoView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const AddParentSheet(); // AddParentSheet widget'ını burada kullanın
              },
            );
          },
          label: const Text('Ekle'),
          icon: const Icon(Icons.add),
        ),
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: context.appBarSize,
          child: const MaterialCustomAppBar(
            title: "Veliler",
          ),
        ),
        body: PageLayout(
          child: VerticalListWithSpace(
            factor: 0.02,
            children: [
              parentDetailCard(),
              parentDetailCard(),
              parentDetailCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget parentDetailCard() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(isScrollControlled: true, context: context, builder: (ctx) => const EditParentSheet());
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(context.height * 0.015),
          color: context.themeColors.main,
        ),
        child: Padding(
          padding: EdgeInsets.all(context.height * 0.018),
          child: Column(
            children: [
              const InputField(
                label: "Muhammed ÇELİK",
                enabled: false,
              ),
              context.addVerticalSpace(0.015),
              const InputField(
                label: "555-555-5555",
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

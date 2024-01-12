import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/components/base/vertical_column_with_space.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/school/home/components/redirection_section.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

import 'components/home_top_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageLayout(
          child: VerticalColumnWithSpace(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.addVerticalSpace(0.05),
              const HomeTopSection(),
              const RedirectionSection(),
            ],
          ),
        ),
      ),
    );
  }
}

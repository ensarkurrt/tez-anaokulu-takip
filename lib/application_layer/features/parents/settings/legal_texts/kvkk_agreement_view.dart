import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/app_bars/material_app_bar.dart';
import 'package:kindergarden_mobile/application_layer/components/base/page_layout.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class KvkkAgreementView extends StatefulWidget {
  const KvkkAgreementView({super.key});

  @override
  State<KvkkAgreementView> createState() => _KvkkAgreementViewState();
}

class _KvkkAgreementViewState extends State<KvkkAgreementView> {
  @override
  Widget build(BuildContext context) {
    {
      return LoadingView(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: context.appBarSize,
              child: const MaterialCustomAppBar(
                title: "KVKK Aydınlatma Metni",
              ),
            ),
            backgroundColor: Colors.transparent,
            body: PageLayout(
              child: TextColumn(context),
            )),
      );
    }
  }

  // ignore: non_constant_identifier_names
  Column TextColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('KVKK Aydınlatma Metni', style: context.fonts.title.copyWith(color: context.textColors.title)),
        context.addVerticalSpace(0.022),
        Text(
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam convallis fringilla faucibus. Praesent a congue neque, aliquet ultrices ipsum. Ut nulla tellus, pharetra quis tempor at, fringilla ullamcorper eros. Pellentesque vel massa vitae libero accumsan consectetur eu ac quam. Aliquam ut orci est. Etiam in mattis turpis. Mauris nec suscipit lacus.In hac habitasse platea dictumst. Morbi vulputate ultrices lacus id facilisis. In quis tortor eget arcu tincidunt aliquet. Integer rhoncus mi ut lobortis porttitor. In nec tortor interdum, posuere mi ut, ultricies orci. Nullam vitae ullamcorper diam, sit amet facilisis tortor. Integer nec ornare magna, nec sodales nisl. Aenean vel purus a urna cursus pretium. Praesent ex risus, rhoncus non scelerisque sed, hendrerit eu mauris. Pellentesque finibus non neque non elementum. Nulla mollis efficitur diam, vitae tempus justo faucibus vitae. Morbi porta dapibus ullamcorper. Etiam ac libero eu tellus pharetra semper. In ac diam facilisis, consequat ipsum et, ullamcorper ipsum.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam convallis fringilla faucibus. Praesent a congue neque, aliquet ultrices ipsum. Ut nulla tellus, pharetra quis tempor at, fringilla ullamcorper eros. Pellentesque vel massa vitae libero accumsan consectetur eu ac quam. Aliquam ut orci est. Etiam in mattis turpis. Mauris nec suscipit lacus.In hac habitasse platea dictumst. Morbi vulputate ultrices lacus id facilisis. In quis tortor eget arcu tincidunt aliquet. Integer rhoncus mi ut lobortis porttitor. In nec tortor interdum, posuere mi ut, ultricies orci. Nullam vitae ullamcorper diam, sit amet facilisis tortor. Integer nec ornare magna, nec sodales nisl. Aenean vel purus a urna cursus pretium. Praesent ex risus, rhoncus non scelerisque sed, hendrerit eu mauris. Pellentesque finibus non neque non elementum. Nulla mollis efficitur diam, vitae tempus justo faucibus vitae. Morbi porta dapibus ullamcorper. Etiam ac libero eu tellus pharetra semper. In ac diam facilisis, consequat ipsum et, ullamcorper ipsum.''',
            style: context.fonts.smallBody.copyWith(color: context.textColors.filledInputForm)),
      ],
    );
  }
}

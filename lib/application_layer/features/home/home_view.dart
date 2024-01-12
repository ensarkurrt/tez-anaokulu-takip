import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/features/loading/loading_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/announcement/announcement_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/documents/documents_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/homework/homework_view.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/payments/payments_view.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return LoadingView(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.navigateTo(const HomeworkView());
              },
              child: const Text('Homework Page'),
            ),
            GestureDetector(
              onTap: () {
                context.navigateTo(const AnnouncementView());
              },
              child: const Text('Announcement Page'),
            ),
            GestureDetector(
              onTap: () {
                context.navigateTo(const PaymentsView());
              },
              child: const Text('Payments Page'),
            ),
            GestureDetector(
              onTap: () {
                context.navigateTo(const DocumentsView());
              },
              child: const Text('Documents Page'),
            ),
            GestureDetector(
              onTap: () {
                /* context.navigateTo(const AlbumView()); */
              },
              child: const Text('Galerry Page'),
            ),
          ],
        )),
      ),
    );
  }
}

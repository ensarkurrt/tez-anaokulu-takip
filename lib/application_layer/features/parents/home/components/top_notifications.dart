import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/features/parents/announcement/components/announcement_component.dart';
import 'package:kindergarden_mobile/main.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/service_layer/models/announcement_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class TopNotifications extends StatefulWidget {
  const TopNotifications({super.key});

  @override
  State<TopNotifications> createState() => _TopNotificationsState();
}

class _TopNotificationsState extends State<TopNotifications> {
  final List<Announcement> _list = [];
  int sliderIndex = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var classId = SessionManagement.include.student.classId;
      print("classId: $classId");
      await supabase
          .from('announcements')
          .select()
          .eq('class_id', classId)
          .limit(2)
          .order('created_at', ascending: false)
          .withConverter<List<Announcement>>((data) => data.map((e) => Announcement.fromJson(e)).toList())
          .then((value) {
        setState(() {
          _list.addAll(value);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _list.map((e) => CustomAnnouncementComponent(announcement: e)).toList(),
          options: CarouselOptions(
              viewportFraction: 0.95,
              height: context.height * (10 / 100),
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) => setState(() => sliderIndex = index)),
        ),
        SizedBox(
          height: context.height * (1.5 / 100),
        ),
        AnimatedSmoothIndicator(
          activeIndex: sliderIndex,
          count: _list.length,
          effect: ScrollingDotsEffect(dotColor: Colors.orange.shade200, activeDotColor: Colors.orange, dotWidth: 5, dotHeight: 5),
        )
      ],
    );
  }
}

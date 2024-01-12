import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Column(
              children: [
                Text(
                  "His Durumu: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("İyi Hissediyor.")
              ],
            ),
            SizedBox.shrink()
          ],
        ),
        SizedBox(
          height: context.height * (3 / 100),
        ),
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Öğretmenin Notları: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      "Günümüz verimli geçti. Öğrencimiz etkinliklere katıldı ve çok neşeliydi."),
                ],
              ),
            ),
            SizedBox.shrink()
          ],
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/application_layer/components/button/tm_button.dart';
import 'package:kindergarden_mobile/application_layer/components/inputs/base_input.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';

class AddParentSheet extends StatefulWidget {
  const AddParentSheet({super.key});

  @override
  State<AddParentSheet> createState() => _AddParentSheetState();
}

class _AddParentSheetState extends State<AddParentSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: (context.height * 0.39),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Padding(
          padding: EdgeInsets.all(context.height * 0.001),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  textAlign: TextAlign.center, // Metni ortala
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 26, 26, 26),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              context.addVerticalSpace(0.025),
              const InputField(
                label: "Veli Ad",
              ),
              context.addVerticalSpace(0.025),
              const InputField(
                label: "Veli Telefon",
              ),
              context.addVerticalSpace(0.035),
              TMButton(
                title: "Ekle",
                onTap: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.transparent,
                textColor: Colors.green,
                borderColor: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}

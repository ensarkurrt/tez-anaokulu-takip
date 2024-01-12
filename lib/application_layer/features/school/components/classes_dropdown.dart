import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/models/class_model.dart';
import 'package:kindergarden_mobile/service_layer/providers/session_management.dart';
import 'package:provider/provider.dart';

class ClassesDropdown extends StatefulWidget {
  final Function(int) onChanged;
  const ClassesDropdown({super.key, required this.onChanged});

  @override
  State<ClassesDropdown> createState() => _ClassesDropdownState();
}

class _ClassesDropdownState extends State<ClassesDropdown> {
  int? selectedClass;
  @override
  Widget build(BuildContext context) {
    if (SessionManagement.include.isStudent) return const SizedBox();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: Text(
          'Sınıf Seçin',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: context
            .watch<SessionManagement>()
            .school
            .classes!
            .map((ClassModel item) => DropdownMenuItem<int>(
                  value: item.id,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedClass,
        onChanged: (int? value) {
          widget.onChanged(value!);
          setState(() {
            selectedClass = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 140,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}

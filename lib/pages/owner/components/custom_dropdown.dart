import 'package:flutter/material.dart';

import '../../../components/custom_text.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key, required this.selected});

  final Function(String) selected;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedOption = 'employee'; // Set the default selected option

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Row(
          children: [
            Expanded(
                child: DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                onChanged: (String? value) {
                  if (mounted) {
                    setState(() {
                      selectedOption = value!;
                      widget.selected(value);
                    });
                  }
                },
                value: selectedOption,
                items: ['employee', 'owner', 'agent']
                    .map((String? item) => DropdownMenuItem<String?>(
                          value: item,
                          child: CustomText(
                              text: item ?? "",
                              color: AppColors.black67,
                              style: AppStyles.regular16),
                        ))
                    .toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

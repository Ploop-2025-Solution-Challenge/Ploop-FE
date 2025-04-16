import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'option_button.dart';

class OptionButtonSet extends StatefulWidget {
  final List<String> options;
  final bool isMultiSelect;
  final int maxMultiSelect;
  final bool alignColumn;

  const OptionButtonSet({
    super.key,
    required this.options,
    this.isMultiSelect = false,
    this.maxMultiSelect = 1,
    this.alignColumn = false,
  });

  @override
  State<OptionButtonSet> createState() => _OptionButtonSetState();
}

class _OptionButtonSetState extends State<OptionButtonSet> {
  String? selectedOption; // for single select
  Set<String> selectedOptions = {}; // for multi select
  String? maxExceedWarning;

  void handleTap(String label) {
    print(label);
    setState(() {
      maxExceedWarning = null;
      if (widget.isMultiSelect) {
        final isRemoving = selectedOptions.contains(label);

        if (!isRemoving && selectedOptions.length >= widget.maxMultiSelect) {
          maxExceedWarning =
              "Please select up to ${widget.maxMultiSelect} options.";

          return;
        }

        if (isRemoving) {
          selectedOptions.remove(label);
        } else {
          selectedOptions.add(label);
        }
      } else {
        selectedOption = label;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alignColumn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: widget.options.map((label) {
              final isSelected = widget.isMultiSelect
                  ? selectedOptions.contains(label)
                  : selectedOption == label;

              return OptionButton(
                label: label,
                isSelected: isSelected,
                onTap: () => handleTap(label),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          // other option cases doesn't allow multiple selection
          maxExceedWarning == null
              ? SizedBox(height: 16.h)
              : Text(
                  '$maxExceedWarning',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: const Color(0xFFFF5F5F)),
                ),
        ],
      );
    } else {
      return Wrap(
        spacing: 8.w,
        children: widget.options.map((label) {
          final isSelected = widget.isMultiSelect
              ? selectedOptions.contains(label)
              : selectedOption == label;

          return OptionButton(
            label: label,
            isSelected: isSelected,
            onTap: () => handleTap(label),
          );
        }).toList(),
      );
    }
  }
}

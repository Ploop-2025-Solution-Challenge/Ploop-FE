import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';
import 'option_button.dart';

class OptionButtonSet extends StatelessWidget {
  final List<String> options;
  final bool isMultiSelect;
  final int maxMultiSelect;
  final bool alignColumn;

  final String? selectedOption;
  final Set<String> selectedOptions;

  final void Function(String) onTap;
  final String? warningMessage;

  const OptionButtonSet({
    super.key,
    required this.options,
    this.isMultiSelect = false,
    this.maxMultiSelect = 1,
    this.alignColumn = false,
    this.selectedOption,
    this.selectedOptions = const {},
    required this.onTap,
    this.warningMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (alignColumn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: options.map((label) {
              final isSelected = isMultiSelect
                  ? selectedOptions.contains(label)
                  : selectedOption == label;

              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: OptionButton(
                  label: label,
                  isSelected: isSelected,
                  onTap: () => onTap(label),
                ),
              );
            }).toList(),
          ),
          if (warningMessage != null) ...[
            SizedBox(height: 16.h),
            Text(
              warningMessage!,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: theme().state),
            ),
          ] else
            SizedBox(height: 16.h),
        ],
      );
    } else {
      return Wrap(
        spacing: 8.w,
        children: options.map((label) {
          final isSelected = isMultiSelect
              ? selectedOptions.contains(label)
              : selectedOption == label;

          return OptionButton(
            label: label,
            isSelected: isSelected,
            onTap: () => onTap(label),
          );
        }).toList(),
      );
    }
  }
}

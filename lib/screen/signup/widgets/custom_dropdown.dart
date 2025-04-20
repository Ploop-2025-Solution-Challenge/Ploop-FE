import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ploop_fe/theme.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.entryList,
    required this.selected,
    required this.onSelected,
  });

  final List<String> entryList;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final LayerLink layerLink = LayerLink();
    final GlobalKey key = GlobalKey();

    void showOverlay(BuildContext context) {
      final RenderBox renderBox =
          key.currentContext!.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      late OverlayEntry overlayEntry;

      overlayEntry = OverlayEntry(
        builder: (context) {
          return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    overlayEntry.remove();
                  },
                  child: Container(),
                ),
              ),
              Positioned(
                width: size.width,
                left: offset.dx,
                top: offset.dy + size.height + 5.h,
                child: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8.w),
                  child: Container(
                    height: 297.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2.w),
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x3F000000),
                          blurRadius: 6.w,
                          offset: const Offset(0, 0),
                        )
                      ],
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: entryList.map((e) {
                        return GestureDetector(
                          onTap: () {
                            onSelected(e);
                            overlayEntry.remove();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 12.w),
                            child: Text(
                              e,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: GrayScale.gray_300),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );

      Overlay.of(context).insert(overlayEntry);
    }

    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        key: key,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 14.w),
        width: 370.w,
        height: 47.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2.w),
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selected.isEmpty ? '' : selected,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                showOverlay(context);
              },
              icon: Image.asset(
                'assets/images/dropdown-down.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

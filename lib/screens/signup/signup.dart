import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({super.key, required this.entryList});
  final List<String> entryList;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String selected = "";
  bool isOpened = false;

  final GlobalKey _key = GlobalKey();

  void _toggleDropdown() {
    if (isOpened) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      isOpened = !isOpened;
    });
  }

  void _showOverlay() {
    final RenderBox renderBox =
        _key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        left: offset.dx,
        top: offset.dy + size.height + 5.h,
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(8.w),
          child: Container(
            height: 297.h,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
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
              children: widget.entryList.map((e) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = e;
                      isOpened = false;
                    });
                    _removeOverlay();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFFA1A1A1),
                          ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _key,
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
              onPressed: _toggleDropdown,
              icon: isOpened
                  ? Image.asset('assets/images/dropdown-up.png')
                  : Image.asset('assets/images/dropdown-down.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPageButton extends StatelessWidget {
  const NextPageButton({super.key, required this.route});
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.all(0.w),
        fixedSize: Size(160.w, 54.h),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      // width: 160,
      // padding: EdgeInsets.symmetric(horizontal: 61.w, vertical: 16.h),
      clipBehavior: Clip.antiAlias,
      // decoration: ShapeDecoration(
      // color: Colors.black,
      // shape: RoundedRectangleBorder(
      // borderRadius: BorderRadius.circular(30),
      // ),
      // ),
      child: Text(
        'Next',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}

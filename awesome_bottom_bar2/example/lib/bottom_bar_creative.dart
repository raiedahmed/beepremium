import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar2/awesome_bottom_bar2.dart';

class Creative extends StatefulWidget {
  final List<TabItem> items;
  final HighlightStyle? highlightStyle;
  final bool? isFloating;

  Creative({
    Key? key,
    required this.items,
    this.highlightStyle,
    this.isFloating,
  });

  @override
  _CreativeState createState() => _CreativeState();
}

class _CreativeState extends State<Creative> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarCreative(
        items: widget.items,
        backgroundColor: Colors.green.withOpacity(0.21),
        color: Color(0XFF7AC0FF),
        colorSelected: Color(0XFF0686F8),
        indexSelected: visit,
        highlightStyle: widget.highlightStyle ?? null,
        isFloating: widget.isFloating ?? false,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}

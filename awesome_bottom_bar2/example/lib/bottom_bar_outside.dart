import 'package:awesome_bottom_bar2/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar2/awesome_bottom_bar2.dart';

class OutSide extends StatefulWidget {
  static const String routeName = '/product';
  final List<TabItem> items;
  final ItemStyle? style;
  final ChipStyle? chipStyle;
  final double? top;

  OutSide({
    Key? key,
    required this.items,
    this.chipStyle,
    this.style,
    this.top,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<OutSide> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 87),
          Container(),
          BottomBarInspiredOutside(
            items: widget.items,
            backgroundColor: Color(0XFF1752FE),
            color: Color(0XFF96B1FD),
            colorSelected: Colors.white,
            indexSelected: visit,
            onTap: (int index) => setState(() {
              visit = index;
            }),
            animated: false,
            duration: Duration(microseconds: 0),
            top: widget.top ?? -44,
            itemStyle: widget.style ?? ItemStyle.circle,
            chipStyle: widget.chipStyle ?? ChipStyle(notchSmoothness: NotchSmoothness.defaultEdge),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarInspiredOutside(
        items: widget.items,
        backgroundColor: Color(0XFF1752FE),
        color: Color(0XFF96B1FD),
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
        }),
        itemStyle: widget.style ?? ItemStyle.circle,
        chipStyle: widget.chipStyle ?? ChipStyle(notchSmoothness: NotchSmoothness.defaultEdge),
      ),
    );
  }
}

import 'package:awesome_bottom_bar2/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar2/awesome_bottom_bar2.dart';

class Inside extends StatefulWidget {
  final List<TabItem> items;
  final ItemStyle? style;
  final ChipStyle? chipStyle;

  Inside({
    Key? key,
    required this.items,
    this.style,
    this.chipStyle,
  });

  @override
  _InsideState createState() => _InsideState();
}

class _InsideState extends State<Inside> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 87),
          Container(),
          BottomBarInspiredInside(
            items: widget.items,
            backgroundColor: Color(0XFF1752FE),
            color: Color(0XFF96B1FD),
            colorSelected: Colors.white,
            indexSelected: visit,
            animated: false,
            onTap: (index) => setState(() {
              visit = index;
            }),
            itemStyle: widget.style ?? ItemStyle.circle,
            chipStyle: widget.chipStyle ?? ChipStyle(isHexagon: false),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarInspiredInside(
        items: widget.items,
        backgroundColor: Color(0XFF1752FE),
        color: Color(0XFF96B1FD),
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
        }),
        itemStyle: widget.style ?? ItemStyle.circle,
        chipStyle: widget.chipStyle ?? ChipStyle(isHexagon: false),
      ),
    );
  }
}

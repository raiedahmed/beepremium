import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar2/awesome_bottom_bar2.dart';

class DividerDemo extends StatefulWidget {
  static const String routeName = '/product';
  final List<TabItem> items;
  final StyleDivider? styleDivider;

  DividerDemo({Key? key, required this.items, this.styleDivider});

  @override
  _DividerDemoState createState() => _DividerDemoState();
}

class _DividerDemoState extends State<DividerDemo> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 87),
          BottomBarDivider(
            items: widget.items,
            backgroundColor: Colors.amber,
            color: Colors.grey,
            colorSelected: Colors.blue,
            indexSelected: visit,
            onTap: (index) => setState(() {
              visit = index;
            }),
            duration: Duration(microseconds: 0),
            styleDivider: widget.styleDivider ?? StyleDivider.top,
            countStyle: CountStyle(
              background: Colors.white,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarDivider(
        items: widget.items,
        backgroundColor: Colors.amber,
        color: Colors.grey,
        colorSelected: Colors.blue,
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
        }),
        styleDivider: widget.styleDivider ?? StyleDivider.bottom,
        countStyle: CountStyle(
          background: Colors.white,
          color: Colors.purple,
        ),
      ),
    );
  }
}

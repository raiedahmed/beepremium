import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar2/awesome_bottom_bar2.dart';

class Fancy extends StatefulWidget {
  final List<TabItem> items;
  final StyleIconFooter? style;

  Fancy({Key? key, required this.items, this.style});

  @override
  _FancyState createState() => _FancyState();
}

class _FancyState extends State<Fancy> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          BottomBarInspiredFancy(
            items: widget.items,
            backgroundColor: Colors.green.withOpacity(0.21),
            color: Color(0XFF7AC0FF),
            colorSelected: Color(0XFF0686F8),
            indexSelected: visit,
            styleIconFooter: widget.style ?? StyleIconFooter.divider,
            onTap: (int index) => setState(() {
              visit = index;
            }),
            animated: false,
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
      bottomNavigationBar: BottomBarInspiredFancy(
        items: widget.items,
        backgroundColor: Colors.green.withOpacity(0.21),
        color: Color(0XFF7AC0FF),
        colorSelected: Color(0XFF0686F8),
        indexSelected: visit,
        styleIconFooter: widget.style ?? StyleIconFooter.divider,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}

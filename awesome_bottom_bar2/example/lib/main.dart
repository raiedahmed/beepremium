import 'package:awesome_bottom_bar2/widgets/inspired/inspired.dart';
import 'package:example/bottom_bar_creative.dart';
import 'package:example/bottom_bar_default.dart';
import 'package:example/bottom_bar_fancy.dart';
import 'package:example/bottom_bar_salomon.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar2/awesome_bottom_bar2.dart';

import 'bottom_bar_background.dart';
import 'bottom_bar_divider.dart';
import 'bottom_bar_floating.dart';
import 'bottom_bar_inside.dart';
import 'bottom_bar_outside.dart';

List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.only(left: 16),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          Text('Inside', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_inside_cricle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Inside(
                    items: items,
                    chipStyle: ChipStyle(convexBridge: true),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_inside_hexagon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Inside(
                    items: items,
                    style: ItemStyle.hexagon,
                    chipStyle: ChipStyle(
                      isHexagon: true,
                      convexBridge: true,
                    ),
                  ),
                ),
              );
            },
          ),
          Text('Outside', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_outside_sharpEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutSide(
                    items: items,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_default'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutSide(
                    items: items,
                    style: ItemStyle.circle,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_verySmoothEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutSide(
                    items: items,
                    style: ItemStyle.circle,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_smoothEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutSide(
                    items: items,
                    style: ItemStyle.circle,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.smoothEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_softEdge'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutSide(
                    items: items,
                    style: ItemStyle.circle,
                    chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.softEdge),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_outside_drawHexagon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OutSide(
                    items: items,
                    top: -40,
                    style: ItemStyle.hexagon,
                    chipStyle: ChipStyle(drawHexagon: true),
                  ),
                ),
              );
            },
          ),
          Text('Salomon', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_salomon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Salomon(items: items),
                ),
              );
            },
          ),
          Text('Divider', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_divider_top'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new DividerDemo(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_divider_bottom'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DividerDemo(
                    items: items,
                    styleDivider: StyleDivider.bottom,
                  ),
                ),
              );
            },
          ),
          Text('Fancy', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_fancy_divider'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Fancy(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_fancy_dot'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Fancy(
                    items: items,
                    style: StyleIconFooter.dot,
                  ),
                ),
              );
            },
          ),
          Text('Default', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_default'),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new Default(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_background'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Background(items: items),
                ),
              );
            },
          ),
          Text('Floating', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_floating'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Floating(items: items),
                ),
              );
            },
          ),
          Text('Creative', style: Theme.of(context).textTheme.headline5),
          ListTile(
            title: const Text('Bottom_bar_creative_circle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Creative(items: items),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_creative_hexagon'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Creative(
                    items: items,
                    highlightStyle: HighlightStyle(
                      isHexagon: true,
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Bottom_bar_creative_cirlce_elevation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Creative(
                    items: items,
                    isFloating: true,
                    highlightStyle: HighlightStyle(
                      sizeLarge: true,
                      background: Colors.red,
                      elevation: 3,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ) // Populate the Drawer in the next step.
          ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -25,
              animated: true,
              itemStyle: ItemStyle.hexagon,
              chipStyle: ChipStyle(drawHexagon: true),
            ),
            SizedBox(height: 30),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.sharpEdge),
            ),
            SizedBox(height: 30),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.smoothEdge),
            ),
            SizedBox(height: 30),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
              chipStyle: ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
            ),
            SizedBox(height: 30),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              top: -28,
              animated: false,
              itemStyle: ItemStyle.circle,
            ),
            SizedBox(height: 30),
            BottomBarInspiredInside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              chipStyle: ChipStyle(convexBridge: true),
              itemStyle: ItemStyle.circle,
              animated: false,
            ),
            SizedBox(height: 30),
            BottomBarInspiredInside(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
              animated: false,
              chipStyle: ChipStyle(isHexagon: true, convexBridge: true),
              itemStyle: ItemStyle.hexagon,
            ),
            BottomBarFloating(
              items: items,
              backgroundColor: Color(0XFF1752FE),
              color: Color(0XFF96B1FD),
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              highlightStyle: HighlightStyle(
                isHexagon: true,
              ),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              isFloating: true,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              isFloating: true,
              highlightStyle: HighlightStyle(sizeLarge: true, background: Colors.red, elevation: 3),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              isFloating: true,
              highlightStyle: HighlightStyle(sizeLarge: true, isHexagon: true, elevation: 2),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarInspiredFancy(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarInspiredFancy(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: Color(0XFF7AC0FF),
              colorSelected: Color(0XFF0686F8),
              indexSelected: visit,
              styleIconFooter: StyleIconFooter.dot,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              onTap: (int index) => print('$index'),
              blur: 50,
              countStyle: CountStyle(
                background: Colors.brown,
              ),
            ),
            SizedBox(height: 30),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              iconSize: 40,
              indexSelected: visit,
              titleStyle: TextStyle(fontSize: 18, color: Colors.black),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarDefault(
              items: items,
              backgroundColor: Colors.green,
              color: Colors.white,
              colorSelected: Colors.orange,
              indexSelected: visit,
              paddingVertical: 25,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 30),
            BottomBarDivider(
              items: items,
              backgroundColor: Colors.amber,
              color: Colors.grey,
              colorSelected: Colors.blue,
              indexSelected: visit,
              onTap: (index) => setState(() {
                visit = index;
              }),
              styleDivider: StyleDivider.bottom,
              countStyle: CountStyle(
                background: Colors.white,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 30),
            BottomBarSalomon(
              items: items,
              color: Colors.blue,
              backgroundColor: Colors.white,
              colorSelected: Colors.white,
              backgroundSelected: Colors.blue,
              borderRadius: BorderRadius.circular(0),
              indexSelected: visit,
              onTap: (index) => setState(() {
                visit = index;
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 30, right: 32, left: 32),
        child: BottomBarFloating(
          items: items,
          backgroundColor: Colors.green,
          color: Colors.white,
          colorSelected: Colors.orange,
          indexSelected: visit,
          paddingVertical: 24,
          onTap: (int index) => setState(() {
            visit = index;
          }),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(const BottomAppBarDemo());
// }

// class BottomAppBarDemo extends StatefulWidget {
//   const BottomAppBarDemo({Key? key}) : super(key: key);

//   @override
//   State createState() => _BottomAppBarDemoState();
// }

// class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
//   bool _showFab = true;
//   bool _showNotch = true;
//   FloatingActionButtonLocation _fabLocation =
//       FloatingActionButtonLocation.endDocked;

//   void _onShowNotchChanged(bool value) {
//     setState(() {
//       _showNotch = value;
//     });
//   }

//   void _onShowFabChanged(bool value) {
//     setState(() {
//       _showFab = value;
//     });
//   }

//   void _onFabLocationChanged(FloatingActionButtonLocation? value) {
//     setState(() {
//       _fabLocation = value ?? FloatingActionButtonLocation.endDocked;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text('Bottom App Bar Demo'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.only(bottom: 88),
//           children: <Widget>[
//             SwitchListTile(
//               title: const Text(
//                 'Floating Action Button',
//               ),
//               value: _showFab,
//               onChanged: _onShowFabChanged,
//             ),
//             SwitchListTile(
//               title: const Text('Notch'),
//               value: _showNotch,
//               onChanged: _onShowNotchChanged,
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: Text('Floating action button position'),
//             ),
//             RadioListTile<FloatingActionButtonLocation>(
//               title: const Text('Docked - End'),
//               value: FloatingActionButtonLocation.endDocked,
//               groupValue: _fabLocation,
//               onChanged: _onFabLocationChanged,
//             ),
//             RadioListTile<FloatingActionButtonLocation>(
//               title: const Text('Docked - Center'),
//               value: FloatingActionButtonLocation.centerDocked,
//               groupValue: _fabLocation,
//               onChanged: _onFabLocationChanged,
//             ),
//             RadioListTile<FloatingActionButtonLocation>(
//               title: const Text('Floating - End'),
//               value: FloatingActionButtonLocation.endFloat,
//               groupValue: _fabLocation,
//               onChanged: _onFabLocationChanged,
//             ),
//             RadioListTile<FloatingActionButtonLocation>(
//               title: const Text('Floating - Center'),
//               value: FloatingActionButtonLocation.centerFloat,
//               groupValue: _fabLocation,
//               onChanged: _onFabLocationChanged,
//             ),
//           ],
//         ),
//         floatingActionButton: _showFab
//             ? FloatingActionButton(
//                 onPressed: () {},
//                 child: const Icon(Icons.add),
//                 tooltip: 'Create',
//               )
//             : null,
//         floatingActionButtonLocation: _fabLocation,
//         bottomNavigationBar: _DemoBottomAppBar(
//           fabLocation: _fabLocation,
//           shape: _showNotch ? const CircularNotchedRectangle() : null,
//         ),
//       ),
//     );
//   }
// }

// class _DemoBottomAppBar extends StatelessWidget {
//   const _DemoBottomAppBar({
//     this.fabLocation = FloatingActionButtonLocation.endDocked,
//     this.shape = const CircularNotchedRectangle(),
//   });

//   final FloatingActionButtonLocation fabLocation;
//   final NotchedShape? shape;

//   static final List<FloatingActionButtonLocation> centerLocations =
//       <FloatingActionButtonLocation>[
//     FloatingActionButtonLocation.centerDocked,
//     FloatingActionButtonLocation.centerFloat,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: shape,
//       color: Colors.blue,
//       child: IconTheme(
//         data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//         child: Row(
//           children: <Widget>[
//             IconButton(
//               tooltip: 'Open navigation menu',
//               icon: const Icon(Icons.menu),
//               onPressed: () {},
//             ),
//             if (centerLocations.contains(fabLocation)) const Spacer(),
//             IconButton(
//               tooltip: 'Search',
//               icon: const Icon(Icons.search),
//               onPressed: () {},
//             ),
//             IconButton(
//               tooltip: 'Favorite',
//               icon: const Icon(Icons.favorite),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

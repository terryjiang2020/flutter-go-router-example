import 'package:androidrouting/visual_exact_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const settings = Center(
      child: Text(
        'Home 1',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
    const settings2 = Center(
      child: Text(
        'Home 2',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
    final children = <Widget>[
      // The new ListView with constrained height
      SizedBox(
        height: 300.0,  // Set the height of the ListView
        child: ListView(
          key: GlobalKey(debugLabel: 'home-listview-1'),
          controller: ScrollController(),
          children: const [
            ListTile(
              title: Text('Inner Tile 1'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 2'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 3'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 4'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 5'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 6'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 7'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 8'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 9'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 10'),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      const ListTile(
        title: settings,
      ),
      const ListTile(
        title: settings2,
      ),
      // The new ListView with constrained height
      SizedBox(
        height: 300.0,  // Set the height of the ListView
        child: ListView(
          key: GlobalKey(debugLabel: 'home-listview-2'),
          controller: ScrollController(),
          children: const [
            ListTile(
              title: Text('Inner Tile 1'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 2'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 3'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 4'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 5'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 6'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 7'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 8'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 9'),
              textColor: Colors.white,
            ),
            ListTile(
              title: Text('Inner Tile 10'),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    ];

    return Center(
      // child: Text(
      //   'Home',
      //   style: TextStyle(
      //     color: Colors.white
      //   ),
      // ),
      child: ListView(
        key: GlobalKey(debugLabel: 'home'),
        controller: ScrollController(),
        children: children
      ),
      // child: SingleChildScrollView(
      //   key: GlobalKey(debugLabel: 'home'),
      //   controller: ScrollController(),
      //   child: Column(
      //     key: GlobalKey(debugLabel: 'home-column'),
      //     children: children
      //   ),
      // ),
    );
  }
}
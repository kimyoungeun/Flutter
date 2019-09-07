import 'package:flutter/material.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.airplay)),
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.face)),
                Tab(icon: Icon(Icons.play_circle_filled)),
              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Image.asset('images/1.png'),
              Image.asset('images/2.png'),
              Image.asset('images/3.png'),
              Image.asset('images/4.png'),
            ],
          ),
        ),
      ),
    );
  }
}
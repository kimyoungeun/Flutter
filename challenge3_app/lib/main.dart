import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("First Screen"),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Next Screen"),
              leading: Icon(Icons.apps),
              onTap: (){
                Navigator.push(context,
                  new MaterialPageRoute(
                    builder: (context) => SecondRoute(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Raining"),
              leading: Icon(Icons.beach_access),
            ),
            ListTile(
              title: Text("Sunny"),
              leading: Icon(Icons.wb_sunny),
            )
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Go to third screen?"),
            onTap: (){
              Navigator.push(context,
                new MaterialPageRoute(
                  builder: (context) => ThirdRoute(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Or go back?"),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ]
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
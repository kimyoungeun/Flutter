import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Themes',
      home: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            title: Text('Custom Themes'),
          ),
          body: Center(
            child: Container(
              child: (
                  Text('Text with a background color',
                    style: TextStyle(color: Colors.white),
                  )
              ),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
          ),
          floatingActionButton: SnackBarPage()
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('HonorCode!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}
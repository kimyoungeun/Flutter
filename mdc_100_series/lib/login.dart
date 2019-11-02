// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                FlatButton(
                  child: Text('SIGN UP'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpRoute()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home'); //Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class SignUpRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 100.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _usernameController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Username',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Username';
              }
              return null;
            },
          ),
          SizedBox(height: 12.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _passwordController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (value) => value.isEmpty ? 'Please enter Password':null,
          ),
          SizedBox(height: 12.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _confirmpasswordController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Confirm Password',
            ),
            obscureText: true,
            validator: (value) => value.isEmpty ? 'Please enter Confirm Password':null,
          ),
          SizedBox(height: 12.0),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _addressController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Email Address',
            ),
            validator: (value) => value.isEmpty ? 'Please enter Address':null,
          ),
          ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('SIGN UP'),
                )
              ]
          )
        ],
      ),
    );
  }
}
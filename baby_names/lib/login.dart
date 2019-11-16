import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

bool success;
String userID;
String userEMAIL;
String userPHOTO;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) => Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  _GoogleSignInSection(),
                  SizedBox(height: 20.0),
                  _AnonymouslySignInSection(),
                ],
              )
            ],
        )
      )
    );
  }
}

class _GoogleSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<_GoogleSignInSection> {
  bool _success;
  String _userID;
  String _userEMAIL;
  String _userPHOTO;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: 250, height: 50,
            child: RaisedButton(
              child: Text('GOOGLE', style: TextStyle(color: Colors.white)),
              color: Colors.red[200],
              onPressed: () async {
                _signInWithGoogle();
                Navigator.pushNamed(context, '/home');
              }
            ),
          ),
        ),
      ],
    );
  }

  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    assert(user.photoUrl != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _success = true;
        _userID = user.uid;
        _userEMAIL = user.email;
        _userPHOTO = user.photoUrl;
      } else {
        _success = false;
      }
    });
    success = _success;
    userID = _userID;
    userEMAIL = _userEMAIL;
    userPHOTO = _userPHOTO;
  }
}

class _AnonymouslySignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnonymouslySignInSectionState();
}

class _AnonymouslySignInSectionState extends State<_AnonymouslySignInSection> {
  bool _success;
  String _userID;
  String _userEMAIL;
  String _userPHOTO;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: 250, height: 50,
            child: RaisedButton(
              child: Text('GUEST', style: TextStyle(color: Colors.white)),
              color: Colors.grey,
              onPressed: () async {
                _signInAnonymously();
                Navigator.pushNamed(context, '/home');
              }
            ),
          ),
        ),
      ],
    );
  }

  void _signInAnonymously() async {
    final FirebaseUser user = (await _auth.signInAnonymously()).user;
    assert(user != null);
    assert(user.isAnonymous);
    assert(!user.isEmailVerified);
    assert(await user.getIdToken() != null);

    if (Platform.isIOS) {
      assert(user.providerData.isEmpty);
    } else if (Platform.isAndroid) {
      assert(user.providerData.length == 1);
      assert(user.providerData[0].providerId == 'firebase');
      assert(user.providerData[0].uid != null);
      assert(user.providerData[0].displayName == null);
      assert(user.providerData[0].photoUrl == null);
      assert(user.providerData[0].email == null);
    }

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _success = true;
        _userID = user.uid;
        _userEMAIL = "anonymous";
        _userPHOTO = "http://handong.edu/site/handong/res/img/logo.png";
      } else {
        _success = false;
      }
    });
    success = _success;
    userID = _userID;
    userEMAIL = _userEMAIL;
    userPHOTO = _userPHOTO;
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                _signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            );
          })
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.network(userPHOTO, fit: BoxFit.fitWidth)
            ),
            SizedBox(height: 100),
            Text(
              success == null
                ? ''
                : (success
                    ? '<Uid> ' + userID + '\n\n' + '<Email> ' + userEMAIL
                    : 'Sign in failed'
                  ),
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
  }
}


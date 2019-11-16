import 'login.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final myName = TextEditingController();
final myPrice = TextEditingController();
final myDescription = TextEditingController();
File _image;

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<HomePage> {
  String dropdownValue = 'ASC';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Main'),
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
              },
            )
          ],
      ),
      body: Column(
        children: <Widget>[
          FittedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 30, top: 20),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['ASC', 'DESC']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 40),
          _buildBody(context)
        ],
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {

    if(dropdownValue == "DESC") {
      snapshot.sort((a, b) {
        return b["price"].compareTo(a["price"]);
      });
    }

    else if(dropdownValue == "ASC") {
      snapshot.sort((a, b) {
        return a["price"].compareTo(b["price"]);
      });
    }

    return Expanded(
        child: GridView.count(
          padding: const EdgeInsets.only(top: 0.0),
          crossAxisCount: 2,
          childAspectRatio: 8.0 / 8.0,
          children: snapshot.map((data) => _buildListItem(context, data)).toList(),
        )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final ThemeData theme = Theme.of(context);
    final record = Record.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: (record.url!="http://handong.edu/site/handong/res/img/logo.png")
                ?
                Image.asset(record.url, fit: BoxFit.fill)
                :
               Image.network('http://handong.edu/site/handong/res/img/logo.png', fit: BoxFit.fitWidth)
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      record.name,
                      style: theme.textTheme.title,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Text('\$ '),
                        Text(
                          record.price,
                          style: theme.textTheme.body2,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.0),
                    InkWell(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("more", style: TextStyle(fontSize: 10, color: Colors.blue)),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(todo: record)));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final String price;
  final String description;
  final DocumentReference reference;
  final String id;
  final int votes;
  final Timestamp created;
  final Timestamp modified;
  final String url;
  final String documentName;
  List check = List<String>();

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['price'] != null),
        assert(map['description'] != null),
        assert(map['id'] != null),
        assert(map['votes'] != null),
        //assert(map['created'] != null),
        //assert(map['modified'] != null),
        //assert(map['url'] != null),
        assert(map['documentName'] != null),
        assert(map['check'] != null),
        name = map['name'],
        price = map['price'],
        description = map['description'],
        id = map['id'],
        votes = map['votes'],
        created = map['created'],
        modified = map['modified'],
        url = map['url'],
        documentName = map['documentName'],
        check = map['check'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$price:$description:$id:$votes:$created:$modified:$url:$documentName:$check>";
}

class AddPage extends StatefulWidget {
  @override
  _AddPage createState() {
    return _AddPage();
  }
}

class _AddPage extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
        String fileName = basename(_image.path);
        StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        setState(() {
          print("Profile Picture uploaded");
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
        backgroundColor: Colors.grey,
        leading: FittedBox(
          child: FlatButton(
            child: Text('Cancel', style: TextStyle(fontSize: 20)),
            onPressed: () {
              _image = null;
              myName.clear();
              myPrice.clear();
              myDescription.clear();
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save', style: TextStyle(fontSize: 15)),
            onPressed: () {
              uploadPic(context);
              if(myName.text.isNotEmpty){
                if(_image == null){
                  Firestore.instance.collection("baby").document(
                      myName.text.toLowerCase())
                      .setData({'name': myName.text,
                    'price': myPrice.text,
                    'description': myDescription.text,
                    'id': userID,
                    'votes': 0,
                    'created': FieldValue.serverTimestamp(),
                    'modified': FieldValue.serverTimestamp(),
                    'url': "http://handong.edu/site/handong/res/img/logo.png",
                    'documentName' : myName.text,
                    'check' : [null]});
                  Navigator.of(context).pop();
                  myName.clear();
                  myPrice.clear();
                  myDescription.clear();
                  _image = null;
                }
                else {
                  Firestore.instance.collection("baby").document(
                      myName.text.toLowerCase())
                      .setData({'name': myName.text,
                    'price': myPrice.text,
                    'description': myDescription.text,
                    'id': userID,
                    'votes': 0,
                    'created': FieldValue.serverTimestamp(),
                    'modified': FieldValue.serverTimestamp(),
                    'url': _image.path,
                    'documentName' : myName.text,
                     'check' : [null]});
                  Navigator.of(context).pop();
                  myName.clear();
                  myPrice.clear();
                  myDescription.clear();
                  _image = null;
                }
              }
              else if(myName.text.isEmpty){
                Navigator.of(context).pop();
                myName.clear();
                myPrice.clear();
                myDescription.clear();
                _image = null;
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child:
              (_image==null)
              ?
              Image.network('http://handong.edu/site/handong/res/img/logo.png', fit: BoxFit.fitWidth)
              :
              Image.file(_image, fit: BoxFit.fill)
          ),
          Container(
            margin: const EdgeInsets.only(left: 330),
            child: IconButton(
              icon: Icon(
                Icons.photo_camera,
                size: 30.0,
              ),
              onPressed: () {
                getImage();
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              controller: myName,
              decoration: InputDecoration(
                hintText: 'Product Name',
                hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              controller: myPrice,
              decoration: InputDecoration(
                hintText: 'Price',
                hintStyle: TextStyle(color: Colors.lightBlueAccent),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 40, right: 40),
            child: TextField(
              controller: myDescription,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.lightBlueAccent),
              ),
            ),
          ),
        ],
      )
    );
  }
}

class DetailPage extends StatefulWidget {
  final Record todo;
  DetailPage({Key key, @required this.todo}) : super(key: key);
  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                if(widget.todo.id == userID) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(todo: widget.todo)),
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if(widget.todo.id == userID) {
                  Firestore.instance.collection("baby").document(widget.todo.documentName.toLowerCase()).delete();
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
        body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('baby').where('documentName', isEqualTo: widget.todo.documentName).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Column(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
      children: <Widget>[
        AspectRatio(
            aspectRatio: 18 / 15,
            child: (record.url!="http://handong.edu/site/handong/res/img/logo.png")
                ?
            Image.asset(record.url, fit: BoxFit.fill)
                :
            Image.network('http://handong.edu/site/handong/res/img/logo.png', fit: BoxFit.fitWidth)
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40, top: 10),
              child: Text (record.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blueAccent)),
            ),
            Container(
              padding: EdgeInsets.only(left: 100),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.thumb_up, color: Colors.red, size: 30),
                      onPressed: () {

                        bool _test = false;
                        for(int i = 0; i < record.check.length; i++){
                          if (record.check[i] == userID) _test = true;
                        }

                        if(_test == true){
                          final snackBar = SnackBar(content: Text('You can only do it once!!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }

                        else if(_test == false){
                          record.reference.updateData({'votes': FieldValue.increment(1), 'check': FieldValue.arrayUnion([userID])});
                          final snackBar = SnackBar(content: Text('I LIKE IT!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }

                      }
                  ),
                  Text(record.votes.toString(), style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 40, top: 10),
          child: Row(
            children: <Widget>[
              Text('\$ ', style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
              Text(record.price, style: TextStyle(fontSize: 20, color: Colors.blueAccent)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: Divider(color: Colors.black),
        ),
        Container(
            padding: EdgeInsets.only(left: 40, top: 10),
            child: Row(
                children: <Widget>[
                  Text (record.description, style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
                ]
            )
        ),
        Container(
          padding: EdgeInsets.only(left: 40, top: 100),
          child: Row(
            children: <Widget>[
              Text('Creator: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
              Text (record.id, style: TextStyle(fontSize: 15, color: Colors.black)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 40, top: 5),
          child: Row(
            children: <Widget>[
              Text(record.created.toDate().toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
              Text(' Created', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 40, top: 5),
          child: Row(
            children: <Widget>[
              Text(record.modified.toDate().toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
              Text(' Modified', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            ],
          ),
        ),
      ],
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Record todo;
  const EditPage({Key key, this.todo}) : super(key: key);
  @override
  _EditPage createState() {
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
  final _myName = TextEditingController();
  final _myPrice = TextEditingController();
  final _myDescription = TextEditingController();

  String imageimage = '';


  @override
  void initState() {
    _myName.text = widget.todo.name;
    _myPrice.text = widget.todo.price;
    _myDescription.text = widget.todo.description;
  }

  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
          backgroundColor: Colors.grey,
          leading: FittedBox(
            child: FlatButton(
              child: Text('Cancel', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _image = null;
                _myName.clear();
                _myPrice.clear();
                _myDescription.clear();
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Save', style: TextStyle(fontSize: 15)),
              onPressed: () {
                uploadPic(context);

                if(imageimage == ''){
                  imageimage = widget.todo.url;
                }

                if(_image == null) {
                  widget.todo.reference.updateData(
                    {
                      'name': _myName.text,
                      'price' : _myPrice.text,
                      'description' : _myDescription.text,
                      'url': imageimage,
                      'modified': FieldValue.serverTimestamp()
                    }
                  );
                }
                else {
                  widget.todo.reference.updateData(
                    {
                      'name': _myName.text,
                      'price': _myPrice.text,
                      'description': _myDescription.text,
                      'url': _image.path,
                      'modified': FieldValue.serverTimestamp()
                    }
                  );
                }

                _myName.clear();
                _myPrice.clear();
                _myDescription.clear();
                _image = null;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 18 / 11,
                child: (_image != null)
                    ?
                Image.file(_image, fit: BoxFit.fill)
                    :
                (
                    (widget.todo.url != "http://handong.edu/site/handong/res/img/logo.png")
                    ? Image.asset(widget.todo.url, fit: BoxFit.fill)
                    : Image.network('http://handong.edu/site/handong/res/img/logo.png', fit: BoxFit.fitWidth)
                )
            ),
            Container(
              margin: const EdgeInsets.only(left: 330),
              child: IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  size: 30.0,
                ),
                onPressed: () {
                  getImage();
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: _myName,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: _myPrice,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: _myDescription,
              ),
            ),
          ],
        )
    );
  }
}
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
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Choice {
  Choice({this. icon, this.pic, this.name, this.location, this.phone, this.description});
  final int icon;
  final String pic;
  final String name;
  final String location;
  final String phone;
  final String description;
}

List<Choice> choices = <Choice>[
  Choice(icon: 1, pic: 'images/hotel1.png', name: "Abc Hotel", location: "238, Gan-daero, Gangnam-gu, Seoul", phone: "010-9127-5358", description: "KBS 방송국 바로 옆에 있는 글래드 호텔 여의도는 9호선 국회의사당역 4번 출구에서 도보 1분 거리에 있습니다. 여의도 공원은 도보로 5분 거리에 있으며 걸어서 15분이면 IFC 몰에 도착하실 수 있습니다. 차로 15분이면 63빌딩과 한강 유람선 선착장에 도착하실 수 있습니다."),
  Choice(icon: 2, pic: 'images/hotel2.png', name: "Busan Hotel", location: "787, Gadal 10-ro, Gangseo-gu, Busan", phone: "010-1111-1111", description: "신라스테이 광화문은 5호선 광화문역 2번 출구에서 도보로 5분 거리에 있습니다. 가까운 도보 거리에 시청, 대사관, 서울 파이낸스 센터 등이 있어 비즈니스 여행객에게 편리한 위치를 자랑합니다. 뿐만 아니라 서울 4대 고궁, 북촌한옥마을과 명동까지 차로 약 10분이면 가실 수 있어 관광객분들께도 최적의 위치를 자랑합니다."),
  Choice(icon: 3, pic: 'images/hotel3.png', name: "Daegu Hotel", location: "135, Gyeongsang-gil, Nam-gu, Daegu", phone: "010-2222-2222", description: "글래드 강남 코엑스센터는 지하철 2호선 삼성역 1번 출구에서 도보로 단 1분 거리에 위치해 있습니다. 주변 관광지로는 코엑스몰과 무역센터가 도보로 10분 거리에 있습니다. 또한 압구정 로데오거리까지는 차로 15분이면 가실 수 있으며, 신사동 가로수길까지는 차로 약 20분이 소요됩니다."),
  Choice(icon: 3, pic: 'images/hotel4.png', name: "Daejeon Hotel", location: "23, Gapcheon, Daedeok-gu, Daejeon", phone: "010-3333-3333", description: "L7 강남 바이 롯데는 지하철 2호선 선릉역 10번 출구에서 도보 단 5분 거리에 위치해 있습니다. 세계문화유산으로 등록된 선릉과정릉은 도보 단 3분 거리에 있으며, 도보 20분, 차로 5분이면 코엑스몰까지 가실 수 있습니다. 또한, 신사동 가로수길은 차로 약 15분 거리에 있습니다."),
  Choice(icon: 4, pic: 'images/hotel5.png', name: "Jeju Hotel", location: "140, Gaga 19-ro, Seogwipo-si, Jeju-do", phone: "010-4444-4444", description: "신라 스테이 서대문은 5호선 서대문역 7, 8번 출구 바로 앞에 있습니다. 차로 10분 거리에 시청, 서울 파이낸스 센터 등이 있어 비즈니스 여행객에게 편리한 위치를 자랑합니다. 뿐만 아니라 명동, 롯데백화점 본점, 남대문 등도 차로 10분 거리에 있어 쇼핑을 즐기시기에 편리한 위치를 자랑합니다."),
  Choice(icon: 4, pic: 'images/hotel6.png', name: "Hanam Hotel", location: "17, nam-ro, Hanam-si, Gyeonggi-do", phone: "010-5555-5555", description: "신라스테이 역삼은 2호선 역삼역과 선릉역에서 도보 10분 거리에 있습니다. 역삼역에서 단 한 정거장이면 강남으로 가실 수 있고, 선릉역에서 한 정거장이면 코엑스 몰까지 가실 수 있습니다. 걸어서 10분이면 테헤란로까지 가실 수 있고, 자동차로 10분이면 압구정 로데오거리, 가로수길 등을 가실 수 있습니다."),
  Choice(icon: 5, pic: 'images/hotel7.png', name: "def Hotel", location: "72, nono 38-ro, Incheon-si, Jeju-do", phone: "010-6666-6666", description: "호텔 건물 지하 2층에는 미팅룸과 피트니스 센터가 갖춰져 있습니다. 1층에는 비즈니스 라운지가 마련되어 있어 편리하게 업무도 보실 수 있습니다."),
  Choice(icon: 5, pic: 'images/hotel8.png', name: "Gimpo Hotel", location: "66, se-ro, Gimpo-si, Gimpo-do", phone: "010-7777-7777", description: "호텔 1층에는 이탈리아 대표 커피 브랜드 '세가프레도', 그리고 지하 1층에는 컨템포러리 유러피안 다이닝 '레스토랑 G', 지하 2층에는 제철 식재료를 사용한 프리미엄 '뷔페 G' 가 있습니다."),
];

final List<Choice> _saved = List<Choice>();

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.photo, this.onTap, this.width }) : super(key: key);
  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  ChoiceCard(
      {Key key, this.choice, this.onTap, @required this.item, this.selected: false, this.num}
      ) : super(key: key);
  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;
  final int num;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 9 / 6,
            child: PhotoHero(
                photo: choice.pic,
                width: 300.0,
                onTap: (){
                }
            ),
          ),
          Row(
            children: <Widget>[
              Container(width: 5),
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 10,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: List.generate(5, (index){
                          return Icon(
                              index < choice.icon ? Icons.star: null,
                              color: Colors.yellow, size: 14
                          );
                        }),
                      ),
                      SizedBox(height: 1.0),
                      Text(
                        choice.name, style: theme.textTheme.title, maxLines: 1
                      ),
                      SizedBox(height: 1.0),
                      Text(
                        choice.location, style: theme.textTheme.subtitle, maxLines: 2
                      ),
                      SizedBox(height: 1.0),
                      InkWell(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("more", style: TextStyle(fontSize: 10, color: Colors.blue)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(todo: choices[num]),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
              Navigator.pushNamed(context, '/web');
            },
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            padding: EdgeInsets.all(18.0),
            childAspectRatio: 7.5 / 9.0,
            children: List.generate(choices.length, (index) {
              return Center(
                child: ChoiceCard(choice: choices[index], item: choices[index], num: index),
              );
            }),
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Pages', style: TextStyle(height: 6, fontSize: 25.0, color: Colors.white)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('Home', style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.blue),
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: Icon(Icons.location_city, color: Colors.blue),
              title: Text('Favorite Hotels'),
              onTap: () {
                Navigator.pushNamed(context, '/favorite');
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.blue),
              title: Text('Website'),
              onTap: () {
                Navigator.pushNamed(context, '/web');
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('My Page'),
              onTap: () {
                Navigator.pushNamed(context, '/my');
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePage createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Hotels'),
      ),
      body: ListView.builder(
        itemCount: _saved.length,
        itemBuilder: (context, index) {
          final item = _saved[index];
          return Dismissible(
            key: Key(item.name),
            onDismissed: (direction) {
              setState(() {
                _saved.removeAt(index);
              });
            },
            background: Container(color: Colors.red),
            child: ListTile(title: Text(item.name)),
          );
        },
      ),
    );
  }
}

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Website Page'),
      ),
      body: const WebView(
        initialUrl: 'https://www.handong.edu/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final Choice todo;
  MyPage(
      {Key key, @required this.todo}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget hotelimage = new Column(
      children : [
        new Container(
            height: 500.0,
            child: CarouselSlider(
              autoPlay: true,
              height: 400.0,
              items: _saved.map((todo) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children : [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                                child: Image.asset(todo.pic, fit: BoxFit.fill),
                                onTap: (){
                                  Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: DetailPage(todo: todo)));
                                }
                            )
                        ),
                        Row(
                          children : [
                            SizedBox(width: 40, height: 230),
                            Text(todo.name,
                              style: TextStyle(fontSize: 40, color: Colors.cyanAccent, fontWeight: FontWeight.bold) ,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            )
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: new Column(
        children: <Widget>[
          if(_saved.length ==0) Text(" ")
          else hotelimage,
        ],
      )
    );
  }
}

class DetailPage extends StatelessWidget {
  final Choice todo;

  DetailPage(
      {Key key, @required this.todo}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Detail Page')
      ),
      body: ListView(
        children: [
          new Stack(
            children: <Widget>[
              PhotoHero(
                  photo: todo.pic,
                  width: 500.0,
                  onTap: (){
                    Navigator.of(context).pop();
                  }
              ),
              new Positioned(
                right: 8.0,
                child: FavoriteWidget(todo: todo),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Row(
              children: List.generate(5, (index){
                return Icon(
                    index < todo.icon ? Icons.star: null,
                    color: Colors.yellow, size: 30
                );
              }),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text (todo.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blueAccent)),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: new Row(
                children: <Widget>[
                  Icon (Icons.location_on, color: Colors.lightBlueAccent, size: 20),
                  SizedBox(width: 10),
                  Text (todo.location, style: TextStyle(fontSize: 15, color: Colors.blue)),
                ]
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: new Row(
                children: <Widget>[
                  Icon (Icons.phone, color: Colors.lightBlueAccent, size: 20),
                  SizedBox(width: 10),
                  Text (todo.phone, style: TextStyle(fontSize: 15, color: Colors.blue)),
                ]
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
            child: Divider(height: 1.0, color: Colors.black26),
          ),

          Container(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Text (todo.description, style: TextStyle(fontSize: 15, color: Colors.blue)),
          ),

        ],
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  final Choice todo;
  FavoriteWidget({Key key, @required this.todo}) : super(key: key);
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    bool alreadySaved = _saved.contains(widget.todo);
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.all(0),
      child: IconButton(
        icon: (alreadySaved ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
        color: Colors.red,
        onPressed: (){
          setState(() {
            if (alreadySaved) {
              _saved.remove(widget.todo);
            } else {
              _saved.add(widget.todo);
            }
          });
        },
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: ListView(
        children: <Widget>[
          LocationWidget(),
          ClassWidget(),
          DateWidget(),
          Divider(height: 1.0, color: Colors.black),
          feeWidget(),
          Container(
            padding: EdgeInsets.only(left: 130, right: 130),
            child: RaisedButton(
              color: Colors.lightBlue,
              child: Text('Search'),
              onPressed: () => _neverSatisfied(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _neverSatisfied(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            child: Text('Please check your choice :)', style: TextStyle(fontSize: 20)),
            color: Colors.lightBlue,
            margin: EdgeInsets.only(bottom: 30),
          ),
          content: SingleChildScrollView(
              child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(children: <Widget>[
                                Icon(Icons.location_on, color: Colors.lightBlueAccent),
                              ],),
                              margin: EdgeInsets.only(right: 10),
                            ),
                            Text(_LocationWidgetState().locationPrint()),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(children: <Widget>[
                                Icon(Icons.star, color: Colors.yellow),
                              ],),
                              margin: EdgeInsets.only(right: 10),
                            ),
                            if(one == true) classPrint1(),
                            Container(child: Row(), margin: EdgeInsets.only(right: 7),),
                            if(two == true) classPrint2(),
                            Container(child: Row(), margin: EdgeInsets.only(right: 7),),
                            if(three == true) classPrint3(),
                            Container(child: Row(), margin: EdgeInsets.only(right: 7),),
                            if(four == true) classPrint4(),
                            Container(child: Row(), margin: EdgeInsets.only(right: 7),),
                            if(five == true) classPrint5(),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(children: <Widget>[
                                Icon(Icons.date_range, color: Colors.lightBlueAccent),
                              ],),
                              margin: EdgeInsets.only(right: 10),
                            ),
                            Container(
                              child: Column(
                                children: <Widget> [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(children: <Widget>[
                                          Text("in", style: TextStyle(fontSize: 11)),
                                        ],),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Container(
                                        child: Row(children: <Widget>[
                                          _DateWidgetState().datePrint1(),
                                        ],),
                                        margin: EdgeInsets.only(right: 13),
                                      ),
                                      _DateWidgetState().timePrint1(),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(children: <Widget>[
                                          Text("out", style: TextStyle(fontSize: 11)),
                                        ],),
                                        margin: EdgeInsets.only(right: 10),
                                      ),
                                      Container(
                                        child: Row(children: <Widget>[
                                          _DateWidgetState().datePrint2(),
                                        ],),
                                        margin: EdgeInsets.only(right: 13),
                                      ),
                                      _DateWidgetState().timePrint2(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(children: <Widget>[
                                Icon(Icons.attach_money, color: Colors.grey),
                              ],),
                              margin: EdgeInsets.only(right: 10),
                            ),
                            Text(_feeWidgetState().feePrint()),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                      ),
                    ],
                  )
              )
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget classPrint1() {
    Widget classData;
    classData = Row(
      children: List.generate(1, (index) {
        return Icon(index < 1 ? Icons.star : null, color: Colors.yellowAccent, size: 15);
      }),
    );
    return classData;
  }

  Widget classPrint2() {
    Widget classData;
    classData = Row(
      children: List.generate(2, (index) {
        return Icon(index < 2 ? Icons.star : null, color: Colors.yellowAccent, size: 15);
      }),
    );
    return classData;
  }

  Widget classPrint3() {
    Widget classData;
    classData = Row(
      children: List.generate(3, (index) {
        return Icon(index < 3 ? Icons.star : null, color: Colors.yellowAccent, size: 15);
      }),
    );
    return classData;
  }

  Widget classPrint4() {
    Widget classData;
    classData = Row(
      children: List.generate(4, (index) {
        return Icon(index < 4 ? Icons.star : null, color: Colors.yellowAccent, size: 15);
      }),
    );
    return classData;
  }

  Widget classPrint5() {
    Widget classData;
    classData = Row(
      children: List.generate(5, (index) {
        return Icon(index < 5 ? Icons.star : null, color: Colors.yellowAccent, size: 15);
      }),
    );
    return classData;
  }
}

class LocationWidget extends StatefulWidget {
  LocationWidget({Key key}) : super(key: key);
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

enum SingingCharacter { Seoul, Busan, Daegu }
SingingCharacter _character = SingingCharacter.Seoul;
class _LocationWidgetState extends State<LocationWidget> {
  var _expansionStates = <bool>[false, false];

  Widget build(BuildContext context) {
    return Container(
      child: ExpansionPanelList(
        expansionCallback: (int panelIndex, bool isExpanded){
          setState((){
            _expansionStates[panelIndex]= !isExpanded;
          });
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            isExpanded: _expansionStates[0],
            headerBuilder: (BuildContext context, bool isExpanded){
              return Text("  Location           select location", style: TextStyle(fontSize: 18, height: 2), textAlign: TextAlign.left);
            },
            body: Container(
              margin: EdgeInsets.only(left: 100),
              child:
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Seoul'),
                    leading: Radio(
                      value: SingingCharacter.Seoul,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Busan'),
                    leading: Radio(
                      value: SingingCharacter.Busan,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Daegu'),
                    leading: Radio(
                      value: SingingCharacter.Daegu,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String locationPrint(){
    String loca = '$_character';
    String returnLocation = loca.substring(17, 22);
    return returnLocation;
  }
}

class ClassWidget extends StatefulWidget {
  ClassWidget({Key key}) : super(key: key);
  @override
  _ClassWidgetState createState() => _ClassWidgetState();
}

bool one = false; bool two = false; bool three = false; bool four = false; bool five = false;
class _ClassWidgetState extends State<ClassWidget> {
  var _expansionStates = <bool>[false, false];

  Widget build(BuildContext context) {
    return Container(
      child: ExpansionPanelList(
        expansionCallback: (int panelIndex, bool isExpanded){
          setState((){
            _expansionStates[panelIndex]= !isExpanded;
          });
        },
        children: <ExpansionPanel>[
          ExpansionPanel(
            isExpanded: _expansionStates[0],
            headerBuilder: (BuildContext context, bool isExpanded){
              return Text("  Class                select hotel classes", style: TextStyle(fontSize: 18, height: 2), textAlign: TextAlign.left);
            },
            body: Container(
              margin: EdgeInsets.only(left: 115),
              child:
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: one,
                        onChanged: (bool value) {setState(() {one = value;});},
                      ),
                      Row(
                        children: List.generate(5, (index){
                          return Icon(index < 1 ? Icons.star: null, color: Colors.yellow, size: 20);
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: two,
                        onChanged: (bool value) {setState(() {two = value;});},
                      ),
                      Row(
                        children: List.generate(5, (index){
                          return Icon(index < 2 ? Icons.star: null, color: Colors.yellow, size: 20);
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: three,
                        onChanged: (bool value) {setState(() {three = value;});},
                      ),
                      Row(
                        children: List.generate(5, (index){
                          return Icon(index < 3 ? Icons.star: null, color: Colors.yellow, size: 20);
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: four,
                        onChanged: (bool value) {setState(() {four = value;});},
                      ),
                      Row(
                        children: List.generate(5, (index){
                          return Icon(index < 4 ? Icons.star: null, color: Colors.yellow, size: 20);
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: five,
                        onChanged: (bool value) {setState(() {five = value;});},
                      ),
                      Row(
                        children: List.generate(5, (index){
                          return Icon(index < 5 ? Icons.star: null, color: Colors.yellow, size: 20);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateWidget extends StatefulWidget {
  DateWidget({Key key}) : super(key: key);
  @override
  _DateWidgetState createState() => _DateWidgetState();
}

DateTime selectedDate = DateTime.now();
TimeOfDay _time = new TimeOfDay.now();
final formatter = new DateFormat('yyyy.MM.dd (E)');

DateTime selectedDate2 = DateTime.now(); //두번째
TimeOfDay _time2 = new TimeOfDay.now();
final formatter2 = new DateFormat('yyyy.MM.dd (E)');

class _DateWidgetState extends State<DateWidget> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2014, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectDate2(BuildContext context) async { //두번째
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2014, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
      });
  }

  Future<Null> _selectedTime(BuildContext context) async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time
    );
    if (picked != null && picked != _time)
      setState(() {
        _time = picked;
      });
  }

  Future<Null> _selectedTime2(BuildContext context) async{ //두번째
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time2
    );
    if (picked != null && picked != _time2)
      setState(() {
        _time2 = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            margin: EdgeInsets.only(top: 15, right: 300),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 40),
                child: Icon(Icons.date_range),
              ),
              Container(
                child: Text("Check-in", style: TextStyle(fontWeight: FontWeight.bold)),
                margin: EdgeInsets.only(top: 15, right: 250),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(formatter.format(selectedDate)),
                margin: EdgeInsets.only(left: 50),
              ),
              Container(
                margin: EdgeInsets.only(left: 40),
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () => _selectDate(context),
                  child: Text('Select date'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text('$_time'.substring(10, 15)),
                margin: EdgeInsets.only(left: 50),
              ),
              Container(
                margin: EdgeInsets.only(left: 120),
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () => _selectedTime(context),
                  child: Text('Select time'),
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30, left: 40),
                child: Icon(Icons.date_range),
              ),
              Container(
                child: Text("Check-out", style: TextStyle(fontWeight: FontWeight.bold)),
                margin: EdgeInsets.only(top: 35, right: 250),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(formatter2.format(selectedDate2)),
                margin: EdgeInsets.only(left: 50),
              ),
              Container(
                margin: EdgeInsets.only(left: 40),
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () => _selectDate2(context),
                  child: Text('Select date'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                child: Text(('$_time2'.substring(10, 15))),
                margin: EdgeInsets.only(left: 50),
              ),
              Container(
                margin: EdgeInsets.only(left: 120),
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () => _selectedTime2(context),
                  child: Text('Select time'),
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }

  Text datePrint1( ){
    return Text(formatter.format(selectedDate), style: TextStyle(fontSize: 13));
  }
  Text datePrint2( ){
    return Text(formatter2.format(selectedDate2), style: TextStyle(fontSize: 13));
  }
  Text timePrint1( ){
    return Text('$_time'.substring(10, 15), style: TextStyle(fontSize: 13));
  }
  Text timePrint2( ){
    return Text('$_time2'.substring(10, 15), style: TextStyle(fontSize: 13));
  }
}

class feeWidget extends StatefulWidget {
  feeWidget({Key key}) : super(key: key);
  @override
  _feeWidgetState createState() => _feeWidgetState();
}

double _value = 0.0;
class _feeWidgetState extends State<feeWidget> {
  void _setvalue(double value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(32.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            Row(
              children : <Widget> [
                new Text('Fee:', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                Container(
                  margin: EdgeInsets.only(left: 240),
                  child: new Text('\$${(_value * 300).round()}'),
                ),
              ]
            ),
            new Slider(value: _value, onChanged: _setvalue),
          ],
        ),
      ),
    );
  }

  String feePrint( ){
    return '${(_value * 300).round()}';
  }
}
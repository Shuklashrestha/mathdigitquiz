import 'dart:math';

import 'package:flutter/material.dart';

class logical extends StatefulWidget {
  @override
  _logicalState createState() => _logicalState();
}

List Hint201 = [
  [3, 6, 9, 10],
  [4, 9, 3, 00],
  [5, 3, 6, 20],
  [9, 7, 5, 10],
  [6, 4, 7, 11]
],
    Hint202 = [
  [7, 9, 3, 11],
  [7, 2, 5, 10],
  [3, 1, 7, 20],
  [8, 4, 9, 00],
  [9, 8, 1, 10]
],
    Hint203 = [
  [6, 8, 2, 11],
  [6, 1, 4, 10],
  [2, 0, 6, 20],
  [7, 3, 8, 00],
  [7, 8, 0, 10]
],
    Hint204 = [
  [3, 6, 8, 11],
  [3, 8, 7, 00],
  [2, 7, 6, 10],
  [4, 7, 1, 20]
],
    Hint205 = [
  [3, 4, 2, 00],
  [2, 7, 3, 00],
  [1, 6, 5, 21],
  [8, 5, 3, 21],
  [8, 6, 5, 20]
];

List Hint100 = [Hint201, Hint202, Hint203, Hint204, Hint205];
final _random = new Random();
List Hint101 = Hint100[_random.nextInt(Hint100.length)];

String text1 = '';
String answer = '';
Color b1c = Colors.black;
String a01, a02, a03;
String a11, a12, a13;
bool readon = true;
var r00 = [false, false, false, false, false, false];
var b00 = [false, false, false, false, false, false];
var c00 = false;

class _logicalState extends State<logical> {
  final cont1 = TextEditingController();
  final cont2 = TextEditingController();
  final cont3 = TextEditingController();
  final hintcont1 = TextEditingController();

  List Hint;
  List Sol;
  int flag;
  int hintcount = 0;
  String text101;
  int hintc = 0;
  List Custom101 = [];

  static const menuItems = <String>[
    'HINT 3D',
    'HINT 4D',
    'CUSTOM 3D',
    'CUSTOM 4D'
  ];
  static const List<String> hintItems = const [
    'One digit is correct but wrongly placed.',
    'Nothing is correct.',
    'Two digits are correct but wrongly placed.',
    'One digit is correct and at well placed.',
    'Two digits are correct but only one well placed.'
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
  String _btn1val = 'HINT 3D';

  String _btnhintword = hintItems[0];

  calculate() {
    Hint = [];
    Sol = [];

    // Hint = [
    //   [1, 8, 3, 2, 11],
    //   [0, 6, 3, 4, 20],
    //   [5, 9, 2, 4, 20],
    //   [4, 9, 5, 1, 10],
    //   [4, 6, 7, 8, 10],
    //   [1, 3, 7, 4, 00],
    //   [0, 1, 4, 3, 10]
    // ];
    Hint = Hint101;

    int row = Hint.length;
    int column = Hint[0].length;
    int digit = column - 1;
    var c;

    for (int a = 0; a < pow(10, digit); a++) {
      c = [];
      for (int i = 1; i < column; i++) {
        c.add((a.remainder(pow(10, column - i)) -
                a.remainder(pow(10, column - i - 1))) /
            (pow(10, column - i - 1)));
      }
      flag = 1;
      for (int i = 0; i < row; i++) {
        flag = flag + checkcond(c, Hint[i], digit) - 1;
      }
      if (flag == 1) {
        Sol.add(c);
      }
    }
    for (int i = 0; i < Sol.length; i++) {
      for (int j = 0; j < Sol[0].length; j++) {
        Sol[i][j] = Sol[i][j].toInt();
      }
    }
    print(Sol);
    if (matchanswer() == false) {
      setState(() {
        b1c = Colors.red;
        text1 = 'Wrong, Try again';
      });
    } else {
      setState(() {
        b1c = Colors.green;
        text1 = 'Correct';
      });
    }
  }

  showanswer() {
    answer = Sol.toString();
  }

  int checkcond(var d, List e, int f) {
    int cnt = 0;
    var pos1 = [], pos2 = [];
    for (int i = 0; i < f; i++) {
      for (int j = 0; j < f; j++) {
        if (d[i] == e[j]) {
          cnt++;
          pos1.add(i);
          pos2.add(j);
        }
      }
    }
    if (e[f] == 00 && cnt == 0) {
      flag = 1;
    } else if (e[f] == 10 && cnt == 1 && pos1[0] != pos2[0]) {
      flag = 1;
    } else if (e[f] == 11 && cnt == 1 && pos1[0] == pos2[0]) {
      flag = 1;
    } else if (e[f] == 20 &&
        cnt == 2 &&
        pos1[0] != pos2[0] &&
        pos1[1] != pos2[1]) {
      flag = 1;
    } else if (e[f] == 22 &&
        cnt == 2 &&
        pos1[0] == pos2[0] &&
        pos1[1] == pos2[1]) {
      flag = 1;
    } else if (e[f] == 21 &&
        cnt == 2 &&
        ((pos1[0] != pos2[0] && pos1[1] == pos2[1]) ||
            (pos1[0] == pos2[0] && pos1[1] != pos2[1]))) {
      flag = 1;
    } else {
      flag = 0;
    }

    return flag;
  }

  bool matchanswer() {
    bool checkans = false;
    for (int i = 0; i < Sol.length; i++) {
      if (int.parse(a01) == Sol[i][0] &&
          int.parse(a02) == Sol[i][1] &&
          int.parse(a03) == Sol[i][2]) {
        checkans = true;
        break;
      } else {
        checkans = false;
      }
    }
    return checkans;
  }

  List getHint() {
    hintcount++;
    if (hintcount > 5) hintcount = 1;
    if (Hint101[hintcount - 1][3] == 10)
      text101 = 'One digit is correct but wrongly placed.';
    else if (Hint101[hintcount - 1][3] == 00)
      text101 = 'Nothing is correct.';
    else if (Hint101[hintcount - 1][3] == 20)
      text101 = 'Two digits are correct but wrongly placed.';
    else if (Hint101[hintcount - 1][3] == 11)
      text101 = 'One digit is correct and at well placed.';
    else if (Hint101[hintcount - 1][3] == 21)
      text101 = 'Two digits are correct but only one well placed.';
    else
      text101 = 'Wrong Input';
    return Hint101[hintcount - 1];
  }

  clearanswer() {
    setState(() {
      a01 = a02 = a03 = null;
      cont1.clear();
      cont2.clear();
      cont3.clear();
      b1c = Colors.black;
      text1 = '';
      answer='';

      // Hint101 = [
      //   [3, 4, 2, 00],
      //   [2, 7, 3, 00],
      //   [1, 6, 5, 21],
      //   [8, 5, 3, 21],
      //   [8, 6, 5, 20]
      // ];
      // Hint101 =
      Custom101 = [];

      print(Custom101);
    });
  }

  customreader(String a, String b, String c, String d) {
    if (d == 'One digit is correct but wrongly placed.')
      d = '10';
    else if (d == 'Nothing is correct.')
      d = '00';
    else if (d == 'Two digits are correct but wrongly placed.')
      d = '20';
    else if (d == 'One digit is correct and at well placed.')
      d = '11';
    else if (d == 'Two digits are correct but only one well placed.') d = '21';

    int a1 = int.parse(a);
    int b1 = int.parse(b);
    int c1 = int.parse(c);
    int d1 = int.parse(d);
    Custom101.add([a1, b1, c1, d1]);
    hintc++;
    Hint101[hintc - 1][0] = a1;
    Hint101[hintc - 1][1] = b1;
    Hint101[hintc - 1][2] = c1;
    Hint101[hintc - 1][3] = d1;
    print(Hint101);
    print(hintcount);
    print(hintc);
  }

  multipleButtonCommand() {
    if (_btn1val == 'CUSTOM 3D') {
      //  || _btn1val == 'CUSTOM 4D'
      readon = false;
      c00 = true;
      //  hintcount=0;
      Custom101 = [];
      Hint101 = [
        [0, 0, 0, 0],
        [1, 1, 1, 0],
        [2, 2, 2, 0],
        [3, 3, 3, 0],
        [4, 4, 4, 0]
      ];
    } else if (_btn1val == 'HINT 3D') {
      //  || _btn1val == 'HINT 4D'
      readon = true;
      r00 = [false, false, false, false, false, false];
      b00 = [false, false, false, false, false, false];
      c00 = false;
      Hint101 = [
        [3, 6, 9, 10],
        [4, 9, 3, 00],
        [5, 3, 6, 20],
        [9, 7, 5, 10],
        [6, 4, 7, 11]
      ];
    }

    print(_btn1val);
  }

  Widget getAnswer() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          SizedBox(width: 60.0, height: 50),
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                focusNode: FocusNode(canRequestFocus: false),
                showCursor: false,
                maxLength: 1,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                controller: cont1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(),
                style: TextStyle(fontSize: 36, color: Colors.black),
                onChanged: (val1) {
                  a01 = val1;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: b1c, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                )),
              ),
            ),
          ),
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                focusNode: FocusNode(canRequestFocus: false),
                showCursor: false,
                maxLength: 1,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                controller: cont2,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(),
                style: TextStyle(fontSize: 36, color: Colors.black),
                onChanged: (val2) => a02 = val2,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: b1c, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                )),
              ),
            ),
          ),
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                showCursor: false,
                focusNode: FocusNode(canRequestFocus: false),
                maxLength: 1,
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                controller: cont3,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(),
                style: TextStyle(fontSize: 36, color: Colors.black),
                onChanged: (val3) => a03 = val3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: b1c, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                )),
              ),
            ),
          ),
          SizedBox(
            width: 60.0,
          ),
        ],
      ),
    );
  }

  Widget hintsWidget(List setHint) {
    return Column(
      children: <Widget>[
        Container(
          width: 270,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 60.0, height: 40),
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                        hintText: setHint[0].toString(),
                        hintStyle: TextStyle(color: Colors.black, fontSize: 23),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        )),
                  ),
                ),
              ),
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                        hintText: setHint[1].toString(),
                        hintStyle: TextStyle(color: Colors.black, fontSize: 23),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        )),
                  ),
                ),
              ),
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                        hintText: setHint[2].toString(),
                        hintStyle: TextStyle(color: Colors.black, fontSize: 23),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: 60.0,
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 0, right: 2),
            child: Text(text101, style: TextStyle(fontSize: 20))),
      ],
    );
  }

  Widget readCustom3d() {
    return Column(
      children: <Widget>[
        Container(
          width: 270,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 60.0, height: 40),
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    showCursor: false,
                    maxLength: 1,
                    buildCounter: (BuildContext context,
                            {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                        null,
                    // controller: hintcont1,
                    style: TextStyle(fontSize: 23, color: Colors.black),
                    onChanged: (val11) {
                      a11 = val11;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                ),
              ),
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    showCursor: false,
                    maxLength: 1,
                    buildCounter: (BuildContext context,
                            {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                        null,
                    //   controller: hintcont1,
                    style: TextStyle(fontSize: 23, color: Colors.black),
                    onChanged: (val12) {
                      a12 = val12;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                ),
              ),
              new Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    showCursor: false,
                    maxLength: 1,
                    buildCounter: (BuildContext context,
                            {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                        null,
                    //   controller: hintcont1,
                    style: TextStyle(fontSize: 23, color: Colors.black),
                    onChanged: (val13) {
                      a13 = val13;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                ),
              ),
              SizedBox(
                width: 60.0,
              ),
            ],
          ),
        ),
        DropdownButton(
            value: _btnhintword,
            items: hintItems.map((string) {
              return new DropdownMenuItem(
                child: new Text(
                  string,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                value: string,
              );
            }).toList(),
            onChanged: (string) => setState(() {
                  _btnhintword = string;
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logical question'),
      ),
      body: SingleChildScrollView(
              child: Container(
                  child: Column(children: <Widget>[
                getAnswer(),
                Text(
                  text1,
                  style: TextStyle(fontSize: 20, color: b1c),
                ), //will be removed later
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        elevation: 10,
                        child: Text('CHECK'),
                        onPressed: () => calculate()),
                    RaisedButton(
                      elevation: 10,
                      child: Text('CLEAR'),
                      onPressed: clearanswer,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 300),
                  child: FlatButton(
                      onLongPress: () => showanswer(),
                      child: Text(
                        answer??'',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                //  SizedBox(height: 20),
      
                ListTile(
                    title: Text(
                      " Choose multiple option :  ",
                      style: TextStyle(fontSize: 18, backgroundColor: Colors.yellow),
                    ),
                    trailing: DropdownButton<String>(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      value: _btn1val,
                      onChanged: (String newValue) {
                        setState(() {
                          _btn1val = newValue;
                          multipleButtonCommand();
                        });
                      },
                      items: this._dropDownMenuItems,
                    )),
      
                Visibility(visible: readon, child: hintsWidget(getHint())),
                Visibility(visible: c00, child: readCustom3d()),
                Visibility(
                  visible: !readon,
                  child: Visibility(
                    visible: !b00[0],
                    child: RaisedButton(
                      child: Text('ADD'),
                      onPressed: () => setState(() {
                        r00[0] = true;
                        b00[0] = true;
                        b00[1] = true;
                        c00 = false;
                        hintcount = 0;
                        customreader(a11, a12, a13, _btnhintword);
                      }),
                    ),
                  ),
                ),
                Visibility(visible: r00[0], child: hintsWidget(getHint())),
      
                SizedBox(height: 20),
      
                Visibility(visible: readon, child: hintsWidget(getHint())),
                Visibility(visible: b00[1], child: readCustom3d()),
                Visibility(
                  visible: !readon,
                  child: Visibility(
                    visible: b00[1],
                    child: RaisedButton(
                      child: Text('ADD'),
                      onPressed: () => setState(() {
                        r00[1] = true;
                        b00[1] = false;
                        b00[2] = true;
                        hintcount = 1;
                        customreader(a11, a12, a13, _btnhintword);
                      }),
                    ),
                  ),
                ),
                Visibility(visible: r00[1], child: hintsWidget(getHint())),
      
                SizedBox(height: 20),
      
                Visibility(visible: readon, child: hintsWidget(getHint())),
                Visibility(visible: b00[2], child: readCustom3d()),
                Visibility(
                  visible: !readon,
                  child: Visibility(
                    visible: b00[2],
                    child: RaisedButton(
                      child: Text('ADD'),
                      onPressed: () => setState(() {
                        r00[2] = true;
                        b00[2] = false;
                        b00[3] = true;
                        hintcount = 2;
                        customreader(a11, a12, a13, _btnhintword);
                      }),
                    ),
                  ),
                ),
                Visibility(visible: r00[2], child: hintsWidget(getHint())),
      
                SizedBox(height: 20),
                Visibility(visible: readon, child: hintsWidget(getHint())),
                Visibility(visible: b00[3], child: readCustom3d()),
                Visibility(
                  visible: !readon,
                  child: Visibility(
                    visible: b00[3],
                    child: RaisedButton(
                      child: Text('ADD'),
                      onPressed: () => setState(() {
                        r00[3] = true;
                        b00[3] = false;
                        b00[4] = true;
                        hintcount = 3;
                        customreader(a11, a12, a13, _btnhintword);
                      }),
                    ),
                  ),
                ),
                Visibility(visible: r00[3], child: hintsWidget(getHint())),
      
                SizedBox(height: 20),
                Visibility(visible: readon, child: hintsWidget(getHint())),
                Visibility(visible: b00[4], child: readCustom3d()),
                Visibility(
                  visible: !readon,
                  child: Visibility(
                    visible: b00[4],
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text('DONE'),
                      onPressed: () => setState(() {
                        r00[4] = true;
                        b00[4] = false;
                        b00[5] = true;
                        hintcount = 4;
                        customreader(a11, a12, a13, _btnhintword);
                        Hint101 = [];
                        Hint101 = Custom101;
                        print(Custom101);
                      }),
                    ),
                  ),
                ),
                Visibility(visible: r00[4], child: hintsWidget(getHint())),
      
                SizedBox(height: 30),
              ])),
            ),
          );
        }
      

}

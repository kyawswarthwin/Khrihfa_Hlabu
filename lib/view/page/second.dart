import 'package:app/controller/controller.dart';
import 'package:app/view/tab/secondtab1.dart';
import 'package:app/view/tab/secondtab2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../util/draweselection.dart';

class Second extends StatefulWidget {
  final DrawerSelection drawerSelection;
  const Second({Key key, this.drawerSelection}) : super(key: key);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new TabBarView(
        controller: Control().controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[SecondTab1(), SecondTab2()],
      ),
    );
  }
}

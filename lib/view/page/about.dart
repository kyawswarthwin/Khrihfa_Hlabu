import 'package:app/util/customicon.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
 void dispose() { 
  //  super.dispose();
  //  about.dispose();
 }
  @override
  Widget build(BuildContext context) {
//     FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8032453967263891~1572959323").then((response){
// about..load()..show(
//     anchorType: AnchorType.bottom,
//     anchorOffset: 0.0,
//     horizontalCenterOffset: 0.0,);
//     });
    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 28.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Text(
                "Khrihfa Hlabu App cu Mobile Phone in hman khawhnak ding caah tuah a si."),
            SizedBox(
              height: 15,
            ),
            Text(
                "Copy Right hi CACC ta bak a si i CACC nih nan hmang kho lo an kan ti tu ahcun aho cio poh nih hmanlo in hrawh ding a si te lai tiah nawl kan duh hna"),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 400,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "Pehtlaihnak",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Container(
              height: 168,
              width: 400,
              child: ListView(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => launch("tel:09965777399"),
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text("09965777399"),
                    ),
                  ),
                  FlatButton(
                    onPressed: () =>
                        launch("mailto:rampengthang2014@gmail.com"),
                    child: ListTile(
                      leading: Icon(Icons.mail),
                      title: Text("rampengthang2014@gmail.com"),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => launch("http://www.chinitfree.com"),
                    child: ListTile(
                      leading: Icon(MyFlutterApp.chrome),
                      title: Text("http://www.chinitfree.com"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//   // birthday: DateTime.now(),
//   childDirected: false,
//   // designedForFamilies: false,
//   // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// InterstitialAd about = InterstitialAd(
//   adUnitId: "ca-app-pub-8032453967263891/5145017606",
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("InterstitialAd event is $event");
//   },
// );
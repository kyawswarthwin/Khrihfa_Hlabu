import 'dart:async';
import 'dart:convert';
import 'package:app/model/post.dart';
import 'package:app/view/listdetail/postdetail.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:connectivity/connectivity.dart';

class Third extends StatefulWidget {
  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
  ScrollController controller = ScrollController();
  List post = List<Data>();
  String paging;
  bool internet = false;
  bool loading = true;
  String url =
      "https://graph.facebook.com/v3.1/223586198501298/posts?fields=id,type,link,story,message,picture,full_picture,caption,name,description,attachments,object_id,source,place,from,created_time,updated_time&access_token=EAADsrEGIGggBAAmQZCK8u8kWM8Nb2ACtnaaC61x2ZBu9mZCQyaa1k8vKSqIYVANewEwA3XxZC9kVZBN6o1MWPBMz4ZAmcb2kDKkMbnxffZAwElxJBivxWKdZCQ2817n16KkykcqjGQ9jHQ87SVCl0BEyFOxsEgsU9YZAcr1vuxWXvFhBXRGFMVPZBWBbKG4yMt5JQZD";
  @override
  void initState() {
    super.initState();
    getdata();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        print("H");
        setState(() {
          url = paging;
        });
        getdata();
      }
    });
      Future.delayed(Duration(seconds: 2), () {
      setState(() {
      loading =false;
      });
    });
  }

  void getdata() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        internet = false;
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var datas = json.decode(response.body);
        setState(() {
          datas['data']
              .map((data) => post.add(new Data.fromJson(data)))
              .toList();
          paging = datas['paging']['next'];
        });
      } else
        throw Exception('We were not able to successfully download json data');
    } else if (result == ConnectivityResult.none) {
      setState(() {
        internet = true;
      });
    }
  }

  Future<void> refreshdata() async {
    post.clear();
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        internet = false;
      });
      var response = await http.get(
          "https://graph.facebook.com/v3.1/223586198501298/posts?fields=id,type,link,story,message,picture,full_picture,caption,name,description,attachments,object_id,source,place,from,created_time,updated_time&access_token=EAADsrEGIGggBAAmQZCK8u8kWM8Nb2ACtnaaC61x2ZBu9mZCQyaa1k8vKSqIYVANewEwA3XxZC9kVZBN6o1MWPBMz4ZAmcb2kDKkMbnxffZAwElxJBivxWKdZCQ2817n16KkykcqjGQ9jHQ87SVCl0BEyFOxsEgsU9YZAcr1vuxWXvFhBXRGFMVPZBWBbKG4yMt5JQZD");
      if (response.statusCode == 200) {
        var datas = json.decode(response.body);
        setState(() {
          datas['data']
              .map((data) => post.add(new Data.fromJson(data)))
              .toList();
          paging = datas['paging']['next'];
        });
      } else
        throw Exception('We were not able to successfully download json data');
    } else if (result == ConnectivityResult.none) {
      print("no in");
      setState(() {
        internet = true;
      });
    }
  }

  void getMoreData() {
    setState(() {
      url = paging;
    });
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
    post.clear();
    controller.dispose();
    // third.dispose();
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
// FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8032453967263891~1572959323").then((response){
// third..load()..show(
//     anchorType: AnchorType.bottom,
//     anchorOffset: 0.0,
//     horizontalCenterOffset: 0.0,);
    // });
    return Scaffold(
      body:loading 
      ? 
       Container(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                           boxShadow:[BoxShadow(color: Colors.black,offset: new Offset(5.0, 5.0),
                    blurRadius: 40.0,)]
                        ),
                        width: 160,
                        height: 80,
                        child: Center(
                            child: ListTile(
                          leading: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          title: Text(
                            "Loading...",
                            style: TextStyle(color:Colors.black54),
                          ),
                        )),
                      ),
                    ),
                  )
                  :
       RefreshIndicator(
         color: Colors.black,
        onRefresh: refreshdata,
        child: internet
            ? ListView(
                padding: const EdgeInsets.only(top: 200),
                children: <Widget>[
                  Center(
                      child: Icon(
                    Icons.wifi_tethering,
                    size: 70,
                  )),
                  Center(
                      child: Text(
                    "No Connection Available",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ))
                ],
              )
            : 
            new ListView.builder(
                controller: controller,
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PostDetail(data: post[index])));
                      },
                      child: Container(
                          height: 95,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      post[index].picture ?? "",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Wrap(
                                      children: <Widget>[
                                        Text(post[index].name ?? "",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.insert_invitation,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          DateFormat.yMMMMd("en_US")
                                                  .add_jm()
                                                  .format(DateTime.parse(
                                                      post[index].time)) ??
                                              "",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )
                                      ],
                                    ),
                                    Wrap(
                                      children: <Widget>[
                                        Text(post[index].message ?? " ",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: "Pyidaungsu",
                                                fontSize: 13.5,
                                                color: Colors.black54)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    SizedBox(
                                      height: 1.0,
                                      child: Container(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black54
                                            : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
      ),
    );
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

// InterstitialAd third = InterstitialAd(
//   adUnitId: "ca-app-pub-8032453967263891/5145017606",
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("InterstitialAd event is $event");
//   },
// );

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:third_map_plugin/third_map_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ThirdMapPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async{
                List results = await ThirdMapPlugin.hasInstalledMapApp();
                print(results);
              },
              child: Text("获取当前支持的平台"),
            ),
            Divider(),
            RaisedButton(
              onPressed: () async{

                bool reslut = await ThirdMapPlugin.openBaiduMap(dlongitude: "116.47560823", dlatitude: "39.98848272");
                print(reslut);
              },
              child: Text("打开百度地图"),
            ),
            Divider(),

            RaisedButton(
              onPressed: () async{
                bool reslut = await ThirdMapPlugin.openAmap(dlongitude: "116.47560823", dlatitude: "39.98848272", dName: "终点地址");
                print(reslut);
              },
              child: Text("打开高德地图"),
            ),
            Divider(),

            RaisedButton(
              onPressed: () async{
                bool reslut = await ThirdMapPlugin.openAppleMap(dlongitude: "116.47560823", dlatitude: "39.98848272", dName: "终点地址");
                print(reslut);
              },
              child: Text("打开苹果地图"),
            ),

            Divider(),
            Builder(builder: (context){

              return RaisedButton(
                onPressed: (){

                  showModalBottomSheet(
                    isScrollControlled: false,
                    useRootNavigator: true,
                    context: context,
                    builder: (context) {

                      return ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 40,
                                child: RaisedButton(onPressed: (){

                                }),
                              ),
                              Divider(),
                              Container(
                                width: double.infinity,
                                height: 40,
                                child: RaisedButton(onPressed: (){

                                }),
                              ),
                              Divider(),
                              Container(
                                width: double.infinity,
                                height: 40,
                                child: RaisedButton(onPressed: (){

                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      //side: BorderSide(color: Colors.green, width: 5),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                    ),
                    backgroundColor: Colors.green.withOpacity(0)
                  );


                },
                child: Text("导航"),
              );
            })
          ],
        ),
      ),
    );
  }
}

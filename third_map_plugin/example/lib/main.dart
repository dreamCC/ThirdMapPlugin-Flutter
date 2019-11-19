import 'package:flutter/material.dart';
import 'dart:async';
import 'package:third_map_plugin/third_map_plugin.dart';
import 'third_map_navi_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

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

                bool reslut = await ThirdMapPlugin.openBaiduMap(dlongitude: "116.47560823", dlatitude: "39.98848272", dName: "终点地址");
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
                onPressed: () async{

                  ThirdMapNaviUtil(
                      context,
                      dlongitude: '116.47560823',
                      dlatitude: '39.98848272',
                      dName: '终点地址---'
                  ).thirdMapNaviDialog();
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

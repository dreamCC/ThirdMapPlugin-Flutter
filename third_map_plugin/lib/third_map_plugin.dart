import 'dart:async';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class ThirdMapPlugin {
  static const MethodChannel _channel =
      const MethodChannel('third_map_plugin');

  // 获取当前安装的第三方地图app
  static Future<List<String>> hasInstalledMapApp() async{
    final List<String> values = await _channel.invokeListMethod('hasInstalledMapApp');
    return values;
  }

  // 打开百度地图
  static Future<bool> openBaiduMap({@required String dlongitude, @required String dlatitude}) async{

    Map<String, String> arguments = {
      "dlongitude":dlongitude ?? "",
      "dlatitude":dlatitude ?? "",
    };
    final bool results = await _channel.invokeMethod('openBaiduMap', arguments);
    return results;
  }

  // 打开高德地图
  static Future<bool> openAmap({@required String dlongitude, @required String dlatitude, @required String dName}) async{
    Map<String, String> arguments = {
      "dlongitude":dlongitude ?? "",
      "dlatitude":dlatitude ?? "",
      "dName":dName ?? ""
    };
    final bool results = await _channel.invokeMethod('openAmap', arguments);
    return results;
  }

  // 打开苹果地图
  static Future<bool> openAppleMap({@required String dlongitude, @required String dlatitude, @required String dName}) async{
    Map<String, String> arguments = {
      "dlongitude":dlongitude ?? "",
      "dlatitude":dlatitude ?? "",
      "dName":dName ?? ""
    };
    final bool results = await _channel.invokeMethod('openAppleMap', arguments);
    return results;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


}

import Flutter
import UIKit
import MapKit

public class SwiftThirdMapPlugin: NSObject, FlutterPlugin {

  var result: FlutterResult!

   public static func register(with registrar: FlutterPluginRegistrar) {
     let channel = FlutterMethodChannel(name: "com.zcj.third_map_plugin.cn", binaryMessenger: registrar.messenger())
     let instance = SwiftThirdMapPlugin()
     registrar.addMethodCallDelegate(instance, channel: channel)
   }

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     self.result = result

     if(call.method == "getPlatformVersion"){
         result("iOS " + UIDevice.current.systemVersion)
         return
     }
     if(call.method == "hasInstalledMapApp"){
         let installedMaps = hasInstalledMapApp()
         result(installedMaps)
         return
     }
     if(call.method == "openBaiduMap"){
         let argument = call.arguments!
         guard let argumentDic = argument as? Dictionary<String, String> else {
             return
         }
         openBaiduMap(argumentDic: argumentDic)
         return
     }
     if(call.method == "openAmap") {
         let argument = call.arguments!
         guard let argumentDic = argument as? Dictionary<String, String> else {
             return
         }
         openAmap(argumentDic: argumentDic)
         return
     }
     if(call.method == "openAppleMap") {
         let argument = call.arguments!
         guard let argumentDic = argument as? Dictionary<String, String> else {
             return
         }
         openAppleMap(argumentDic: argumentDic)
         return
     }


     result(FlutterMethodNotImplemented)
   }
    
}

extension SwiftThirdMapPlugin {
    
    private func hasInstalledMapApp() ->Array<String>{
           var results = Array<String>();

           let application = UIApplication.shared
           if application.canOpenURL(URL(string: "baidumap://")!) {
               results.append("百度地图")
           }
           if application.canOpenURL(URL(string: "iosamap://")!) {
               results.append("高德地图")
           }
           if application.canOpenURL(URL(string: "http://maps.apple.com/")!) {
               results.append("苹果地图")
           }
           return results
       }


       //baidumap://map/direction?destination=$dlatitude,$dlongitude&src=andr.baidu.openAPIdemo
       private func openBaiduMap(argumentDic: Dictionary<String, String>) {

           let dlongitude = argumentDic["dlongitude"]!
           let dlatitude = argumentDic["dlatitude"]!
           let dName = argumentDic["dName"]!

           let url = "baidumap://map/direction?destination=latlng:\(dlatitude),\(dlongitude)|name:\(dName)&src=andr.baidu.openAPIdemo"
           openThirdMap(url: url)
       }

       //iosamap://path?dlat=39.98848272&dlon=116.47560823&dname=B
       private func openAmap(argumentDic: Dictionary<String,String>) {

           let dlongitude = argumentDic["dlongitude"]!
           let dlatitude = argumentDic["dlatitude"]!
           let dName = argumentDic["dName"]!

           let url = "iosamap://path?dlat=\(dlatitude)&dlon=\(dlongitude)&dname=\(dName)"
           openThirdMap(url: url)
       }

       // ios 10.0 之前："http://maps.apple.com/"
       // 10.0之后，通过MapItem打开
       private func openAppleMap(argumentDic: Dictionary<String,String>) {

           let dlongitude = Double(argumentDic["dlongitude"]!) ?? 0
           let dlatitude = Double(argumentDic["dlatitude"]!) ?? 0
           let dName = argumentDic["dName"]!
           if #available(iOS 10.0, *) {
               let dcoordinate2d = CLLocationCoordinate2DMake(dlatitude, dlongitude)
               let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: dcoordinate2d))
               mapItem.name = dName
               mapItem.openInMaps(launchOptions: nil)
           } else {
               let url = "http://maps.apple.com/"
               openThirdMap(url: url)
           }
       }

       private func openThirdMap(url: String) {

           guard let urlPath = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  else {
               result(false)
               return
           }

           let application = UIApplication.shared
           guard let mapUrl = URL(string: urlPath) else {
               result(false)
               return
           }

           guard application.canOpenURL(mapUrl) else{
               result(false)
               return
           }

           application.openURL(mapUrl)
           result(true)
       }
}

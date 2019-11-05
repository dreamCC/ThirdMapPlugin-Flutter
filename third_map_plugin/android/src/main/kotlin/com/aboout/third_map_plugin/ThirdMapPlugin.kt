package com.aboout.third_map_plugin

import android.annotation.TargetApi
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File



class ThirdMapPlugin(private var activity: Activity): MethodCallHandler {


  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {

      val channel = MethodChannel(registrar.messenger(), "third_map_plugin")
      channel.setMethodCallHandler(ThirdMapPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
      return
    }
    if (call.method == "hasInstalledMapApp") {
      val resultLists = hasInstalledMapApp()
      result.success(resultLists)
      return
    }
    if (call.method == "openBaiduMap") {
      val argument = call.arguments as Map<String, String>
      openBaiduMap(argumentDic = argument)
      return
    }
    if (call.method == "openAmap") {
      val argument = call.arguments as Map<String, String>
      openAmap(argumentDic = argument)
      return
    }
    result.notImplemented()
  }

  fun hasInstalledMapApp(): ArrayList<String>{
    val results = ArrayList<String>()

    // 百度地图。com.baidu.BaiduMap
    val baiduFile = File("/data/data/com.baidu.BaiduMap")
    if (baiduFile.exists()){
      results.add("百度地图")
    }

    // 高德地图。com.autonavi.minimap
    val amapFile = File("/data/data/com.autonavi.minimap")
    if (amapFile.exists()) {
      results.add("高德地图")
    }
    return results
  }


  fun openBaiduMap(argumentDic: Map<String,String>) {
    val dlongitude = argumentDic["dlongitude"]
    val dlatitude = argumentDic["dlatitude"]
    val url = "baidumap://map/direction?destination=$dlatitude,$dlongitude&src=andr.baidu.openAPIdemo"
    val intent = Intent()
    intent.data = Uri.parse(url)
    activity.startActivity(intent)
  }

  fun openAmap(argumentDic: Map<String,String>) {
    val dlongitude = argumentDic["dlongitude"]
    val dlatitude = argumentDic["dlatitude"]
    val dName = argumentDic["dName"]
    val url = "androidamap://route/plan?dlat=$dlatitude&dlon=$dlongitude&dname=$dName"
    val intent = Intent()
    intent.data = Uri.parse(url)
    activity.startActivity(intent)
  }

}

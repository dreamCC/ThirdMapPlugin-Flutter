
import 'package:flutter/material.dart';
import 'package:third_map_plugin/third_map_plugin.dart';

class ThirdMapNaviUtil {
  double _itemH = 44;

  String dlongitude;
  String dlatitude;
  String dName;
  BuildContext context;
  ThirdMapNaviUtil(this.context,
      {@required this.dlongitude,
        @required this.dlatitude,
        @required this.dName});

  void thirdMapNaviDialog() async{

    List<String> thirdMaps = await ThirdMapPlugin.hasInstalledMapApp();


    print('----------$thirdMaps');

    showModalBottomSheet(
        context: context,
        builder: (context){

          return SafeArea(
            child: Container(
              height: _itemH*(thirdMaps.length + 2) + 30,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: _itemH*(thirdMaps.length + 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: ListView.separated(
                        itemBuilder: (context, index){
                          if(index == 0) {
                            return Container(
                              height: _itemH,
                              alignment: Alignment(0, 0),
                              child: Text(
                                "选择地图",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16
                                ),
                              ),
                            );
                          }else {
                            return _mapNaviDialogItem(thirdMaps[index - 1]);
                          }
                        },
                        separatorBuilder: (context ,index) => Divider(thickness: 1, height: 1,),
                        itemCount: thirdMaps.length + 1,
                    ),
                  ),
                  SizedBox(height: 10,),
                  _mapNaviDialogCancelItem(context)
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.white.withOpacity(0)
    );
  }



  Widget _mapNaviDialogItem(String text) {
    return InkWell(
      onTap: (){
        switch (text) {
          case "百度地图":
            ThirdMapPlugin.openBaiduMap(dlongitude: dlongitude, dlatitude: dlatitude, dName: dName);
            break;
          case "高德地图":
            ThirdMapPlugin.openAmap(dlongitude: dlongitude, dlatitude: dlatitude, dName: dName);
            break;
          case "苹果地图":
            ThirdMapPlugin.openAppleMap(dlongitude: dlongitude, dlatitude: dlatitude, dName: dName);
            break;
            default: break;
        }
      },
      child: Container(
        height: _itemH,
        alignment: Alignment(0, 0),
        child: Text(text,
          style: TextStyle(
              color: Color.fromARGB(255, 0,101,179),
              fontSize: 16),
        ),
      ),
    );
  }
  
  Widget _mapNaviDialogCancelItem (BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Container(
        height: _itemH,
        alignment: Alignment(0, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        child:  Text("取消",
          style: TextStyle(
              color: Color.fromARGB(255, 0,101,179),
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

}
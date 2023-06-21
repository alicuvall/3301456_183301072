import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/class/City.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Goal.dart';
import 'package:travel_app/component/TitleContainer.dart';
import 'package:travel_app/data/CityData.dart';
import 'package:travel_app/view/CityDetailView.dart';

class GoalDetailView extends StatefulWidget {
  final Goal hedef;

  GoalDetailView({required this.hedef});

  @override
  _GoalDetailViewState createState() => _GoalDetailViewState();
}

class _GoalDetailViewState extends State<GoalDetailView> {
  final Data sehirData = new Data();
  late City currentSehir;
  late SQLDatabase _dbHelper;

  City findCityById(int cityId) {
    int index = sehirData.yurtici.indexWhere((element) => element.id == cityId);
    if(index == -1){
      index = sehirData.yurtdisi.indexWhere((element) => element.id == cityId);
      return sehirData.yurtdisi[index];
    }else{
      return sehirData.yurtici[index];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = SQLDatabase();
    currentSehir = findCityById(widget.hedef.targetDestinationCityId);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dateSplit = widget.hedef.targetDate.split(" ");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Amaç: ${widget.hedef.id}'),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: (){
                _dbHelper.removeItem(_dbHelper.goalTableName, 'id', widget.hedef.id);
                Fluttertoast.showToast(
                    msg: "${widget.hedef.targetHead} kaldırıldı.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.black,
                    fontSize: 16.0
                );
                Navigator.pop(context);
              },
              onTapCancel: (){
                Fluttertoast.showToast(
                    msg: "Amaç silinmedi.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.black,
                    fontSize: 16.0
                );
              },
              child: Icon(
                Icons.delete_forever,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Wrap(
                          children:[
                            Center(
                              child: Text(
                                "${widget.hedef.targetHead}\n\nAmaç: ${currentSehir.adi}, ${currentSehir.ulke}",
                                style: TextStyle(fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Card(
                color: Theme.of(context).primaryColor,
                child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails details){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityDetail(data: currentSehir)));
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityDetail(data: currentSehir)));
                    },
                    leading: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Şehri tekrar incele',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TitleContainer(
                containerHeight: 200,
                titleSize: 20,
                title: 'Açıklama',
                widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(widget.hedef.targetDescription, style: TextStyle(color: Colors.black),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

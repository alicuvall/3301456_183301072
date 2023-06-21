import 'package:flutter/material.dart';
import 'package:dartx/dartx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/class/City.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Goal.dart';
import 'package:travel_app/component/TitleContainer.dart';
import 'package:travel_app/data/CityData.dart';


class AddGoalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Bir Amaç Ekle'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(child: SingleChildScrollView(child: Content())),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late SQLDatabase _dbHelper;
  Data sehirData = Data();
  String dropdownValue = "Ankara";
  int dropdownKonumValue = 1;
  late List<City> initialSehir;

  final _descriptionController = TextEditingController();
  final _targetTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = SQLDatabase();

    initialSehir = sehirData.yurtici.sortedBy((element) => element.adi);
  }

  int findCityId(String sehirAdi) {
    int index =
    sehirData.yurtici.indexWhere((element) => element.adi == sehirAdi);
    if (index == -1) {
      index =
          sehirData.yurtdisi.indexWhere((element) => element.adi == sehirAdi);
      return sehirData.yurtdisi[index].id;
    } else {
      return sehirData.yurtici[index].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleContainer(
            containerHeight: 362,
            title: 'Yeni bir amaç ekle',
            titleSize: 20,
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Başlık:', style: TextStyle(color: Colors.black)),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            maxLength: 30,
                            decoration: InputDecoration(
                              counterStyle: TextStyle(color: Colors.black),
                              hintText: 'Buraya gideceğiz!',
                              hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            maxLines: null,
                            style: TextStyle(color: Colors.black),
                            controller: _targetTitleController,
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Konum', style: TextStyle(color: Colors.black),),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: dropdownKonumValue,
                            style: TextStyle(color: Colors.black),
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            items: [
                              DropdownMenuItem(
                                child: Text('Yurtiçi', style: TextStyle(color: Colors.black)),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text('Yurtdışı', style: TextStyle(color: Colors.black)),
                                value: 2,
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                dropdownKonumValue = value!;

                                if (dropdownKonumValue == 1) {
                                  initialSehir = sehirData.yurtici
                                      .sortedBy((element) => element.adi);
                                } else {
                                  initialSehir = sehirData.yurtdisi
                                      .sortedBy((element) => element.adi);
                                }

                                dropdownValue = initialSehir[0].adi;
                              });
                            },
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Gideceğim:', style: TextStyle(color: Colors.black)),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: dropdownValue,
                            style: TextStyle(color: Colors.black),
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            items: initialSehir
                                .map<DropdownMenuItem<String>>((City value) {
                              return DropdownMenuItem<String>(
                                value: value.adi,
                                child: Text(value.adi, style: TextStyle(color: Colors.black)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Açıklama:', style: TextStyle(color: Colors.black)),
                        flex: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '...',
                              hintStyle: TextStyle(color: Colors.grey),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            maxLines: null,
                            style: TextStyle(color: Colors.black),
                            controller: _descriptionController,
                          ),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: Text('Kaydet'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (_targetTitleController.text.trim() == "" &&
                          _descriptionController.text.trim() == "") {
                        Fluttertoast.showToast(
                            msg: "açıklama ve hedef başlığını doldur.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      } else if (_targetTitleController.text.trim() == "") {
                        Fluttertoast.showToast(
                            msg: "hedef başlığını doldur.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      } else if (_descriptionController.text.trim() == "") {
                        Fluttertoast.showToast(
                            msg: "açıklamayı doldur.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      } else {
                        _dbHelper.insertItem(
                            Goal(
                              targetDestination: dropdownKonumValue == 1
                                  ? 'Yurtiçi'
                                  : 'Yurtdışı',
                              targetDestinationCityId:
                              findCityId(dropdownValue),
                              targetDescription: _descriptionController.text,
                              targetHead: _targetTitleController.text,
                              targetDate: DateFormat('dd.MM.yyyy HH:mm')
                                  .format(DateTime.now()),
                            ),
                            _dbHelper.goalTableName);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

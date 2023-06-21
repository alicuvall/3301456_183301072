import 'package:flutter/material.dart';
import 'package:travel_app/class/City.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Favorite.dart';
import 'package:travel_app/data/CityData.dart';
import 'package:travel_app/data/Favorites.dart';
import 'package:travel_app/view/CityDetailView.dart';

class FavoritesView extends StatefulWidget {
  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late SQLDatabase database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = SQLDatabase();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Favorilerim'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: database.getFavorites(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'Burası boş. Favori oluştur!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Favorite favorite = snapshot.data![index];

                  return FavoriteWidget(
                    key: UniqueKey(),
                    parentFunc: refresh,
                    cityId: favorite.cityId,
                  );
                },
              );
            },
          ),
        ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  final int cityId;
  final Function() parentFunc;

  FavoriteWidget({
    Key? key,
    required this.cityId,
    required this.parentFunc
  }) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final Data CityData = new Data();
  late City currentCity;

  City findCityById(int cityId) {
    int index = CityData.yurtici.indexWhere((element) => element.id == cityId);
    if (index == -1) {
      index = CityData.yurtdisi.indexWhere((element) => element.id == cityId);
      return CityData.yurtdisi[index];
    } else {
      return CityData.yurtici[index];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentCity = findCityById(widget.cityId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityDetail(data: currentCity))).then((value){
            widget.parentFunc();
          });
        },
        tileColor: Colors.white,
        leading: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        title: Text(currentCity.adi + ", " + currentCity.ulke),
      ),
    );
  }
}

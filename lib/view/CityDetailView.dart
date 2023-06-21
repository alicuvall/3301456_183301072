import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/class/City.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Favorite.dart';
import 'package:travel_app/class/Weather.dart';
import 'package:travel_app/class/WeatherApi.dart';
import 'package:travel_app/component/PlaceCard.dart';
import 'package:travel_app/component/TitleContainer.dart';
import 'package:travel_app/data/Favorites.dart';
import 'package:travel_app/view/FoodsView.dart';
import 'package:travel_app/view/MustTravelView.dart';
import 'package:travel_app/view/PlaceDetail.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class CityDetail extends StatefulWidget {
  final City data;
  CityDetail({required this.data});

  @override
  _CityDetailState createState() => _CityDetailState();
}

class _CityDetailState extends State<CityDetail> {
  late SQLDatabase database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = SQLDatabase();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FutureBuilder(
              future: database.getFavoritesByCityId(widget.data.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.red,
                    ),
                  );
                if (snapshot.data!.isEmpty)
                  return CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(
                              () {
                                database.insertItem(
                                Favorite(cityId: widget.data.id),
                                    database.favoritesTableName
                            );
                          },
                        );
                      },
                    ),
                  );
                return CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(
                            () {
                          database.removeItem(
                              database.favoritesTableName,
                              'cityId',
                              widget.data.id);
                        },
                      );
                    },
                  ),
                );
              },
            )

          ],
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('${widget.data.adi}'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.explore)),
              Tab(icon: Icon(Icons.mode_of_travel)),
              Tab(icon: Icon(Icons.fastfood_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Content(data: widget.data),
            MustTravelView(city: widget.data,),
            FoodsView(city: widget.data)
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final City data;

  Content({required this.data});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  late Future<Weather> havaDurumu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    havaDurumu = getWeather(widget.data.adi);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 230,
                child: Hero(
                  tag: 'city-img-${widget.data.id}',
                  child: GestureDetector(
                    onScaleStart: (ScaleStartDetails details) {
                      print(details);
                      _previousScale = _scale;
                      setState(() {});
                    },
                    onScaleUpdate: (ScaleUpdateDetails details) {
                      print(details);
                      _scale = _previousScale * details.scale;
                      setState(() {});
                    },
                    onScaleEnd: (ScaleEndDetails details) {
                      print(details);

                      _previousScale = 1.0;
                      setState(() {});
                    },
                    child: RotatedBox(
                      quarterTurns: 0,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform:
                        Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/${widget.data.type == 1 ? 'Yurtici' : 'Yurtdisi'}/${widget.data.adi.toLowerCase()}.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 170,
                  left: 16,
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        child: Text(
                          widget.data.adi,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          widget.data.ulke,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          FutureBuilder(
            future: havaDurumu,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Container(
                  padding: EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: Text('Bu şehirde hava: ${snapshot.data!.temp} °C', style: TextStyle(color: Colors.black),),
                );
              }

              return CircularProgressIndicator();
            },
          ),
          SizedBox(
            height: 15,
          ),
          TitleContainer(
            title: 'Açıklama',
            titleSize: 25,
            widget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Text(widget.data.aciklama, style: TextStyle(color: Colors.black),),
              ),
            ), containerHeight: 550,
          ),
        ],
      ),
    );
  }
}

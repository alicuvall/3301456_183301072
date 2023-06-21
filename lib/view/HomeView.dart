import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/component/ExpensesButton.dart';
import 'package:travel_app/component/FavoritesButton.dart';
import 'package:travel_app/component/GoalButton.dart';
import 'package:travel_app/component/NavigatorListTile.dart';
import 'package:travel_app/component/PlanButton.dart';
import 'package:travel_app/component/SehirCard.dart';
import 'package:travel_app/component/SocialButton.dart';
import 'package:travel_app/component/TitleContainer.dart';
import 'package:travel_app/data/CityData.dart';
import 'package:travel_app/view/AboutView.dart';
import 'package:travel_app/view/ExpenseView.dart';
import 'package:travel_app/view/FavoritesView.dart';
import 'package:travel_app/view/GoalView.dart';
import 'package:travel_app/view/LoginView.dart';
import 'package:travel_app/view/SocialView.dart';
import 'package:travel_app/view/ToDoView.dart';
import 'package:travel_app/view/UserProfile.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late SharedPreferences prefs;
  bool isLogged = false;

  @override
  void initState() {
    getPrefs();
// TODO: implement initState
    super.initState();
  }

  void getPrefs() async{
    prefs = await SharedPreferences.getInstance();

    setState(() {
      if (!prefs.containsKey('isLogged')) {
        prefs.setBool('isLogged', false);
        isLogged = prefs.getBool('isLogged') ?? false;
      } else {
        isLogged = prefs.getBool('isLogged') ?? false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              child: DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Travel App',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      WavingHandEmojiWidget()
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Ana sayfa',
                ),
              ),
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            PlanButton(
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: Colors.grey,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoView()));
              },
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            ExpensesButton(
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: Colors.grey,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpensesView()));
              },
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            GoalButton(
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: Colors.grey,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoalView()));
              },
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            SocialButton(
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: Colors.grey,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SocialView()));
              },
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            FavoritesButton(
              backgroundColor: Colors.white,
              textColor: Colors.black,
              iconColor: Colors.grey,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritesView()));
              },
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            NavigatorListTile(
              title: 'Hakkında',
              icon: Icon(Icons.info, color: Colors.grey,),
              backgroundColor: Colors.white,
              textColor: Colors.black,
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Hakkinda()));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Travel App'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          isLogged
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Tooltip(
                message: 'Profil',
                child: Icon(Icons.person_search, size: 30),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfileView()));
              },
            ),
          )
              : Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          )
        ],
      ),
      body: Content(),
    );
  }
}

class Content extends StatelessWidget {
  final Data sehirData = new Data();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Travel App!\nYeni yerler keşfet!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: PlanButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoView()));
                        },
                      ),
                    ),
                    Expanded(
                      child: FavoritesButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritesView()));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TitleContainer(
                  containerHeight: 200,
                  title: 'Yurtiçi Şehirler',
                  titleSize: 22,
                  widget: ListView(
                    scrollDirection: Axis.horizontal,
                    children: sehirData.yurtici
                        .sortedBy((element) => element.adi)
                        .map((item) => SehirCard(
                          sehirData: item,
                        ),
                    ).toList() as List<Widget>,
                  ),
                ),
                TitleContainer(
                  containerHeight: 200,
                  title: 'Yurtdışı Şehirler',
                  titleSize: 22,
                  widget: ListView(
                    scrollDirection: Axis.horizontal,
                    children: sehirData.yurtdisi
                        .sortedBy((element) => element.adi)
                        .map((item) => SehirCard(sehirData: item))
                        .toList() as List<Widget>,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WavingHandEmojiWidget extends StatefulWidget {
  @override
  _WavingHandEmojiWidgetState createState() => _WavingHandEmojiWidgetState();
}

class _WavingHandEmojiWidgetState extends State<WavingHandEmojiWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );
    _animation = Tween(
      begin: Offset.zero,
      end: Offset.fromDirection(2, 0.2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Text(
        '🛫',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
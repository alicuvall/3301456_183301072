import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/class/Authentication.dart';
import 'package:travel_app/component/ExpensesButton.dart';
import 'package:travel_app/component/FavoritesButton.dart';
import 'package:travel_app/component/GoalButton.dart';
import 'package:travel_app/component/PlanButton.dart';
import 'package:travel_app/component/TitleContainer.dart';
import 'package:travel_app/view/ExpenseView.dart';
import 'package:travel_app/view/FavoritesView.dart';
import 'package:travel_app/view/GoalView.dart';
import 'package:travel_app/view/HomeView.dart';
import 'package:travel_app/view/ToDoView.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late SharedPreferences prefs;
  Authentication _authService = Authentication();
  String mail = " ";

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = prefs.getString('userMail')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilin'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('User')
                    .where('email', isEqualTo: mail)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> items = snapshot.data!.docs;
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${items.isNotEmpty ? items[0]['name']: ''}',
                                      style: TextStyle(fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${items.isNotEmpty ? items[0]['email']: ''}',
                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25,),
                        TitleContainer(
                          containerHeight: 420,
                          titleSize: 20,
                          title: 'Navigasyon',
                          widget: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                GoalButton(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  iconColor: Colors.grey,
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoalView())).then((value) => setState((){}));
                                  },
                                ),
                                Divider(),
                                FavoritesButton(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  iconColor: Colors.grey,
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritesView())).then((value) => setState((){}));
                                  },
                                ),
                                Divider(),
                                PlanButton(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  iconColor: Colors.grey,
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoView())).then((value) => setState((){}));
                                  },
                                ),
                                Divider(),
                                ExpensesButton(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  iconColor: Colors.grey,
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpensesView())).then((value) => setState((){}));
                                  },
                                ),
                                Divider(),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text('Çıkış'),
                                    onPressed: () {
                                      prefs.setBool('isLogged', false);
                                      _authService.signOut();
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      padding: EdgeInsets.symmetric(horizontal: 110),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

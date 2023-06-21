import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/class/Authentication.dart';
import 'package:travel_app/view/HomeView.dart';
import 'package:travel_app/view/RegisterView.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;

  late String eMail = "";
  late String pass = "";

  @override
  void initState() {
    getPrefs();
    // TODO: implement initState
    super.initState();
    print('init');
  }

  void getPrefs() async{
    prefs = await SharedPreferences.getInstance();
    print('prefs init');
  }

  Authentication _authService = Authentication();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Travel App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'E-MAIL',
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(text: ''),
                    onChanged: (value){
                      eMail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff2CA1C0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'PAROLA',
                      style: TextStyle(fontSize: 13, color: Colors.black),
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(text: ''),
                    onChanged: (value){
                      pass = value;
                    },
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff2CA1C0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterView()));
                      },
                      child: Text('Kayıt olmak için tıkla.')),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _authService.girisYap(eMail, pass).then((value){
                        if(value != null){
                          Stream<QuerySnapshot> snap = FirebaseFirestore.instance.collection('User').where('email', isEqualTo: eMail).snapshots();
                          snap.forEach((element) {
                            if(element == null){
                              return;
                            }
                            prefs.setString('name', element.docs[0]['name']);
                          });
                          prefs.setBool('isLogged', true);
                          prefs.setString('userMail', eMail);
                          return Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
                        }
                      });
                    },
                    child: Text('GİRİŞ'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

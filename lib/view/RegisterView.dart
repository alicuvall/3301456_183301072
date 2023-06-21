import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/class/Authentication.dart';
import 'package:travel_app/view/HomeView.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late SharedPreferences prefs;
  String eMail = "";
  String pass = "";
  String passValidation = "";
  String name = "";

  Authentication _authService = Authentication();

  Future getPrefs() async{
    prefs = await SharedPreferences.getInstance();
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
        title: Text('Kayıt Ol'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
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
                      'Kayıt Ol',
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
                        'ADINIZ',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                    TextField(
                      onChanged: (value){
                        name = value;
                      },

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
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        eMail = value;
                      },
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
                      onChanged: (value){
                        pass = value;
                      },
                      obscureText: true,
                      enableSuggestions: false,
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
                    SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'PAROLA TEKRAR',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                    TextField(
                      onChanged: (value){
                        passValidation = value;
                      },
                      obscureText: true,
                      enableSuggestions: false,
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

                    ElevatedButton(
                      onPressed: () {
                        if(name.trim() == ""){
                          Fluttertoast.showToast(
                              msg: 'Lütfen adınızı doldurunuz.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else if(eMail.trim() == ""){
                          Fluttertoast.showToast(
                              msg: 'Lütfen mailinizi doldurunuz.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else if(pass.trim() == ""){
                          Fluttertoast.showToast(
                              msg: 'Lütfen şifrenizi doldurunuz.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else if(passValidation.trim() == ""){
                          Fluttertoast.showToast(
                              msg: 'Lütfen şifrenizi ikinci kez giriniz.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else if(pass.trim() != passValidation.trim()){
                          Fluttertoast.showToast(
                              msg: 'Şifreler uyuşmuyor. Lütfen tekrar deneyin.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }else if(pass.trim() == passValidation.trim()){
                          _authService.kullaniciOlustur(name, eMail, pass).then((value){
                            if(value != null){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
                            }else{
                              Fluttertoast.showToast(
                                  msg: 'Kayıt olurken bir sorun oluştu.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.black,
                                  fontSize: 16.0
                              );
                            }
                          });
                        }
                      },
                      child: Text('Kayıt Ol'),
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
      ),
    );
  }
}

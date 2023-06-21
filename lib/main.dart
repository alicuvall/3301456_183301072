import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/class/FileUtils.dart';
import 'package:travel_app/view/HomeView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDhzNaJpuTeqLXwlT6lVR5wFu75FXlbBvY',
      authDomain: '',
      databaseURL: '',
      projectId: 'travel-app-55d49',
      storageBucket: 'travel-app-55d49.appspot.com',
      messagingSenderId: '',
      appId: '1:939146223370:android:8a0c922ac2158c9f5c24f3',
      measurementId: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Fluttertoast.showToast(
              msg: "HATA!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              fontSize: 16.0);
        }

        FileUtils.dosyayaKeydet(
            'Kullanıcı girişi:' + DateTime.now().toString() + "\n");
        print(FileUtils.dosyadanOku().then((value) => print(value)));

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.redAccent,
            tabBarTheme: TabBarTheme(
                labelColor: Colors.white,
                indicator: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.white,
                )))),
            textTheme: TextTheme(
              bodyText2: TextStyle(color: Colors.white),
            ),
            scaffoldBackgroundColor: Colors.white,
            primaryTextTheme: TextTheme(
              headline6: TextStyle(color: Colors.white),
            ),
            appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          home: HomeView(),
        );
      },
    );
  }
}

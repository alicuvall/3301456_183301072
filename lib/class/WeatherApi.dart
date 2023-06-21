import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:travel_app/class/Weather.dart';


Future<Weather> getWeather(String cityName) async{
  String myUri = 'http://api.openweathermap.org/data/2.5/weather?q=${cityName.toString()}&appid=dbd1a8f33f3664b7fd511dfabb959442&units=metric&lang=tr';
  final response = await http.get(Uri.parse(myUri));
  if(response.statusCode == 200){
    return Weather.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('data error');
  }
}
import 'package:travel_app/class/Foods.dart';
import 'package:travel_app/class/Place.dart';

class City{
   String adi;
   String aciklama;
   String ulke;
   int id;
   int type;
  List<Place> yerler;
   List<Foods> foods;


   City({required this.foods, required this.id, required this.adi, required this.aciklama, required this.ulke, required this.type, required this.yerler});
}
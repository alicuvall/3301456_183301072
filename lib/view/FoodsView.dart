import 'package:flutter/material.dart';
import 'package:travel_app/class/City.dart';

class FoodsView extends StatefulWidget {
  final City city;

  FoodsView({required this.city});

  @override
  _FoodsViewState createState() => _FoodsViewState();
}

class _FoodsViewState extends State<FoodsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.city.foods.length,
          itemBuilder: (context, index){
            var yemek = widget.city.foods[index];
            return FoodCard(foodData: yemek, city: widget.city,);
          },
        )
    );
  }
}

class FoodCard extends StatelessWidget {
  final foodData;
  final City city;

  FoodCard({this.foodData, required this.city});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image(
                  image: AssetImage('assets/images/${city.type == 1 ? 'Yurtici' : 'Yurtdisi'}/Yemek/${city.adi}/${foodData.fotograf}.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  foodData.ad,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



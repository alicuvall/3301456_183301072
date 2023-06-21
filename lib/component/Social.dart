import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Social extends StatelessWidget {
  final String userName;
  final String comment;
  final DateTime time;

  Social({
    required this.userName,
    required this.comment,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: secondColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(22.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            userName,
                            style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            '${DateFormat('dd.MM.yyyy HH:mm').format(time)}',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    child: Text(
                      comment,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

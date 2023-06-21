import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Expenses.dart';
import 'package:travel_app/component/TitleContainer.dart';

class AddExpenseView extends StatefulWidget {
  @override
  _AddExpenseViewState createState() => _AddExpenseViewState();
}

class _AddExpenseViewState extends State<AddExpenseView> {
  late SQLDatabase _dbHelper;
  String expenseTitleValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = SQLDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bütçe Ekle'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleContainer(
                containerHeight: 200,
                titleSize: 20,
                title: 'Bütçe ekle',
                widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text('Başlık:', style: TextStyle(color: Colors.black),),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: '...',
                                    hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  maxLines: null,
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    setState(() {
                                      expenseTitleValue = value;
                                    });
                                  },
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                        ElevatedButton(
                          child: Text('Kaydet'),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 110),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            if(expenseTitleValue.trim() == ""){
                              //ToastHelper().makeToastMessage('Lütfen harcama başlığını doldurunuz.');
                            }else{
                              _dbHelper.insertItem(
                                  Expenses(
                                      id: 0,
                                      expenseTitle: expenseTitleValue,
                                      expenseDate: DateFormat('dd.MM.yyyy')
                                          .format(DateTime.now())
                                  ),
                                  _dbHelper.expensesTableName
                              );
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

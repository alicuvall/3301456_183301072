import 'package:flutter/material.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Expenses.dart';
import 'package:travel_app/class/Expenses.dart';
import 'package:travel_app/view/AddExpenseView.dart';
import 'package:travel_app/view/ExpenseDetailView.dart';

class ExpensesView extends StatefulWidget {
  @override
  _ExpensesViewState createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  late SQLDatabase _dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = SQLDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpenseView())).then((value) => setState((){}));;
        },
      ),
      appBar: AppBar(
        title: Text('Bütçeler'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _dbHelper.getExpenses(),
            builder: (context, AsyncSnapshot<List<Expenses>> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              if (snapshot.data!.isEmpty)
                return Center(
                  child: Text(
                    'Burası boş. Kayıt oluştur!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                );

              return ListView.separated(
                separatorBuilder: (context, index){
                  return Divider();
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Expenses expense = snapshot.data![index];
                  return Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        _dbHelper.removeItem(_dbHelper.expensesTableName, 'id', expense.id);
                        _dbHelper.removeItem(_dbHelper.expensesDetailTableName, 'expenseId', expense.id);
                        snapshot.data!.removeAt(index);
                      });

                    },
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    key: UniqueKey(),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpenseDetailView(expense: expense))).then((value) => setState((){}));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  'Bütçe: ${expense.expenseTitle}',
                                  style: TextStyle(color: Colors.red, fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                height: 15,
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Tarih: ', style: TextStyle(color: Colors.black),),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '${expense.expenseDate}',
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text('Tutar: ', style: TextStyle(color: Colors.black),),

                                        SizedBox(
                                          width: 15,
                                        ),
                                        FutureBuilder(
                                          future: _dbHelper.getTotalById('ExpensesDetail', 'expenseMoney', expense.id, 'expenseId'),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData)
                                              return Text(
                                                '0',
                                                style: TextStyle(color: Colors.red),
                                              );

                                            return Text(
                                              '${snapshot.data}',
                                              style: TextStyle(color: Colors.red),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
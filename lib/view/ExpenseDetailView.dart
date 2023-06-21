import 'package:flutter/material.dart';
import 'package:travel_app/class/Expenses.dart';
import 'package:travel_app/class/ExpensesDetail.dart';
import 'package:travel_app/component/TitleContainer.dart';
import 'package:travel_app/class/Database.dart';

class ExpenseDetailView extends StatefulWidget {
  final Expenses expense;

  ExpenseDetailView({required this.expense});

  @override
  _ExpenseDetailViewState createState() => _ExpenseDetailViewState();
}

class _ExpenseDetailViewState extends State<ExpenseDetailView> {
  late SQLDatabase _dbHelper;
  final _aciklamaController = TextEditingController();
  final _miktarController = TextEditingController();

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
        title: Text('${widget.expense.id} numaralı bütçen'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                future: _dbHelper.getExpensesDetail(widget.expense.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  if (snapshot.data!.isEmpty)
                    return Flexible(
                      child: Center(
                        child: Text(
                          'Burada kayıtlı herhangi bir şey yok.\nYeni eleman ekle!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );

                  return Flexible(
                    flex: 9,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ExpensesDetail expenseDetail = snapshot.data![index];

                        return TitleContainer(
                          containerHeight: 200,
                          titleSize: 20,
                          title: 'Harcama: ${expenseDetail.expenseDescription}',
                          widget: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.money,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text('Miktar: ${expenseDetail.expenseMoney}', style: TextStyle(color: Colors.black),),
                                  ],
                                ),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _dbHelper.removeItem(_dbHelper.expensesDetailTableName, 'id', expenseDetail.id);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Harcama adı...',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          controller: _aciklamaController,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Miktar...',
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          controller: _miktarController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(
                            () {
                          if (_aciklamaController.text.trim() == "" && _miktarController.text.trim() == "") {
                            /*ToastHelper().makeToastMessage(
                                'Harcama adı ve miktarını doldurunuz.');*/
                          } else if (_aciklamaController.text.trim() == "") {
                            /*ToastHelper()
                                .makeToastMessage('Harcama adını doldurunuz.');*/
                          } else if (_miktarController.text.trim() == "") {
                            /*ToastHelper()
                                .makeToastMessage('Miktarı doldurunuz.');*/
                          } else {
                            _dbHelper.insertItem(
                                ExpensesDetail(
                                  id: widget.expense.id,
                                  expenseId: widget.expense.id,
                                  expenseDescription: _aciklamaController.text,
                                  expenseMoney: int.parse(_miktarController.text),
                                ),
                                _dbHelper.expensesDetailTableName);
                            _aciklamaController.clear();
                            _miktarController.clear();
                          }
                        },
                      );
                    },
                    child: Text('Ekle'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 110),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

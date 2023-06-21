import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/class/Database.dart';
import 'package:travel_app/class/Goal.dart';
import 'package:travel_app/view/AddGoalView.dart';
import 'package:travel_app/view/GoalDetailView.dart';

class GoalView extends StatefulWidget {
  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
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
        child: Tooltip(
          message: 'Yeni amaç ekle',
          child: Icon(Icons.add),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddGoalView())).then((value) => setState((){}));
        },
      ),
      appBar: AppBar(
        title: Text('Amaçlarım'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _dbHelper.getTargets(),
          builder: (context, AsyncSnapshot<List<Goal>> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if (snapshot.data!.isEmpty)
              return Center(
                child: Text(
                  'Burası boş. Yeni bir kayıt ekle!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black)
                ),
              );
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Goal target = snapshot.data![index];
                return Card(
                  child: Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        _dbHelper.removeItem(_dbHelper.goalTableName, 'id', target.id);
                        snapshot.data!.removeAt(index);
                      });
                      Fluttertoast.showToast(
                          msg: "${target.targetHead} kaldırıldı.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
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
                    key: ValueKey(target.id),
                    child: ListTile(
                      title: Text('${target.id} - ${target.targetHead}'),
                      tileColor: Colors.white,
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                      leading: Icon(
                        Icons.assignment_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onLongPress: () {
                        Fluttertoast.showToast(
                            msg: '${target.targetDate} tarihinde oluşturuldu.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoalDetailView(hedef: target,))).then((value) => setState((){}));
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

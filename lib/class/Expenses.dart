class Expenses{
  late int id;
  late String expenseTitle;
  late String expenseDate;

  Expenses({required this.id, required this.expenseTitle, required this.expenseDate});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['expenseTitle'] = expenseTitle;
    map['expenseDate'] = expenseDate;
    return map;
  }

  Expenses.fromMap(Map<String, dynamic> map){
    id = map['id'];
    expenseTitle = map["expenseTitle"];
    expenseDate = map["expenseDate"];
  }
}
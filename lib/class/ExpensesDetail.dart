class ExpensesDetail{
  late int id;
  late int expenseId;
  late String expenseDescription;
  late int expenseMoney;

  ExpensesDetail({required this.id, required this.expenseId, required this.expenseDescription, required this.expenseMoney});

  Map<String, dynamic> toMap(){ // veri eklemek için.
    var map = Map<String, dynamic>();
    map['expenseId'] = expenseId;
    map['expenseDescription'] = expenseDescription;
    map['expenseMoney'] = expenseMoney;
    return map;
  }

  ExpensesDetail.fromMap(Map<String, dynamic> map){
    id = map['id'];
    expenseId = map["expenseId"];
    expenseDescription = map["expenseDescription"];
    expenseMoney = map["expenseMoney"];
  }
}
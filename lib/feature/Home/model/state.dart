import 'package:trahmoo/feature/Home/model/benefactor.dart';

class Tabraa {
  int? id;
  State? state;
  double? paid;
  List<Benefactor>? benefactor;
  bool? isDone;
  String? completedDate;
  String? category_name;
  int? category;
  int? benficiary;

  Tabraa(
      {this.id,
        this.state,
        this.paid,
        this.benefactor,
        this.isDone,
        this.completedDate,
        this.category,
        this.category_name,
        this.benficiary});

  Tabraa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    paid = json['paid'];
    if (json['benefactor'] != null) {
      benefactor = <Benefactor>[];
      json['benefactor'].forEach((v) {
        benefactor!.add(new Benefactor.fromJson(v));
      });
    }
    isDone = json['is_done'];
    category_name = json['category_name'];
    completedDate = json['completed_date'];
    category = json['category'];
    benficiary = json['benficiary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    data['paid'] = this.paid;
    if (this.benefactor != null) {
      data['benefactor'] = this.benefactor!.map((v) => v.toJson()).toList();
    }
    data['is_done'] = this.isDone;
    data['category_name'] = this.category_name;
    data['completed_date'] = this.completedDate;
    data['category'] = this.category;
    data['benficiary'] = this.benficiary;
    return data;
  }
  String toString() {
    return 'Tabraa { id: $id, state: $state,category_name:$category_name, paid: $paid, benefactor: $benefactor, isDone: $isDone, completedDate: $completedDate, category: $category, benficiary: $benficiary }';
  }
}

class State {
  int? id;
  String? name;
  String? amount;
  String? image;
  String? description;
  String? address;
  int? benficiary;
  int? category;
  bool? is_from_app;


  State(
      {this.id,
        this.name,
        this.amount,
        this.image,
        this.description,
        this.address,
        this.benficiary,
        this.is_from_app,
        this.category});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    is_from_app = json['is_from_app'];
    amount = json['amount'];
    image = json['image'];
    description = json['description'];
    address = json['address'];
    benficiary = json['benficiary'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['is_from_app'] = this.is_from_app;
    data['image'] = this.image;
    data['description'] = this.description;
    data['address'] = this.address;
    data['benficiary'] = this.benficiary;
    data['category'] = this.category;
    return data;
  }
  @override
  String toString() {
    return 'State { id: $id, name: $name, amount: $amount, image: $image, description: $description, address: $address, benficiary: $benficiary, category: $category }';
  }
}

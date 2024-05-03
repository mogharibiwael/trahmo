import 'package:trahmoo/feature/Home/model/state.dart';

class CategoryState {
  int? id;
  String? name;
  String? image;
  String? description;
  List<State>? states;

  CategoryState(
      {this.id, this.name, this.image, this.description, this.states});

  CategoryState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    if (json['states'] != null) {
      states = <State>[];
      json['states'].forEach((v) {
        states!.add(new State.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

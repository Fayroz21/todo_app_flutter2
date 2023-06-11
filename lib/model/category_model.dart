

import '../constants/constants.dart';

class CategoryModel{
  int? id;
  String? name;
  String? desc;

  CategoryModel({this.name, this.desc, this.id});

  Map<String, dynamic> toMap(){
    //To insert to db
    var map = Map<String, dynamic>();
    map[Consts.colCatName] = name;
    map[Consts.colCatDesc] = desc;
    map['id'] = id;

    return map;
  }

  CategoryModel.fromMap(map){
    name = map[Consts.colCatName];
    desc = map[Consts.colCatDesc];
    id = map['id'];
  }
}
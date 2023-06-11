import '../constants/constants.dart';

class TodoModel{
  int? id;
  String? title;
  String? descDo;
  String? category;
  String? todoDate;
  int? isFinished;


  TodoModel({this.id, this.title, this.descDo, this.category, this.todoDate,
      this.isFinished});

  Map<String, dynamic> toMap(){
    //To insert to db
    var map = Map<String, dynamic>();
    map[Consts.colID] = id;
    map[Consts.colDoTitle] = title;
    map[Consts.colDoDesc] = descDo;
    map[Consts.colDoCat] = category;
    map[Consts.colDoDate] = todoDate;
    map[Consts.colDoFinish] = isFinished;


    return map;
  }

  TodoModel.fromMap(map){
    id = map[Consts.colID];
    title = map[Consts.colDoTitle];
    descDo = map[Consts.colDoDesc];
    category = map[Consts.colDoCat];
    todoDate = map[Consts.colDoDate];
    isFinished = map[Consts.colDoFinish];
  }
}
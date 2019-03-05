import 'package:json_annotation/json_annotation.dart';
import 'package:json_demo/Dic.dart';

part 'Data.g.dart';

@JsonSerializable()
class Data{
  bool error;
  List<Dic> results;
  Data(this.error,this.results);
  //反序列化
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$DataToJson(this);  
}
import 'package:json_annotation/json_annotation.dart';
part 'Dic.g.dart';

@JsonSerializable()
class Dic{
  final String createdAt;
  final String desc;
  final String publishedAt;
  final String source;
  final String type;
  final String url;
  final bool used;
  final String who;

  Dic({this.createdAt, this.desc, this.publishedAt, this.source, this.type,
    this.url, this.used, this.who});

  //反序列化
  factory Dic.fromJson(Map<String, dynamic> json) => _$DicFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$DicToJson(this);  
}
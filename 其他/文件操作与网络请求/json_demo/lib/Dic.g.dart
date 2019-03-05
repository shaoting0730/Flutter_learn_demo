// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dic _$DicFromJson(Map<String, dynamic> json) {
  return Dic(
      createdAt: json['createdAt'] as String,
      desc: json['desc'] as String,
      publishedAt: json['publishedAt'] as String,
      source: json['source'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      used: json['used'] as bool,
      who: json['who'] as String);
}

Map<String, dynamic> _$DicToJson(Dic instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'desc': instance.desc,
      'publishedAt': instance.publishedAt,
      'source': instance.source,
      'type': instance.type,
      'url': instance.url,
      'used': instance.used,
      'who': instance.who
    };

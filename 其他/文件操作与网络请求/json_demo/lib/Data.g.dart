// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['error'] as bool,
      (json['results'] as List)
          ?.map(
              (e) => e == null ? null : Dic.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'error': instance.error, 'results': instance.results};

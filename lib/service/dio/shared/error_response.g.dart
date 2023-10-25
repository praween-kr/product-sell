// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
      success: json['success'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  return val;
}

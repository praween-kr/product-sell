// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse<TModel> _$DataResponseFromJson<TModel>(
  Map<String, dynamic> json,
  TModel Function(Object? json) fromJsonTModel,
) {
  print("-----000000)))))>>>>> ${json['body'].runtimeType}");
  return DataResponse<TModel>(
    success: json['success'] as bool?,
    code: json['code'] as int?,
    message: json['message'] as String?,
    body: _$nullableGenericFromJson(json['body'], fromJsonTModel),
  );
}

Map<String, dynamic> _$DataResponseToJson<TModel>(
  DataResponse<TModel> instance,
  Object? Function(TModel value) toJsonTModel,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  writeNotNull('body', _$nullableGenericToJson(instance.body, toJsonTModel));
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

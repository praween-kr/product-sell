// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/app_print.dart';

part 'data_response.g.dart';

@JsonSerializable(
    genericArgumentFactories: true, includeIfNull: false, explicitToJson: true)
class DataResponse<TModel> {
  bool? success;
  int? code;
  String? message;
  TModel? body;

  DataResponse({this.success, this.code, this.message, this.body});

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    TModel Function(Object? json) fromJsonT,
  ) =>
      _$DataResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) =>
      _$DataResponseToJson(this, toJsonT);
}

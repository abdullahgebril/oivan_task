import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T> extends Equatable {
  final List<T> items;

  @JsonKey(name: 'has_more')
  final bool hasMore;

  @JsonKey(name: 'quota_max')
  final int? quotaMax;

  @JsonKey(name: 'quota_remaining')
  final int? quotaRemaining;

  const ApiResponseModel({
    required this.items,
    required this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ApiResponseModelToJson(this, toJsonT);

  @override
  List<Object?> get props => [items, hasMore, quotaMax, quotaRemaining];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reputation_history_model.g.dart';

@JsonSerializable()
class ReputationHistoryModel extends Equatable {
  @JsonKey(name: 'reputation_history_type')
  final String? reputationHistoryType;

  @JsonKey(name: 'reputation_change')
  final int? reputationChange;

  @JsonKey(name: 'post_id')
  final int? postId;

  @JsonKey(name: 'creation_date')
  final int? creationDate;

  @JsonKey(name: 'user_id')
  final int? userId;

  const ReputationHistoryModel({
    this.reputationHistoryType,
    this.reputationChange,
    this.postId,
    this.creationDate,
    this.userId,
  });

  factory ReputationHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ReputationHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReputationHistoryModelToJson(this);

  @override
  List<Object?> get props => [
        reputationHistoryType,
        reputationChange,
        postId,
        creationDate,
        userId,
      ];
}

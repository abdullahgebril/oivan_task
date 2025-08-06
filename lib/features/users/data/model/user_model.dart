import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  @JsonKey(name: 'account_id')
  final int? accountId;

  @JsonKey(name: 'is_employee')
  final bool? isEmployee;

  @JsonKey(name: 'last_modified_date')
  final int? lastModifiedDate;

  @JsonKey(name: 'last_access_date')
  final int? lastAccessDate;

  @JsonKey(name: 'reputation_change_year')
  final int? reputationChangeYear;

  @JsonKey(name: 'reputation_change_quarter')
  final int? reputationChangeQuarter;

  @JsonKey(name: 'reputation_change_month')
  final int? reputationChangeMonth;

  @JsonKey(name: 'reputation_change_week')
  final int? reputationChangeWeek;

  @JsonKey(name: 'reputation_change_day')
  final int? reputationChangeDay;

  final int? reputation;

  @JsonKey(name: 'creation_date')
  final int? creationDate;

  @JsonKey(name: 'user_type')
  final String? userType;

  @JsonKey(name: 'user_id')
  final int userId;

  final int? age;

  final String? location;

  @JsonKey(name: 'website_url')
  final String? websiteUrl;

  final String? link;

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  @JsonKey(name: 'display_name')
  final String displayName;

  const UserModel({
    this.accountId,
    this.isEmployee,
    this.lastModifiedDate,
    this.lastAccessDate,
    this.reputationChangeYear,
    this.reputationChangeQuarter,
    this.reputationChangeMonth,
    this.reputationChangeWeek,
    this.reputationChangeDay,
    this.reputation,
    this.creationDate,
    this.userType,
    required this.userId,
    this.age,
    this.location,
    this.websiteUrl,
    this.link,
    this.profileImage,
    required this.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        accountId,
        isEmployee,
        lastModifiedDate,
        lastAccessDate,
        reputationChangeYear,
        reputationChangeQuarter,
        reputationChangeMonth,
        reputationChangeWeek,
        reputationChangeDay,
        reputation,
        creationDate,
        userType,
        userId,
        age,
        location,
        websiteUrl,
        link,
        profileImage,
        displayName,
      ];
}

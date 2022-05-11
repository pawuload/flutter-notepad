import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details.freezed.dart';

part 'user_details.g.dart';

@freezed
class UserDetails with _$UserDetails {
  factory UserDetails({required String email,required bool isPremium}) = _UserDetails;

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);
}

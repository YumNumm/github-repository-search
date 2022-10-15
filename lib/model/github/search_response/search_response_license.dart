import 'package:json_annotation/json_annotation.dart';

part 'search_response_license.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponseLicense {
  SearchResponseLicense({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
  });

  factory SearchResponseLicense.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseLicenseFromJson(json);

  /// ex. "mit"
  final String key;

  /// ex. "MIT License"
  final String name;

  /// ex. "MIT"
  final String? spdxId;

  /// ex. "https://api.github.com/licenses/mit"
  final String? url;

  Map<String, dynamic> toJson() => _$SearchResponseLicenseToJson(this);
}

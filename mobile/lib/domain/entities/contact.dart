import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Contact extends Equatable {
  final String formattedPhone;
  final String internationalPhone;
  final String website;

  String get websiteWithoutProtocol => website
      ?.replaceAll(RegExp('^https?://'), '')
      ?.replaceAll('www.', '')
      ?.replaceAll('/', '');

  bool get hasValues => formattedPhone != null && website != null;

  Contact(
      {@required this.formattedPhone,
      @required this.internationalPhone,
      @required this.website});

  @override
  List<Object> get props => [formattedPhone, internationalPhone, website];

  Contact copyWith({
    String address,
    String formattedPhone,
    String internationalPhone,
    String website,
  }) {
    return Contact(
      formattedPhone: formattedPhone ?? this.formattedPhone,
      internationalPhone: internationalPhone ?? this.internationalPhone,
      website: website ?? this.website,
    );
  }
}

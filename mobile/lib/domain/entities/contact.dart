import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String address;
  final String formattedPhone;
  final String internationalPhone;
  final String website;

  Contact(
      {this.address,
      this.formattedPhone,
      this.internationalPhone,
      this.website});

  @override
  List<Object> get props => [address, formattedPhone, website];

  Contact copyWith({
    String address,
    String formattedPhone,
    String internationalPhone,
    String website,
  }) {
    return Contact(
      address: address ?? this.address,
      formattedPhone: formattedPhone ?? this.formattedPhone,
      internationalPhone: internationalPhone ?? this.internationalPhone,
      website: website ?? this.website,
    );
  }
}

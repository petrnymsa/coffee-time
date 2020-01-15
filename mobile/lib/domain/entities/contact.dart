import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String address;
  final String phone;
  final String website;

  ContactEntity({this.address, this.phone, this.website});

  @override
  List<Object> get props => [address, phone, website];

  ContactEntity copyWith({
    String address,
    String phone,
    String website,
  }) {
    return ContactEntity(
      address: address ?? this.address,
      phone: phone ?? this.phone,
      website: website ?? this.website,
    );
  }
}

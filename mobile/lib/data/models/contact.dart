import 'package:coffee_time/domain/entities/contact.dart';
import 'package:meta/meta.dart';

class ContactModel extends ContactEntity {
  ContactModel(
      {@required String address,
      @required String phone,
      @required String website})
      : super(address: address, phone: phone, website: website);

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return null;
  }

  Map<String, dynamic> toJson() {
    return null;
  }
}

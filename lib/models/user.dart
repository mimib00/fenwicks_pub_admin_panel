import 'address.dart';

class Users {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final List<Address>? address;
  final int points;
  final String token;

  Users(
    this.name,
    this.email,
    this.phone,
    this.points,
    this.token, {
    this.id,
    this.address,
  });

  factory Users.fromJson(Map<String, dynamic> data, {String? uid}) {
    List<Address> addresses = [];
    List? temp = data["address"];
    if (temp != null && temp.isNotEmpty) {
      for (var item in temp) {
        addresses.add(Address.fromJson(item));
      }
    }

    return Users(
      data["name"],
      data["email"],
      data["phone"],
      data["points"] ?? 0,
      data["token"] ?? '',
      address: addresses,
      id: uid,
    );
  }

  toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "points": points,
        "token": token,
      };
}

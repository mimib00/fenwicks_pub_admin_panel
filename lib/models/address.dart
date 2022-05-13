class Address {
  final String addressType;
  final String address;

  Address(
    this.addressType,
    this.address,
  );

  factory Address.fromJson(Map<String, dynamic> data) => Address(data["address_type"], data["address"]);

  toMap() => {
        "address_type": addressType,
        "address": address,
      };
}

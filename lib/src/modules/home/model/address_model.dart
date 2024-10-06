class AddressModel {
  late String cep;
  late String publicPlace;
  late String? complement;
  late String neighborhood;
  late String city;
  late String state;

  AddressModel({
    required this.cep,
    required this.publicPlace,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  AddressModel.fromJson(Map<String, dynamic> json)
      : cep = json["cep"],
        publicPlace = json["logradouro"],
        complement = json["complemento"] ?? '',
        neighborhood = json["bairro"],
        city = json["localidade"],
        state = json["uf"];

  AddressModel.fromJsonLocal(Map<String, dynamic> json)
      : cep = json["cep"],
        publicPlace = json["publicPlace"],
        complement = json["complement"] ?? '',
        neighborhood = json["neighborhood"],
        city = json["city"],
        state = json["state"];

  Map<String, dynamic> toJson() {
    return {
      "cep": cep,
      "publicPlace": publicPlace,
      "complement": complement,
      "neighborhood": neighborhood,
      "city": city,
      "state": state,
    };
  }
}

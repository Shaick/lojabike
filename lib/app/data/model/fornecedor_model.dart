import 'package:cloud_firestore/cloud_firestore.dart';

class Fornecedor {
  String? fornecedorId;
  String? cnpj;
  String? ie;
  String? photoUrl;
  String? site;
  String? email;
  String? phone;
  String? name;
  String? uf;
  String? city;
  String? cep;
  String? district;
  String? address;

  Fornecedor({
    this.fornecedorId,
    this.cnpj,
    this.ie,
    this.photoUrl,
    this.site,
    this.email,
    this.phone,
    this.name,
    this.uf,
    this.cep,
    this.city,
    this.district,
    this.address,
  });

  factory Fornecedor.fromJson(Map<String, dynamic> json) {
    return Fornecedor(
        fornecedorId: json['fornecedorId'],
        name: json['name'],
        cnpj: json['cnpj'],
        ie: json['ie'],
        email: json['email'],
        photoUrl: json['photoUrl'],
        site: json['site'],
        phone: json['phone'],
        uf: json['uf'],
        cep: json['cep'],
        city: json['city'],
        district: json['district'],
        address: json['address']);
  }

  Map<String, dynamic> toMap() {
    return {
      'fornecedorId': fornecedorId,
      'cnpj': cnpj,
      'ie': ie,
      'email': email,
      'photoUrl': photoUrl,
      'site': site,
      'phone': phone,
      'name': name,
      'uf': uf,
      'cep': cep,
      'city': city,
      'district': district,
      'address': address
    };
  }

  Fornecedor.fromSnapshott(DocumentSnapshot snapshot) {
    fornecedorId = snapshot["fornecedorId"] as String;
    // name = document['nome'] as String;
    //cnpj = snapshot.value["cnpj"];
    cnpj = snapshot["cnpj"] as String;
    ie = snapshot["ie"] as String;
    email = snapshot["email"] as String;
    photoUrl = snapshot["photoUrl"] as String;
    phone = snapshot["phone"] as String;
    site = snapshot["site"] as String;
    name = snapshot["name"] as String;
    uf = snapshot["uf"] as String;
    cep = snapshot["cep"] as String;
    city = snapshot["city"] as String;
    district = snapshot["district"] as String;
    address = snapshot["address"] as String;
  }
}

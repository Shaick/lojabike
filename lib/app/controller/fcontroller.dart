import 'package:get/get.dart';
import 'package:lojabike/app/data/model/fornecedor_model.dart';
import 'package:lojabike/app/data/provider/entry_provider.dart';

class FController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    var map = await entryProvider.getFornecedores();

    fornecedores = map;
    update();
  }

  @override
  void onReady() async {
    super.onReady();
    var map = await entryProvider.getFornecedores();

    fornecedores = map;
    update();
  }

  Fornecedor fornecedor = Fornecedor();
  EntryProvider entryProvider = EntryProvider();
  String? _fornecedorId;
  String? _cnpj;
  String? _ie;
  String? _name;
  String? _email;
  String? _photoUrl;
  String? _site;
  String? _phone;
  String? _uf;
  String? _city;
  String? _cep;
  String? _district;
  String? _address;
  var fornecedores;

  //Getters
  String? get name => _name;
  String? get email => _email;
  String? get cnpj => _cnpj;
  String? get ie => _ie;
  String? get cep => _cep;
  String? get photo => _photoUrl;
  String? get site => _site;
  String? get phone => _phone;
  String? get uf => _uf;
  String? get city => _city;
  String? get district => _district;
  String? get address => _address;
  String? get fornecedorId => _fornecedorId;
  // Map get fornecedores => _fornecedores;

  //Setters
  set changeFornecedorId(String fornecedorId) {
    _fornecedorId = fornecedorId;
    update();
  }

  set changeName(String name) {
    _name = name;
    update();
  }

  set changeIe(String ie) {
    _ie = ie;
    update();
  }

  set changeEmail(String email) {
    _email = email;
    update();
  }

  set changeSite(String site) {
    _site = site;
    update();
  }

  set changeCnpj(String cnpj) {
    _cnpj = cnpj;
    update();
  }

  set changePhotoUrl(String photo) {
    _photoUrl = photo;
    update();
  }

  set changePhone(String phone) {
    _phone = phone;
    update();
  }

  set changeUf(String uf) {
    _uf = uf;
    update();
  }

  set changeCep(String cep) {
    _cep = cep;
    update();
  }

  set changeCity(String value) {
    _city = value;
    update();
  }

  set changeDistrict(String district) {
    _district = district;
    update();
  }

  set changeAddress(String address) {
    _address = address;
    update();
  }

/*   set changeFornecedores(Map fornecedores) {
    _fornecedores = fornecedores;
    update();
  } */

  //Functions
  loadAll(Fornecedor forn) {
    // ignore: unnecessary_null_comparison
    if (forn != null) {
      _fornecedorId = forn.fornecedorId;
      _name = forn.name;
      _email = forn.email;
      _site = forn.site;
      _phone = forn.phone;
      _photoUrl = forn.photoUrl;
      _cnpj = forn.cnpj;
      _ie = forn.ie;
      _uf = forn.uf;
      _city = forn.city;
      _district = forn.district;
      _address = forn.address;
      _cep = forn.cep;
    }
  }

  Fornecedor fornece = Fornecedor();
  saveEntry(String uid) {
    //Add
    fornece = Fornecedor(
        fornecedorId: uid,
        cnpj: _cnpj!,
        ie: _ie!,
        photoUrl: _photoUrl!,
        phone: _phone!,
        name: _name!,
        email: _email!,
        site: _site!,
        uf: _uf!,
        city: _city!,
        cep: _cep!,
        district: _district!,
        address: _address!);
    //box.write("fornecedor", fornece.toMap());
    //box.write("page", "/fornecedores");
    entryProvider.setFornecedores(uid, fornece);
  }
}

class CustomerModel {
  int? id;
  String? createdAt;
  String? nama;
  int? batasUtang;

  CustomerModel({
    this.id,
    this.createdAt,
    this.nama,
    this.batasUtang,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    nama = json['nama'];
    batasUtang = json['batas_utang'];
  }
}

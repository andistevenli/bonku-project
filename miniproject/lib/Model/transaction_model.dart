class TransactionModel {
  int? id;
  String? createdAt;
  String? deskripsi;
  int? utang;
  int? idPelanggan;

  TransactionModel(
      {this.id, this.createdAt, this.deskripsi, this.utang, this.idPelanggan});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    deskripsi = json['deskripsi'];
    utang = json['utang'];
    idPelanggan = json['id_pelanggan'];
  }
}

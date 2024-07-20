class PesananItem {
  final String id;
  final String idPesanan;
  final String idProduk;
  final String jumlah;
  final String ukuran;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  PesananItem({
    required this.id,
    required this.idPesanan,
    required this.idProduk,
    required this.jumlah,
    required this.ukuran,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PesananItem.fromJson(Map<String, dynamic> json) {
    return PesananItem(
      id: json['id'],
      idPesanan: json['id_pesanan'],
      idProduk: json['id_produk'],
      jumlah: json['jumlah'],
      ukuran: json['ukuran'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pesanan': idPesanan,
      'id_produk': idProduk,
      'jumlah': jumlah,
      'ukuran': ukuran,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

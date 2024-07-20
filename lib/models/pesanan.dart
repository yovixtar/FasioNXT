class Pesanan {
  final String id;
  final String metodePembayaran;
  final String total;
  final String idPelanggan;
  final String status;
  final String catatan;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  Pesanan({
    required this.id,
    required this.metodePembayaran,
    required this.total,
    required this.idPelanggan,
    required this.status,
    required this.catatan,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    return Pesanan(
      id: json['id'],
      metodePembayaran: json['metode_pembayaran'],
      total: json['total'],
      idPelanggan: json['id_pengguna'],
      status: json['status'],
      catatan: json['catatan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'metode_pembayaran': metodePembayaran,
      'total': total,
      'id_pengguna': idPelanggan,
      'status': status,
      'catatan': catatan,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

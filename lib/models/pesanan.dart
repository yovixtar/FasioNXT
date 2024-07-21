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

class ProdukPesanan {
  String namaProduk;
  String gambar;
  String harga;
  String jumlah;
  String total;

  ProdukPesanan({
    required this.namaProduk,
    required this.gambar,
    required this.harga,
    required this.jumlah,
    required this.total,
  });

  factory ProdukPesanan.fromJson(Map<String, dynamic> json) {
    return ProdukPesanan(
      namaProduk: json['nama_produk'] as String,
      gambar: json['gambar'] as String,
      harga: json['harga'] as String,
      jumlah: json['jumlah'] as String,
      total: json['total'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_produk': namaProduk,
      'gambar': gambar,
      'harga': harga,
      'jumlah': jumlah,
      'total': total,
    };
  }
}

class DaftarPesanan {
  String namaPengguna;
  String idPesanan;
  String alamat;
  String status;
  String tanggal;
  String metodePembayaran;
  String total;
  String catatan;
  List<ProdukPesanan> items;

  DaftarPesanan({
    required this.namaPengguna,
    required this.idPesanan,
    required this.alamat,
    required this.status,
    required this.tanggal,
    required this.metodePembayaran,
    required this.total,
    required this.catatan,
    required this.items,
  });

  factory DaftarPesanan.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<ProdukPesanan> itemsList =
        list.map((i) => ProdukPesanan.fromJson(i)).toList();

    return DaftarPesanan(
      namaPengguna: json['nama_pengguna'] as String,
      idPesanan: json['id_pesanan'] as String,
      alamat: json['alamat'] as String,
      status: json['status'] as String,
      tanggal: json['tanggal'] as String,
      metodePembayaran: json['metode_pembayaran'] as String,
      total: json['total'] as String,
      catatan: json['catatan'] as String,
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_pengguna': namaPengguna,
      'id_pesanan': idPesanan,
      'alamat': alamat,
      'status': status,
      'tanggal': tanggal,
      'metode_pembayaran': metodePembayaran,
      'total': total,
      'catatan': catatan,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class Notifikasi {
  final String id;
  final String judul;
  final String deskripsi;
  final String id_pengguna;
  final String umum;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  Notifikasi({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.id_pengguna,
    required this.umum,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Notifikasi.fromJson(Map<String, dynamic> json) {
    return Notifikasi(
      id: json['id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      id_pengguna: json['id_pengguna'],
      umum: json['umum'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'id_pengguna': id_pengguna,
      'umum': umum,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

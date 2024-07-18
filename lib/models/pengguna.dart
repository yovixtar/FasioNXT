class Pengguna {
  final String id;
  final String username;
  final String nama;
  final String password;
  final String alamat;
  final String token;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  Pengguna({
    required this.id,
    required this.username,
    required this.nama,
    required this.password,
    required this.alamat,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      id: json['id'],
      username: json['username'],
      nama: json['nama'],
      password: json['password'],
      alamat: json['alamat'],
      token: json['token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'nama': nama,
      'password': password,
      'alamat': alamat,
      'token': token,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

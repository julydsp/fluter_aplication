class Pegawai {
  int? id;
  String nipPegawai;
  String namaPegawai;
  DateTime tanggallahirPegawai;
  String nomorteleponPegawai;
  String emailPegawai;
  String passwordPegawai;

  Pegawai({this.id,
  required this.nipPegawai,
  required this.namaPegawai,
  required this.tanggallahirPegawai,
  required this.nomorteleponPegawai,
  required this.emailPegawai,
  required this.passwordPegawai});

  factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
    id: json["id"],
    nipPegawai: json["nip"], 
    namaPegawai: json["nama"],
    tanggallahirPegawai: DateTime.parse(json["tanggal_lahir"]),
    nomorteleponPegawai: json["nomor_telepon"],
    emailPegawai: json["email"],
    passwordPegawai: json["password"],
    );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "nama": namaPegawai,
    "nip" : nipPegawai,
    "tanggal_lahir": tanggallahirPegawai.toIso8601String(),
    "nomor_telepopn" : nomorteleponPegawai,
    "email" : emailPegawai,
    "password" : passwordPegawai,
    };
}

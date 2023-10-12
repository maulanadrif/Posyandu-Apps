class Anak {
    String? idAnak;
    String? idUser;
    String? nik;
    String? namaLengkap;
    String? namaPanggilan;
    String? jenisKelamin;
    String? tglLahir;
    String? alamat;

    Anak({
        this.idAnak,
        this.idUser,
        this.nik,
        this.namaLengkap,
        this.namaPanggilan,
        this.jenisKelamin,
        this.tglLahir,
        this.alamat,
    });

    factory Anak.fromJson(Map<String, dynamic> json) => Anak(
        idAnak: json["id_anak"],
        idUser: json["id_user"],
        nik: json["nik"],
        namaLengkap: json["nama_lengkap"],
        namaPanggilan: json["nama_panggilan"],
        jenisKelamin: json["jenis_kelamin"],
        tglLahir: json["tgl_lahir"],
        alamat: json["alamat"],
    );

    Map<String, dynamic> toJson() => {
        "id_anak": idAnak,
        "id_user": idUser,
        "nik": nik,
        "nama_lengkap": namaLengkap,
        "nama_panggilan": namaPanggilan,
        "jenis_kelamin": jenisKelamin,
        "tgl_lahir": tglLahir,
        "alamat": alamat,
    };
}
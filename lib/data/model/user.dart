class User {
    String? idUser;
    String? nik;
    String? nama;
    String? alamat;
    String? password;
    String? role;

    User({
        this.idUser,
        this.nik,
        this.nama,
        this.alamat,
        this.password,
        this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        nik: json["nik"],
        nama: json["nama"],
        alamat: json["alamat"],
        password: json["password"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nik": nik,
        "nama": nama,
        "alamat": alamat,
        "password": password,
        "role": role,
    };
}
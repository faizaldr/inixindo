// deklarasi variable,
// defaultnya variable harus di-inisialisasi nilainya
import 'package:flutter/material.dart';

String nama = "inixindo";
int usia = 35;

// nullable variable, default nilainya adalah null. tersedia setelah fluter 2.3
String? admin;
var nomorTelepon;

// late (terlambat) menginisialisasi variabel
late int rating;

// diluar scope perintah tidak boleh menjalankan perintah apapun, termasuk meng-asign variable
// rating = 10;
main() {
  print(nama);
  print(usia);
  print(admin);
  nomorTelepon = 082231001560;
  print(nomorTelepon.runtimeType);
  nomorTelepon = "082231001560";
  print(nomorTelepon.runtimeType);
  print(nomorTelepon);

  rating = 5; // inisialisasi nilai late, sehingga tidak eror
  print(rating);

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("INIXINDO")),
        body: Text("Selamat Datang"),
      ),
    ),
  );

  RuanganKelas epic = new RuanganKelas("Epic");
  print(epic.jumlahMeja);
  print(epic.jumlahTV);

  RuanganKelas novela = new RuanganKelas("Novela", jumlahMeja: 4);
  print(novela.jumlahMeja);
  print(novela.jumlahTV);
  print(novela.namaRuangan);
}

class RuanganKelas {
  int? jumlahMeja;
  int? jumlahTV;
  String? namaRuangan;

  // constructor
  RuanganKelas(this.namaRuangan, {this.jumlahMeja=3, /* required */ this.jumlahTV = 1});
}
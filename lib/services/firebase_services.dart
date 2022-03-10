// ignore_for_file: camel_case_types, unused_local_variable, avoid_print, prefer_is_empty, avoid_function_literals_in_foreach_calls, prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Firebase_service {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  void addData(int nim, String nama, String foto, String fakultas,
      String jurusan, double ipk, String kelas, context) async {
    CollectionReference coba = firestore.collection('mahasiswa');
    int count = 0;

    try {
      await coba.add({
        'nim': nim,
        'nama': nama,
        'foto': foto,
        'fakultas': fakultas,
        'jurusan': jurusan,
        'ipk': ipk,
        'kelas': kelas
      });
      Alert(
        context: context,
        type: AlertType.success,
        title: "Success",
        desc: "Cieee Berhasil Nambah Dataaa...",
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.popUntil(context, (route) {
              return count++ == 2;
            }),
            width: 120,
          )
        ],
      ).show();
    } catch (e) {
      print('asdasdasdasdasdasda   $e');
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Terjadi Kesalahan",
        desc: "Ada Kesalahan Pokoknya Mah, Males Jelasinnya 'RIBET!!'. ",
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('mahasiswa');
    return data.snapshots();
  }

  Future<QuerySnapshot<Object?>> best() async{
    Future<QuerySnapshot<Map<String, dynamic>>> data = firestore.collection('mahasiswa').orderBy('ipk',descending: true).get();
    return await data;
  }

  Future<QuerySnapshot<Object?>> search() async{
    Future<QuerySnapshot<Map<String, dynamic>>> data = firestore.collection('mahasiswa').orderBy('ipk',descending: true).get();
    return await data;
  }

  void updateData(String docId, String namaPrd, int hargaPrd, context) async {
    DocumentReference coba = firestore.collection('Datas').doc(docId);
    int count = 0;
    try {
      await coba.update({'nama': namaPrd, 'harga': hargaPrd});
      Alert(
        context: context,
        type: AlertType.success,
        title: "Berhasil",
        desc: "Produk Berhasil Diubah Iyeyyy",
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.popUntil(context, (route) {
              return count++ == 2;
            }),
            width: 120,
          )
        ],
      ).show();
    } catch (e) {
      print('asdasdasdasdasdasda   $e');
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Terjadi Kesalahan",
        desc: "Ada Kesalahan Pokoknya Mah, Males Jelasinnya 'RIBET!!'. ",
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  void deleteData(String docId, context) async {
    DocumentReference coba = firestore.collection('Datas').doc(docId);
    int count = 0;
    try {
      await coba.delete();
      Alert(
        context: context,
        type: AlertType.success,
        title: "Berhasil",
        desc: "Produk Berhasil Diubah Iyeyyy",
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } catch (e) {
      print('asdasdasdasdasdasda   $e');
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Terjadi Kesalahan",
        desc: "Ada Kesalahan Pokoknya Mah, Males Jelasinnya 'RIBET!!'. ",
        buttons: [
          DialogButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  void filterData() async {
    final result = await firestore
        .collection('users')
        // .where('hobi', arrayContains: 'futsal')
        // .where('umur', isGreaterThan: 20)
        ///////
        // .orderBy('umur',descending: true)
        // .limitToLast(1)
        ///////

        .where('domisili', isEqualTo: 'bekasi')
        .where('umur', isLessThan: 20)
        .where('hobi', isEqualTo: 'basket')
        .get();
    // print(result.docs.length);
    if (result.docs.length > 0) {
      log('Data Yang Terfilter Ada : ${result.docs.length.toString()}');
      result.docs.forEach((element) {
        log('ID : ${element.id}');
        log('DATA : ${element.data()}');
      });
    } else
      log('Data Tidak Ada');
  }

  void getImage() async {
    // var gambar = storage.ref('donwload.jpg').getDownloadURL();
    // var gambar2 = storage.ref('tes/gambar.png').getDownloadURL();
    // print(gambar);

    // var myList = await storage.ref('').listAll();
    // // print(myList.items.length);
    // myList.prefixes.forEach((element) async {
    //   // var gambar = await storage.ref('tes/${element.name}').getDownloadURL();
    //   print('Nama : ${element.name}');
    //   // print('Url : ${gambar}');
    // });

    var myList = await storage.ref('tes').list(ListOptions(maxResults: 2));
    myList.items.forEach((element) async {
      var gambar = await storage.ref('tes/${element.name}').getDownloadURL();
      print('Nama : ${element.name}');
      print('Url : ${gambar}');
    });
  }

  void uploadMultiFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      result.files.forEach((element) async {
        File file = File(element.path!);
        String nama = element.name;
        try {
          await storage.ref('hehe/$nama').putFile(file);
          log('Berhasil Iyeyy Yg Multi Dongkls');
        } on FirebaseException catch (e) {
          // e.g, e.code == 'canceled'
          log(e.toString());
        }
      });
    } else {
      // User canceled the pickerog('Batal Milih Iyeyyy');
    }
  }
}

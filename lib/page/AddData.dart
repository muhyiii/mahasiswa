// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, file_names, unused_import, must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mahasiswa/services/firebase_services.dart';

class AddData extends StatefulWidget {
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController dataNIM = TextEditingController();
  TextEditingController dataNama = TextEditingController();
  TextEditingController dataFoto = TextEditingController();
  TextEditingController dataFakultas = TextEditingController();
  TextEditingController dataJurusan = TextEditingController();
  TextEditingController dataIPK = TextEditingController();
  TextEditingController dataKelas = TextEditingController();

  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String nama = result.files.first.name;
      try {
        await storage.ref('image/$nama').putFile(file);
        var dataImage = await storage.ref('image/$nama').getDownloadURL();
        log('Berhasil Iyeyy');
        log(dataImage);
        setState(() {
          dataFoto.text = dataImage;
        });
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        log(e.toString());
      }
    } else {
      log('Batal Milih Iyeyyy');
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: dataNIM,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'NIM',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: dataNama,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nama Mahasiswa',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                uploadFile();
              },
              child: const Text('Upload Data'),
            ),
            TextField(
              readOnly: true,
              controller: dataFoto,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'URL Foto',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: dataFakultas,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Fakultas',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: dataJurusan,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Jurusan',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: dataIPK,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'IPK',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: dataKelas,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Kelas',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center, fixedSize: Size(lebar, 45)),
                onPressed: () {
                  Firebase_service().addData(
                      int.parse(dataNIM.text),
                      dataNama.text,
                      dataFoto.text,
                      dataFakultas.text,
                      dataJurusan.text,
                      double.parse(dataIPK.text),
                      dataKelas.text,
                      context);
                },
                child: const Text('Send'))
          ],
        ),
      ),
    );
  }
}

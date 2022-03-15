// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, file_names, unused_import, must_be_immutable, override_on_non_overriding_member

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mahasiswa/services/firebase_services.dart';

class EditData extends StatefulWidget {
  @override
  final Map data;
  final String docId;
  const EditData({required this.data, required this.docId});
  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  FirebaseStorage storage = FirebaseStorage.instance;
  TextEditingController dataNIM = TextEditingController();
  TextEditingController dataNama = TextEditingController();
  TextEditingController dataFoto = TextEditingController();
  TextEditingController dataFakultas = TextEditingController();
  TextEditingController dataJurusan = TextEditingController();
  TextEditingController dataIPK = TextEditingController();
  TextEditingController dataKelas = TextEditingController();

  void deleteFile() async {
    setState(() {
      dataFoto.text = '';
    });
  }

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
  void initState() {
    dataNIM.text = widget.data['nim'].toString();
    dataNama.text = widget.data['nama'];
    dataFoto.text = widget.data['foto'];
    dataFakultas.text = widget.data['fakultas'];
    dataJurusan.text = widget.data['jurusan'];
    dataIPK.text = widget.data['ipk'].toString();
    dataKelas.text = widget.data['kelas'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data Mahasiswa',style: TextStyle(fontSize: 25,fontFamily: 'fredoka'),),
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
                hintText: 'Nama Mhasiswa',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Row(
            //   children: [
            ElevatedButton(
              onPressed: () {
                uploadFile();
              },
              child: const Text('Upload Data'),
            ),
            //      ElevatedButton(
            //       onPressed: () {
            //         deleteFile();
            //       },
            //       child: const Text('Clear URL Data'),
            //     ),
            //   ],
            // ),
            TextField(
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
                  Firebase_service().updateData(
                      int.parse(dataNIM.text),
                      dataNama.text,
                      dataFoto.text,
                      dataFakultas.text,
                      dataJurusan.text,
                      double.parse(dataIPK.text),
                      dataKelas.text,
                      context,
                      widget.docId);
                },
                child: const Text('Send'))
          ],
        ),
      ),
    );
  }
}

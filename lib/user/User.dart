// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, unnecessary_const, unused_import, unused_local_variable, avoid_unnecessary_containers

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/services/firebase_services.dart';
import 'package:mahasiswa/user/CardProfile.dart';
import 'package:mahasiswa/user/FITUR/Search.dart';
import 'package:mahasiswa/user/Fitur.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isSearching = false;
  TextEditingController cari = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.grey,
        centerTitle: true,
        title: !isSearching
            ? Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              )
            : Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cari,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'roboto_slab'),
                  decoration: const InputDecoration(
                      hintText: 'Pencarian...',
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Search(
                                  keyword: cari.text,
                                )));
                  },
                ),
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: const Icon(
                Icons.search,
                size: 28,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Data Mahasiswa',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'roboto_slab',
                      fontSize: 30)),
              StreamBuilder<QuerySnapshot<Object?>>(
                  stream: Firebase_service().streamData(),
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.active) {
                      var listAllData = snapshot.data!.docs;

                      log(listAllData.length.toString());
                    }
                    log(snapshot.data!.docs.length.toString());
                    return Text(
                        snapshot.data!.docs.length.toString() +
                            ' Data Tersedia',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'roboto_slab',
                            fontSize: 15,
                            color: Colors.blueGrey));
                  }),
              Container(
                child: Fitur(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mahasiswa Terbaik',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'roboto_slab',
                          fontSize: 30)),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Lihat Semua',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'roboto_slab',
                          )))
                ],
              ),
              SizedBox(height: tinggi, child: CardProfile())
            ],
          ),
        ),
      ),
    );
  }
}

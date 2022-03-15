// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_const, unused_local_variable

import 'dart:developer';
import "package:collection/collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/services/firebase_services.dart';
import 'package:mahasiswa/user/ByFitur/DJurusan.dart';

class Jurusan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.grey,
        centerTitle: true,
        title: Text(
          DateFormat.yMMMMd().format(DateTime.now()).toString(),
          style: const TextStyle(color: Colors.grey, fontSize: 20),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Jurusan Tersedia',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'roboto_slab',
                      fontSize: 30)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: tinggi,
                width: lebar,
                child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: Firebase_service().streamData(),
                    builder: (context, snapshot) {
                      print(snapshot.connectionState);
                      if (snapshot.connectionState == ConnectionState.active) {
                        var listAllData = snapshot.data!.docs;
                        // var filter = listAllData.where((element) => false);
                        var dataa = listAllData
                            .groupListsBy((element) => element['jurusan'])
                            .values
                            .toList();
                        print(dataa[0][0]["jurusan"]);
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataa.length,
                            itemBuilder: (context, index) {
                              log(listAllData[index].data().toString());
                              // Object coba = listAllData[index].data();
                              // log('adasdasdasd' + coba.toString());
                              Map<String, dynamic> data = listAllData[index]
                                  .data()! as Map<String, dynamic>;
                              // var newMap =
                              //     groupBy(data, (obj) => obj['jurusan'])
                              //         .map((k, v) => MapEntry(
                              //             k,
                              //             v.map((item) {
                              //               item.remove('jurusan');
                              //               return item;
                              //             }).toList()));

                              return InkWell(
                                onTap: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DJurusan(
                                            dataJurusan: dataa[index][0]
                                                ['jurusan'])))),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  height: tinggi * 0.15,
                                  width: lebar * 0.4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.greenAccent.shade100,
                                            Colors.green.shade400
                                          ]),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.green,
                                          offset: Offset(
                                            2.0,
                                            6.75,
                                          ),
                                          blurRadius: 4.0,
                                        ),
                                      ]),
                                  child: Text(
                                    dataa[index][0]['jurusan'],
                                    style: const TextStyle(
                                        fontSize: 42,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'fredoka',
                                        shadows: [
                                          Shadow(
                                              color: Colors.black54,
                                              offset: const Offset(3, 5),
                                              blurRadius: 2),
                                        ]),
                                  ),
                                ),
                              );
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

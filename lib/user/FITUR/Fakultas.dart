// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, avoid_print, unnecessary_const, unused_local_variable
import "package:collection/collection.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/services/firebase_services.dart';

import '../ByFitur/DFakultas.dart';

class Fakultas extends StatelessWidget {
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
              const Text('Fakultas Tersedia',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'roboto_slab',
                      fontSize: 30)),
              SizedBox(
                height: 10,
              ),
              Container(
                height: tinggi,
                width: lebar,
                child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: Firebase_service().streamData(),
                    builder: (context, snapshot) {
                      print(snapshot.connectionState);
                      if (snapshot.connectionState == ConnectionState.active) {
                        var listAllData = snapshot.data!.docs;

                        var dataa = listAllData
                            .groupListsBy((element) => element['fakultas'])
                            .values
                            .toList();
                        print(dataa[0][0]["fakultas"]);
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dataa.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = listAllData[index]
                                  .data()! as Map<String, dynamic>;

                              // if (data['ipk'] >= 3) {}

                              return InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DFakultas(
                                                dataFakultas: dataa[index][0]
                                                    ['fakultas'],
                                              )));
                                }),
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
                                            Colors.blueAccent.shade100,
                                            Colors.blue.shade400
                                          ]),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.blue,
                                          offset: Offset(
                                            2.0,
                                            6.75,
                                          ),
                                          blurRadius: 4.0,
                                        ),
                                      ]),
                                  child: Text(
                                    dataa[index][0]['fakultas'],
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

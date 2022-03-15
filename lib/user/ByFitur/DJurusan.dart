// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, override_on_non_overriding_member, prefer_const_constructors_in_immutables, annotate_overrides, prefer_const_constructors, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/services/firebase_services.dart';

class DJurusan extends StatefulWidget {
  @override
  final String dataJurusan;
  DJurusan({required this.dataJurusan});
  State<DJurusan> createState() => _DJurusanState();
}

class _DJurusanState extends State<DJurusan> {
  Future<QuerySnapshot<Object?>> dJurusan() async {
    Future<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
        .instance
        .collection('mahasiswa')
        .where('jurusan', isEqualTo: widget.dataJurusan)
        .get();
    return await data;
  }

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
      body: Container(
        // ignore: prefer_const_constructors
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jurusan ' + widget.dataJurusan,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'roboto_slab',
                    fontSize: 30)),
            SizedBox(
              height: tinggi * 0.8,
              width: lebar,
              child: FutureBuilder<QuerySnapshot<Object?>>(
                  future: dJurusan(),
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.done) {
                      var listAllData = snapshot.data!.docs;
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listAllData.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = listAllData[index]
                                .data()! as Map<String, dynamic>;

                            // if (data['ipk'] >= 3) {}

                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey.shade200,
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(
                                          0.0,
                                          0.9,
                                        ),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        minRadius: 50,
                                        maxRadius: 60,
                                        foregroundImage:
                                            NetworkImage(data["foto"]),
                                        backgroundColor: Colors.blueGrey,
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              data['nama'].toUpperCase(),
                                              style: const TextStyle(
                                                  fontFamily: 'fredoka',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              data['nim'].toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'fredoka',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueGrey),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Kelas : ' + data['kelas'],
                                                    style: const TextStyle(
                                                        fontFamily: 'fredoka',
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12)),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                    'IPK : ' +
                                                        data['ipk'].toString(),
                                                    style: const TextStyle(
                                                        fontFamily: 'fredoka',
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.blueAccent,
                                                      boxShadow: [
                                                        const BoxShadow(
                                                          color: Colors.black,
                                                          offset: Offset(
                                                            0.0,
                                                            0.5,
                                                          ),
                                                          blurRadius: 1.0,
                                                        ),
                                                      ],
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.blueAccent
                                                                .shade100,
                                                            Colors.blue.shade400
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    data['fakultas'],
                                                    style: const TextStyle(
                                                        fontFamily: 'fredoka',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        const BoxShadow(
                                                          color: Colors.black,
                                                          offset: Offset(
                                                            0.0,
                                                            0.5,
                                                          ),
                                                          blurRadius: 1.0,
                                                        ),
                                                      ],
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.greenAccent
                                                                .shade100,
                                                            Colors
                                                                .green.shade400
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    data['jurusan'],
                                                    style: const TextStyle(
                                                        fontFamily: 'fredoka',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
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
    );
  }
}

// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/services/firebase_services.dart';
import "package:collection/collection.dart";

class Search extends StatefulWidget {
  final String keyword;
  Search({required this.keyword});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot<Object?>> search() async {
    Future<QuerySnapshot<Map<String, dynamic>>> data =
        FirebaseFirestore.instance
            .collection('mahasiswa')
            .where('nama', isEqualTo: widget.keyword.toString())
            .where('nim', isEqualTo: widget.keyword.toString())
            //         .toUpperCase()
            //         .contains(widget.keyword.toLowerCase()))
            // .where('nama', isLessThanOrEqualTo: widget.keyword)
            // .where('nama', is: widget.keyword)
            // .where('ipk', isLessThanOrEqualTo: widget.keyword)
            .get();
    // var filter = listAllData.where((element) => false);

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Menampilkan..',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'roboto_slab',
                      fontSize: 30)),
              Container(
                height: tinggi,
                width: lebar,
                child: FutureBuilder<QuerySnapshot<Object?>>(
                    future: search(),
                    builder: (context, snapshot) {
                      print(snapshot.connectionState);
                      if (snapshot.connectionState == ConnectionState.done) {
                        var listAllData = snapshot.data!.docs;

                        // var filter = listAllData.where((element) => false);
                        // var dataa = listAllData
                        //     .groupListsBy((element) => element['nama'])
                        //     .values
                        //     .first;

                        //                 udah = udahRest
                        // .where((element) =>
                        //     element.name
                        //         .toLowerCase()
                        //         .contains(widget.keyword.toLowerCase()) ||
                        //     element.brand
                        //         .toLowerCase()
                        //         .contains(widget.keyword.toLowerCase()))
                        // .toList();
                        // var dataa = listAllData
                        //     .where((element) => element['nama'])
                        //     .toList();
                        // print('adsadddddddd');
                        // print(dataa);

                        // print(dataa);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                      'Kelas : ' +
                                                          data['kelas'],
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
                                                          data['ipk']
                                                              .toString(),
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
                                                        color: Colors.redAccent,
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
                                                              Colors.redAccent
                                                                  .shade100,
                                                              Colors
                                                                  .red.shade400
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
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
                                                              Colors
                                                                  .purpleAccent
                                                                  .shade100,
                                                              Colors.purple
                                                                  .shade400
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
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
                      } else {
                        return const Center(
                          child: Text('Data Tidak Ditemukan'),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

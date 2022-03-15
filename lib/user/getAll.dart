// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/services/firebase_services.dart';
import 'package:mahasiswa/user/FITUR/Search.dart';

class Mahasiswa extends StatefulWidget {  @override
  State<Mahasiswa> createState() => _MahasiswaState();
}

class _MahasiswaState extends State<Mahasiswa> {
TextEditingController cari = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   foregroundColor: Colors.grey,
      //   centerTitle: true,
      //   title: Text(
      //     DateFormat.yMMMMd().format(DateTime.now()).toString(),
      //     style: const TextStyle(color: Colors.grey, fontSize: 20),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Data Mahasiswa',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'roboto_slab',
                    fontSize: 30)),
            Container(
              height: tinggi * 0.85,
              width: lebar,
              child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: Firebase_service().streamData(),
                  builder: (context, snapshot) {
                    print(snapshot.connectionState);
                    if (snapshot.connectionState == ConnectionState.active) {
                      var listAllData = snapshot.data!.docs;
                      return ListView.builder(
                          itemCount: listAllData.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = listAllData[index]
                                .data()! as Map<String, dynamic>;

                            // if (data['ipk'] >= 3) {}

                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.green,
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
                                  height: 270,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 35,
                                          left: 25, //menit 9:18 liat lagii!!
                                          child: Material(
                                            child: Container(
                                              height: 220.0,
                                              width: lebar * 0.9,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(
                                                      0.0,
                                                      0.9,
                                                    ),
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                      Positioned(
                                          top: 70,
                                          left: 28,
                                          child: Card(
                                              shadowColor:
                                                  Colors.grey.withOpacity(0.5),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                height: 140,
                                                width: 180,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          data['foto']),
                                                    )),
                                              ))),
                                      Positioned(
                                          top: 70,
                                          left: 220,
                                          child: Container(
                                            height: 170,
                                            width: 160,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['nama'],
                                                  style: TextStyle(
                                                      fontFamily: 'fredoka',
                                                      fontSize: 20,
                                                      color: Color(0xFF363f93),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  data['nim'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'fredoka',
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Divider(
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  data['fakultas'],
                                                  style: TextStyle(
                                                      fontFamily: 'fredoka',
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  data['jurusan'],
                                                  style: TextStyle(
                                                      fontFamily: 'fredoka',
                                                      fontSize: 19,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Divider(
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Kelas : ' +
                                                            data['kelas'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'fredoka',
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
                                                            fontFamily:
                                                                'fredoka',
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
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
    );
  }
}
  // Container(
                            //   height: 130,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.only(
                            //       bottomRight: Radius.circular(50),
                            //     ),
                            //     color: Color(0xFF363f93),
                            //   ),
                            //   child: Stack(
                            //     children: [
                            //       Positioned(
                            //           top: 26,
                            //           left: 0,
                            //           child: Container(
                            //             height: 100,
                            //             width: 300,
                            //             decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.only(
                            //                   topRight: Radius.circular(50),
                            //                   bottomRight: Radius.circular(50),
                            //                 )),
                            //           )),
                            //       // Positioned(
                            //       //     top: 70,
                            //       //     left: 20,
                            //       //     child: Text(
                            //       //       "Mahasiswa",
                            //       //       style: TextStyle(
                            //       //           fontSize: 20,
                            //       //           color: Color(0xFF363f93)),
                            //       //     ))
                            //     ],
                            //   ),
                            // ),
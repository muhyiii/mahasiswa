// ignore_for_file: file_names, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, duplicate_ignore, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiturIPK extends StatefulWidget {
  @override
  State<FiturIPK> createState() => _FiturIPKState();
}

class _FiturIPKState extends State<FiturIPK> {
  TextEditingController minValue = TextEditingController();
  TextEditingController maxValue = TextEditingController();
  bool isDesc = false;
  Future<QuerySnapshot<Object?>> byIpk() async {
    Future<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
        .instance
        .collection('mahasiswa')
        .orderBy('ipk', descending: isDesc)
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
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: lebar,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(50)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orangeAccent.shade100,
                        Colors.orange.shade400
                      ]),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.orange,
                      offset: Offset(
                        0.0,
                        4.75,
                      ),
                      blurRadius: 4.0,
                    ),
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filter Data Berdasarkan IPK',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'roboto_slab',
                          fontSize: 30)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: TextField(
                          style: TextStyle(
                              height: 0.75,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.black,
                              fontFamily: 'roboto_slab'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                             
                            ),
                            
                            hintText: 'Min',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                        child: TextField(
                          style: TextStyle(
                              height: 0.75,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.black,
                              fontFamily: 'roboto_slab'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Max',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              isDesc = !isDesc;
                            });
                          },
                          icon: Icon(
                            isDesc
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 40,
                          )))
                ],
              ),
            ),
            Container(
              height: tinggi,
              child: FutureBuilder<QuerySnapshot<Object?>>(
                  future: byIpk(),
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
                                                            Colors.red.shade400
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
                                                            Colors.purpleAccent
                                                                .shade100,
                                                            Colors
                                                                .purple.shade400
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
            )
          ],
        ),
      )),
    );
  }
}

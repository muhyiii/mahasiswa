// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mahasiswa/services/firebase_services.dart';

class CardProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Object?>>(
          future: Firebase_service().best(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.done) {
              var listAllData = snapshot.data!.docs;
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        listAllData[index].data()! as Map<String, dynamic>;
                  
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                minRadius: 50,
                                maxRadius: 60,
                                foregroundImage: NetworkImage(data["foto"]),
                                backgroundColor: Colors.blueGrey,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('IPK : ' + data['ipk'].toString(),
                                            style: const TextStyle(
                                                fontFamily: 'fredoka',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
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
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.redAccent.shade100,
                                                    Colors.red.shade400
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            data['fakultas'],
                                            style: const TextStyle(
                                                fontFamily: 'fredoka',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 5),
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
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors
                                                        .purpleAccent.shade100,
                                                    Colors.purple.shade400
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            data['jurusan'],
                                            style: const TextStyle(
                                                fontFamily: 'fredoka',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
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
    );
  }
}
// return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         width: lebar * 0.3,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Container(
//                             width: lebar,
//                             height: tinggi * 0.5,
//                             decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(40),
//                                     bottomRight: Radius.circular(30)),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.bottomCenter,
//                                   end: Alignment.topRight,
//                                   colors: [
//                                     Colors.blueAccent,
//                                     Colors.cyanAccent,
//                                   ],
//                                 )),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                     child: Container(
//                                         alignment: Alignment.centerLeft,
//                                         padding: const EdgeInsets.only(
//                                             left: 20, top: 20),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               data['nama'].toUpperCase(),
//                                               style: const TextStyle(fontFamily: 'fredoka',
//                                                   fontSize: 30,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             Text(
//                                               data['nim'].toString(),
//                                               style: const TextStyle(fontFamily: 'fredoka',
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.white60),
//                                             ),
//                                           ],
//                                         ))),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         child: CircleAvatar(
//                                           minRadius: 90,
//                                           maxRadius: 120,
//                                           foregroundImage:
//                                               NetworkImage(data['foto']),
//                                           backgroundColor: Colors.blueGrey,
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: [
//                                           Text(
//                                             'Fakultas  :  ' + data['fakultas'],
//                                             style: const TextStyle(fontFamily: 'fredoka',
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 20),
//                                           ),
//                                           Text(
//                                               'Jurusan  :  ' +
//                                                   data['jurusan'].toString(),
//                                               style: const TextStyle(fontFamily: 'fredoka',
//                                                   color: Colors.grey,
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 20))
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                     child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         const BoxShadow(
//                                           color: Colors.black26,
//                                           offset: Offset(
//                                             5.0,
//                                             5.0,
//                                           ),
//                                           blurRadius: 10.0,
//                                           spreadRadius: 2.0,
//                                         ), //BoxS
//                                       ]),
//                                   margin: const EdgeInsets.all(20),
//                                   alignment: Alignment.center,
//                                   width: lebar * 0.8,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Text('Kelas  :  ' + data['kelas'],
//                                           style: const TextStyle(fontFamily: 'fredoka',
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 20)),
//                                       Text('IPK  :  ' + data['ipk'].toString(),
//                                           style: const TextStyle(fontFamily: 'fredoka',
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 20))
//                                     ],
//                                   ),
//                                 )),
//                               ],
//                             )),
//                       ),
//                     );
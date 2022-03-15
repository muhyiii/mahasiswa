// ignore_for_file: use_key_in_widget_constructors, avoid_print, unnecessary_const, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mahasiswa/page/AddData.dart';
import 'package:mahasiswa/page/EditData.dart';

import 'package:mahasiswa/services/firebase_services.dart';
import 'package:mahasiswa/splash.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white, foregroundColor: Colors.black)),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                child: const Text(
              "`UniveApp",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'fredoka',
                  fontWeight: FontWeight.w600),
            )),
            Flexible(
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
            )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: Firebase_service().streamData(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.active) {
              var listAllData = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: listAllData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        listAllData[index].data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(onDoubleTap: (() {
                        Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Hapus Data",
                              desc: "Anda Yakinn Haa? Mau Hapus Data Berikut ",
                              buttons: [
                                DialogButton(
                                  child: const Text(
                                    "Gak Jadi ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                  color: Colors.red,
                                ),
                                DialogButton(
                                  child: const Text(
                                    "Jadi Dong",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Firebase_service().deleteData(
                                        listAllData[index].id, context);
                                  },
                                  width: 120,
                                  color: Colors.blue,
                                )
                              ],
                            ).show();
                      }),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => EditData(
                                    data: data,
                                    docId: listAllData[index].id)))),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.shade200,
                              boxShadow: const [
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
                                Column(
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
                                              color: Colors.blueAccent,
                                              boxShadow: const [
                                                BoxShadow(
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
                                                    Colors.blueAccent.shade100,
                                                    Colors.blue.shade400
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
                                              boxShadow: const [
                                                BoxShadow(
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
                                                    Colors.greenAccent.shade100,
                                                    Colors.green.shade400
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
                             
                              ],
                            )),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
      ),
    );
  }
}

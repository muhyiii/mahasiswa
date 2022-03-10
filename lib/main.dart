// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mahasiswa/page/AddData.dart';
import 'package:mahasiswa/page/EditData.dart';
import 'package:mahasiswa/services/firebase_services.dart';
import 'package:mahasiswa/user/User.dart';

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
      theme: ThemeData(primarySwatch: Colors.grey, appBarTheme: const AppBarTheme()),
      home: MyHomePage(),
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
        title: const Text('Mahasiswa'),
        leading: IconButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserPage())),
            icon: const Icon(Icons.account_balance)),
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
                    return ListTile(
                      leading: Image.network(data['foto']),
                      title: Text(data['nim'].toString()),
                      subtitle: Text(data['fakultas']),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditData(data: data, docId: listAllData[index].id),
                      )),
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

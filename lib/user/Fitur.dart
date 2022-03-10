// ignore_for_file: file_names, use_key_in_widget_constructors, sized_box_for_whitespace, unnecessary_const, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:mahasiswa/user/FITUR/ByIPK.dart';
import 'package:mahasiswa/user/FITUR/Fakultas.dart';

class Fitur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;

    return Container(
        height: tinggi * 0.28,
        child: ListView(scrollDirection: Axis.horizontal, children: [
          InkWell(
            onTap: (() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FiturIPK()));
            }),
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 95),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Urutkan',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'fredoka')),
                      ),
                      Container(
                        transform: Matrix4.identity()..rotateZ(-20 * 1 / 180),
                        child: const Text(
                          'IPK',
                          // ignore: unnecessary_const
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
                    ])),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fakultas()));
            },
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                          0.0,
                          4.75,
                        ),
                        blurRadius: 4.0,
                      ),
                    ]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 95),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('Urutkan',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'fredoka')),
                      ),
                      Container(
                        transform: Matrix4.identity()..rotateZ(-20 * 1 / 180),
                        child: const Text(
                          'Fakultas',
                          // ignore: unnecessary_const
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
                    ])),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                        0.0,
                        4.75,
                      ),
                      blurRadius: 4.0,
                    ),
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 95),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text('Urutkan',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'fredoka')),
                    ),
                    Container(
                      transform: Matrix4.identity()..rotateZ(-20 * 1 / 180),
                      child: const Text(
                        'Jurusan',
                        // ignore: unnecessary_const
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
                  ])),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              height: tinggi * 0.15,
              width: lebar * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.redAccent.shade100, Colors.red.shade400]),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.red,
                      offset: Offset(
                        0.0,
                        4.75,
                      ),
                      blurRadius: 4.0,
                    ),
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 95),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text('Urutkan',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'fredoka')),
                    ),
                    Container(
                      transform: Matrix4.identity()..rotateZ(-20 * 1 / 180),
                      child: const Text(
                        'Kelas',
                        // ignore: unnecessary_const
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
                  ]))
        ]));
  }
}

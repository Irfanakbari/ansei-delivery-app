import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hpm_outgoing_app/main.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import 'scan.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = const FlutterSecureStorage();
  final dio = Dio();
  final TextEditingController _controllerIp = TextEditingController();

  Future<void> _logout() async {
    try {
      await keycloakWrapper.logout();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Logout Gagal",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerIp.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () => Get.to(const Scan()),
                  child: Container(
                    width: Get.width,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.scanner, // Ganti dengan ikon yang diinginkan
                            color: Colors.white,
                            size: 24.0,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Scan',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
              ]),
              Column(children: [
                ElevatedButton(
                  onPressed: () => Dialogs.materialDialog(
                      msg: 'Apa Kamu Yakin Ingin Logout dari Akun?',
                      title: "Keluar",
                      color: Colors.white,
                      context: context,
                      actions: [
                        IconsOutlineButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'Batal',
                          iconData: Icons.cancel_outlined,
                          textStyle: const TextStyle(color: Colors.grey),
                          iconColor: Colors.grey,
                        ),
                        IconsButton(
                          onPressed: () {
                            _logout();
                          },
                          text: 'Ya',
                          iconData: Icons.logout,
                          color: Colors.red,
                          textStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                        ),
                      ]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna tombol 'Scanner Masuk'
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .logout, // Ganti dengan ikon logout yang diinginkan
                        size: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8), // Jarak antara ikon dan teks
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Get.to(const IpChange());
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blueAccent, // Warna tombol 'Ganti IP Server'
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 30, vertical: 10),
                //   ),
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.settings, // Ganti dengan ikon Settings
                //         size: 20.0,
                //         color: Colors.white,
                //       ),
                //       SizedBox(width: 8), // Jarak antara ikon dan teks
                //       Text(
                //         'IP Setting',
                //         style: TextStyle(fontSize: 15.0, color: Colors.white),
                //       ),
                //     ],
                //   ),
                // ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

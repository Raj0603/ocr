import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flut_orca/Screen/recognization_page.dart';
import 'package:flut_orca/Utils/image_cropper_page.dart';
import 'package:flut_orca/Utils/image_picker_class.dart';
import 'package:flut_orca/Widgets/modal_dialog.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR',
      theme: ThemeData(
        // colorSchemeSeed: Color.fromARGB(255, 255, 240, 24),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
          duration: 3000,
          // splash: Icons.search_sharp,
          splash: 'assets/images/giphy.gif',
          nextScreen: const FabExample(title: 'Welcome to OCR'),
          splashTransition: SplashTransition.fadeTransition,
          //pageTransitionType: PageTransitionType.scale,
          backgroundColor: Colors.indigo,)
    );
  }
}

class FabExample extends StatelessWidget {
  const FabExample({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/logo1.png',
                fit: BoxFit.fill, height: 110 , width: 140,),
          ]),

          surfaceTintColor: Colors.cyan,
          backgroundColor:  Colors.indigo,
          foregroundColor: Colors.amberAccent,
          shadowColor: Colors.indigo
          ,
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.contain,
                alignment: Alignment.center),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[],
                ),

                const Text(
                  "WELCOME TO OCR\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Color.fromARGB(255, 53, 108, 136)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
                    // Text(
                    //   "Click the button to proceed \n\n\n",
                    //   textAlign: TextAlign.right,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 25,
                    //       color: Color.fromARGB(255, 159, 76, 9)),
                    // ),
                  ],
                ),

                // Main button for scanning
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // const Text('Extended'),
                    const SizedBox(width: 16),
                    //
                    FloatingActionButton.extended(
                      onPressed: () {
                        imagePickerModal(context, onCameraTap: () {
                          log("Camera");
                          pickImage(source: ImageSource.camera).then((value) {
                            if (value != '') {
                              imageCropperView(value, context).then((value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          });
                        }, onGalleryTap: () {
                          log("Gallery");
                          pickImage(source: ImageSource.gallery).then((value) {
                            if (value != '') {
                              imageCropperView(value, context).then((value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          });
                        });
                      },
                      tooltip: 'Select Either Option',
                      label: const Text('Scan Something'),
                      icon: const Icon(Icons.scanner_rounded),
                      splashColor: const Color.fromARGB(255, 25, 177, 207),
                      focusColor: Colors.lightBlue,
                      hoverColor: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

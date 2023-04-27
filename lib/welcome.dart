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
        primarySwatch: Colors.deepOrange,
      ),
      home: AnimatedSplashScreen(
            duration: 3000,
            splash: Icons.search_sharp,
            nextScreen: FabExample(title: 'Welcome to OCR'),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.blue),
      
      
    );
  }
}

class FabExample extends StatelessWidget {
  const FabExample({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Recognizer'),
        surfaceTintColor: Colors.cyan,
        backgroundColor: Color.fromARGB(166, 191, 7, 7),
        foregroundColor: Colors.amberAccent,
        shadowColor: Colors.grey,
      ),
        
      body:
     
      Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/search2.png"),
            fit: BoxFit.cover,
            scale: 12,
          ),
        ),
               ),
             
              ],
            ),
 
                             Text(
                  "Scan through your Camera \n",
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
               ),
            Row(
    
              mainAxisAlignment: MainAxisAlignment.center,
           
              children: 
              
              <Widget>[   
 
                 
                Text(
                  "Or \n\n\n",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
               ),
                 
                      Text(
                        "Upload a sample from gallery",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                                                      
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ],
                    ),
       
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[],
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
                  splashColor: Color.fromARGB(255, 25, 177, 207),
                  focusColor: Colors.lightBlue,
                  hoverColor: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      
      ),
    );
  }
}

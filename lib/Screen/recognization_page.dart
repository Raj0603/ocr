import 'dart:developer';
import 'package:flut_orca/Screen/speech.dart';
import 'package:flutter/services.dart'
show Clipboard, ClipboardData, rootBundle;
import 'package:flut_orca/Screen/TranslateScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:translatable_text_field/translatable_text.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("recognized page"),
        surfaceTintColor: Colors.cyan,
        backgroundColor: const Color.fromARGB(166, 191, 7, 7),
        foregroundColor: Colors.amberAccent,
        shadowColor: Colors.grey,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            
            //Clipboard.setData(ClipboardData(text: string));

          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => TransPage(),
              ));
        },
        tooltip: 'For Speech & Translation',
        label: const Text('Perform actions'),
        icon: const Icon(Icons.translate_sharp),
        focusColor: Color.fromARGB(255, 243, 126, 0),
        hoverColor: Color.fromARGB(255, 255, 231, 50),
        backgroundColor: Color.fromARGB(255, 121, 231, 253),
      ),
      // body:  Row(
      //    children: <Widget>[

      //     const Center(
      //   child: CircularProgressIndicator(),
      // ),
      //   Container(
      //   padding: const EdgeInsets.all(20),
      //   child:
      //     TextFormField(
      //     maxLines: MediaQuery.of(context).size.height.toInt(),
      //     controller: controller,
      //     decoration:
      //         const InputDecoration(hintText: "Text goes here..."),
      //   ),

      // ),
      //      FloatingActionButton(
      //     onPressed: ()
      //   {
      //     Navigator.push(context,
      //     CupertinoPageRoute(builder: (_) =>
      //     TranslateScreen(
      //     )
      //     )
      //     );
      //   },
      //   tooltip: 'For translation & voice output',
      //  // label: const Text('Hear this out'),
      //  // Icon: const Icon(Icons.voice_chat_rounded),
      //   focusColor: const Color.fromARGB(255, 10, 58, 97),
      //   hoverColor: Colors.deepPurple,

      //   ),
      //    ],
      // ),

      body: _isBusy == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                maxLines: MediaQuery.of(context).size.height.toInt(),
                controller: controller,
                decoration:
                    const InputDecoration(hintText: "Text goes here..."),
              ),
            ),
    );
  }
  
  var string;
  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller.text = recognizedText.text;
    string = recognizedText.text;

    ///End busy state
    setState(() {
      _isBusy = false;
    });

    void copycat() {
      Clipboard.setData(ClipboardData(text: string));
    }
  }
}

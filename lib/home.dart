import 'dart:io';

import 'package:camera_app/dbapp.dart';
import 'package:camera_app/fullprieview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late List<String> _imagePaths = [];
  @override
  void initState() {
    super.initState();
    // Hivehelper.openImageBox();
    // Hivehelper.imagePathsStream(); // Call here
    _loadImagePaths();
  }
  Future<void> _loadImagePaths() async {
    await Hivehelper.openImageBox();
    setState(() {
      _imagePaths = Hivehelper.imagePathsStream();
    });
  }

  // final data = Hivehelper.imagePathsStream();
  // XFile? _imageFile;
  Future<void> _getImageCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        // _imageFile = XFile(pickedFile.path);
        _imagePaths.add(pickedFile.path);
        // Hivehelper.imageSave(_imageFile!.path);
        Hivehelper.imageSave(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff8fd1cd),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Camera App',
              style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                      fontSize: 25,
                      color: Color(0xff42424a),
                      fontWeight: FontWeight.w600)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xfff5e6dc),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: const Color(0xffddcfc6).withOpacity(0.9),
                  onTap: () {
                    _getImageCamera();
                  },
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.camera_alt,
                        color: Color(0xFF63CBC4),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Take a Picture',
              style: GoogleFonts.kalam(
                  textStyle:
                      const TextStyle(fontSize: 20, color: Color(0xff42434b))),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 40, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xfff5e6dc),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return RawMaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullImage(
                                imagePath: _imagePaths[index],
                                onDelete: (int index) async {
                                  Hivehelper.deleteImage(index);
                                },
                                index: index,
                              ),
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: FileImage(File(_imagePaths[index])),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount:_imagePaths.length,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 20,
                    child: Text(
                      'Gallery',
                      style: GoogleFonts.rubik(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff42434b),
                            fontWeight: FontWeight.bold),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

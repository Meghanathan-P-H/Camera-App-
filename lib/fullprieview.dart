// ignore_for_file: use_super_parameters, use_build_context_synchronously

import 'dart:io';
import 'package:camera_app/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FullImage extends StatelessWidget {
  final String imagePath;
  final Function(int) onDelete;
  final int index;
  const FullImage({Key? key, required this.imagePath, required this.onDelete,required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IMAGE',
          style: GoogleFonts.kanit(
              textStyle: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF000000))),
        ),
        backgroundColor:const Color(0xFF68c7c1),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Are You Sure You Want To Delete ?',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          )),
                      ElevatedButton.icon(
                          onPressed: () async {
                            await onDelete(index);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const MyHome()));
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your image deleted successfully'),
                          ),
                        );
                          },
                          icon: const Icon(Icons.delete_sweep_sharp),
                          label: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

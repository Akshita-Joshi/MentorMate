import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/chat/firebase.dart';
import 'package:mentor_mate/components/bottom_drawer.dart';
import 'package:mentor_mate/components/popup.dart';
import 'package:mentor_mate/models/models.dart';
import 'globals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
//this file has the chat screen 
class AddImage extends StatefulWidget {

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
   bool uploading = false;
  double val = 0;
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  List<File> _image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
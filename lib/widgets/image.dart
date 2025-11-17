import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget({super.key, required this.saveImage});

  Function(File) saveImage;

  @override
  State<ImageWidget> createState() {
    return _ImageWidgetState();
  }
}

class _ImageWidgetState extends State<ImageWidget> {
  File? _selectedImage;
  void _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 50,
      maxWidth: 150,
      imageQuality: 50,
    );

    if (photo == null) {
      return;
    }
    setState(() {
      _selectedImage = File(photo!.path);
    });

    widget.saveImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectImage();
      },
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  _selectedImage != null ? FileImage(_selectedImage!) : null,
              child:
                  _selectedImage == null
                      ? const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.black54,
                      )
                      : null,
            ),
          ),
          Text("Add Image"),
        ],
      ),
    );
  }
}

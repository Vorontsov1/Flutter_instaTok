import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instatok/src/extensions/context_extension.dart';
import 'package:instatok/src/components/textfield.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late TextEditingController _controller;
  String? tempoImg;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                  width: 200,
                  child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: GestureDetector(
                          onTap: () async {
                            // Access pictures
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery, imageQuality: 80);

                            if (image != null) {
                              CroppedFile? croppedFile = await ImageCropper()
                                  .cropImage(
                                      sourcePath: image.path,
                                      aspectRatio: CropAspectRatio(
                                          ratioX: 9, ratioY: 16));

                              if (croppedFile != null) {
                                setState(() {
                                  tempoImg = croppedFile.path;
                                });
                              }
                            }
                          },
                          child: tempoImg != null 
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(File(tempoImg!))
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: context.onPrimary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                  child: Icon(
                                CupertinoIcons.add_circled,
                                size: 50,
                                color: context.outline,
                              )))))),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: _controller,
                hintText: 'Enter Desription',
                obscureText: false,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

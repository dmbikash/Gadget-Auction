import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';



class Product_image_picker extends StatefulWidget {
  final void Function(File pickedImage) getImageValue;
  Product_image_picker(this.getImageValue);

  @override
  _Product_image_pickerState createState() => _Product_image_pickerState();
}

class _Product_image_pickerState extends State<Product_image_picker> {
   var pickedImage;


  pickImage(ImageSource imageType) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final photo = await _picker.pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        this.pickedImage = tempImage;
        widget.getImageValue(pickedImage!);
      });
      //widget.getImageValue(pickedImage!);
      Get.back();
    } catch (error) {
      print(error);
    }
  }







  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 100,
          child:  pickedImage != null
              ? Image.file(
            pickedImage!,
            fit: BoxFit.cover,
          )
              : Image.network(
            'https://static.thenounproject.com/png/2413564-200.png',
            fit: BoxFit.cover,
          ),
        ),
        ElevatedButton.icon(
          onPressed:()
          {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  color: Colors.white,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Pic Image From",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            pickImage(ImageSource.camera);
                          },
                          icon: Icon(Icons.camera),
                          label: Text("Camera"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          icon: Icon(Icons.image),
                          label: Text("Gallery"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed:
                                () => Navigator.pop(context)
                          ,
                          icon: Icon(Icons.check_circle_rounded ),
                          label: Text("Done"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },





          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
    ;
  }
}

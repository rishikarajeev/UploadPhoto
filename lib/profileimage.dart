import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'uploadservice.dart';
import 'constants.dart';

class ProfileImageUpload extends StatefulWidget {
  @override
  State<ProfileImageUpload> createState() => _ProfileImageUploadState();
}

class _ProfileImageUploadState extends State<ProfileImageUpload> {
  File? _image;
  final picker = ImagePicker();

  //function to select photo from gallery
  Future selectPhotoFromGallery(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

      } else {
        print('No photo was selected or taken');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  selectPhotoFromGallery(ImageSource.gallery);
                },
                child: Container(
                    child: _image == null
                        ? const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: radius,
                          ) // set a placeholder image when no photo is set
                        : CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: radius,
                            child: CircleAvatar(
                              radius: radius-5,
                              backgroundImage: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ).image,
                            ),
                          )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              ElevatedButton(
                onPressed: () => upload(_image.toString()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Upload image',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void upload(String filepath) async {
    selectPhotoFromGallery(ImageSource.gallery);
    //not working so commenting
    var result=await uploadPhotos(filepath);
     print("Uploaded Successfully $result");
   }
}

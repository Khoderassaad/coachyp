import 'dart:io';
import 'package:coachyp/features/Profile/data/DataSources/imagePicker.dart';
import 'package:coachyp/features/Profile/presantation/pages/Account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _imageFile;
  final Imagepickerr _imagePicker = Imagepickerr(); // Your custom picker class

  Future<void> _pickImage() async {
    try {
      // Show a dialog to choose between camera or gallery
      final source = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Choose Image Source"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'camera'),
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'gallery'),
              child: const Text("Gallery"),
            ),
          ],
        ),
      );

      if (source != null) {
        final image = await _imagePicker.uploadimg(source);
        setState(() => _imageFile = image);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick image: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const NetworkImage(
                        "https://i.postimg.cc/0jqKB6mS/Profile-Image.png",
                      ) as ImageProvider,
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: _pickImage,
                    child: SvgPicture.string(cameraIcon),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
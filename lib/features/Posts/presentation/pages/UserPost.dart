import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _submitPost() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final description = _descriptionController.text.trim();

    if (description.isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please add text or image")));
      return;
    }

    setState(() => _isLoading = true);

    String? imageUrl;

    if (_selectedImage != null) {
      final imageId = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child("post_images/$uid/$imageId.jpg");
      await ref.putFile(_selectedImage!);
      imageUrl = await ref.getDownloadURL();
    }

    final postId = const Uuid().v4();

    await FirebaseFirestore.instance.collection('posts').doc(postId).set({
      "postId": postId,
      "authorId": uid,
      "username": user.displayName ?? "Anonymous",
      "description": description,
      "photoUrl": imageUrl,
      "likes": [],
      "createdAt": FieldValue.serverTimestamp(),
    });

    setState(() {
      _descriptionController.clear();
      _selectedImage = null;
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post created!")));
    Navigator.of(context).pop(); // optional: go back
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write something...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 10),
            if (_selectedImage != null)
              Stack(
                children: [
                  Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => setState(() => _selectedImage = null),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: _pickImage,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitPost,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Post"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

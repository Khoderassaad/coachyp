// lib/features/posts/presentation/pages/create_post_page.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:coachyp/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:coachyp/features/posts/domain/entities/post.dart';
import 'package:coachyp/features/posts/domain/use_cases/create_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _descriptionController = TextEditingController();
  XFile? _pickedFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _pickedFile = picked);
    }
  }

  Future<void> _submitPost() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final description = _descriptionController.text.trim();
    if (description.isEmpty && _pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add text or image")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Upload image to Firebase Storage
    String? imageUrl;
    if (_pickedFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref('post_images/$uid/${const Uuid().v4()}.jpg');

      if (kIsWeb) {
        final bytes = await _pickedFile!.readAsBytes();
        final uploadTask = await storageRef.putData(bytes);
        imageUrl = await uploadTask.ref.getDownloadURL();
      } else {
        final file = File(_pickedFile!.path);
        final uploadTask = await storageRef.putFile(file);
        imageUrl = await uploadTask.ref.getDownloadURL();
      }
    }

    // Create Post entity
    final post = Post(
      id: const Uuid().v4(),
      coachId: uid,
      description: description,
      imageUrl: imageUrl ?? '',
      timestamp: DateTime.now(),
      likes: [],
    );

    // Use the CreatePost use case
    try {
      final createPost = Provider.of<CreatePost>(context, listen: false);
      await createPost(post);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post created!")),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to post: \$e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _pickedFile = null;
        _descriptionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write something...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_pickedFile != null) ...[
              if (kIsWeb)
                FutureBuilder<Uint8List>(
                  future: _pickedFile!.readAsBytes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(
                        snapshot.data!,
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    }
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                )
              else
                Image.file(
                  File(_pickedFile!.path),
                  height: 200,
                  fit: BoxFit.cover,
                ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: _pickImage,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text('Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

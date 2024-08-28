import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sphere/app/di/service_locator.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _textController = TextEditingController();
  File? _image;
  String? _mediaUrl;
  String _mediaType = 'text';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _mediaType = 'image';
      });

      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    final fileName = DateTime.now().toIso8601String();
    final storageRef =
        FirebaseStorage.instance.ref().child('post_images/$fileName');

    try {
      final uploadTask = storageRef.putFile(_image!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        if (snapshot.state == TaskState.running) {
          double progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          debugPrint('Upload is $progress% complete');
        } else if (snapshot.state == TaskState.success) {
          debugPrint('Upload completed successfully');
        } else if (snapshot.state == TaskState.canceled) {
          debugPrint('Upload was canceled');
        }
      });

      // ignore: unused_local_variable
      final downloadUrl = await uploadTask;
      setState(() async {
        _mediaUrl = await storageRef.getDownloadURL();
      });
    } catch (e) {
      debugPrint("Failed to upload image: $e");
    }
  }

  Future<void> _submitPost() async {
    final prefs = getIt<SharedPreferences>();
    final userId = prefs.getString('userId') ?? '';

    final postId = FirebaseFirestore.instance.collection('posts').doc().id;

    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).set({
        'userId': userId,
        'mediaUrl': _mediaUrl,
        'mediaType': _mediaType,
        'text': _textController.text,
        'createdAt': Timestamp.now(),
        'likesCount': 0,
        'commentsCount': 0,
      });

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Failed to submit post: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _submitPost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_image != null)
              Image.file(
                _image!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            TextField(
              controller: _textController,
              maxLines: null,
              decoration:
                  const InputDecoration(hintText: 'What’s on your mind?'),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}

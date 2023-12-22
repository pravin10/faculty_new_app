import 'dart:typed_data';

import 'package:faculty_colloboration/Utils/global_variable.dart';
import 'package:faculty_colloboration/screens/job_page.dart';
import 'package:faculty_colloboration/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:faculty_colloboration/provider/user_provider.dart';
import 'package:faculty_colloboration/resource/firestore_methods.dart';
import 'package:faculty_colloboration/utils/colors.dart';
import 'package:faculty_colloboration/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });

    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage
      );

      if (res == "success") {
        setState(() {
          isLoading = false;
        });

        if (context.mounted) {
          showSnackBar(
            'Posted!',
            context
          );
        }

        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(res, context);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });

      showSnackBar(
        err.toString(),
        context
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void openLinkDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final linkController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Link'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: linkController,
                decoration: const InputDecoration(
                  hintText: 'Enter the link URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle link submission
                print('Link: ${linkController.text}');
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ]
        );
      }
    );
  }
      


  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: ()
          {if (_file!=null) {
              clearImage();
            } else {
              // Navigate back to the feed page when no image is added
              Navigator.of(context).pop();
            }}
        ),
        title: const Text(
          'Create a post',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: <Widget>[
          TextButton(
            onPressed: () => postImage(
              userProvider.getUser.uid,
              userProvider.getUser.username,
              userProvider.getUser.photoUrl,
            ),
            child: const Text(
              "Post",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
      drawer: FacultyAppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: "What do you want to talk about?",
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            if (_file != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(_file!),
                  ),
                ),
              ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () => _selectImage(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () {
                      // TODO: Add functionality to add a link
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.topic),
                    onPressed: () {
                      // TODO: Add functionality to add a topic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FacultyAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Divya"),
                accountEmail: GestureDetector(
                  onTap: () {
                    // Navigate to the ViewProfilePage when email is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
                      ),
                    );
                  },
                  child: Text("View Profile"),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/ooty3.jpeg'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Handle home tap
                },
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text('Job'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Research'),
                onTap: () {
                  // Handle research tap
                },
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Scholarship'),
                onTap: () {
                  // Handle scholarship tap
                },
              ),
              // ... add more list items as needed
            ],
          ),
        ],
      ),
    );
  }
}

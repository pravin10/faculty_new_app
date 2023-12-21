import 'package:flutter/material.dart';
import 'package:faculty_colloboration/widgets/button.dart';
import 'package:faculty_colloboration/widgets/text_field.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController _skillsController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  List<String> _selectedInterests = [];

  List<String> studyInterests = [
    'Computer Science',
    'Data Science',
    'Machine Learning',
    'Physics',
    'Chemistry',
    'Mathematics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text(
              "Skills",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 34, 85, 126)),
            ),
            MyTextField(
              controller: _skillsController,
              hintText: "Enter your skills, separated by commas",
              obscureText: false,
            ),
            SizedBox(height: 20),
            Text(
              "About",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 34, 85, 126)),
            ),
            MyTextField(
              controller: _aboutController,
              hintText: "Write about yourself",
              obscureText: false,
            ),
            SizedBox(height: 20),
            Text(
              "Experience",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 34, 85, 126)),
            ),
            MyTextField(
              controller: _experienceController,
              hintText: "Enter your work or educational experience",
              obscureText: false,
            ),
            SizedBox(height: 20),
            Text(
              "Interests of Study",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Color.fromARGB(255, 34, 85, 126)),
            ),
            Wrap(
              spacing: 8.0,
              children: studyInterests.map((interest) {
                bool isSelected = _selectedInterests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedInterests.add(interest);
                      } else {
                        _selectedInterests.remove(interest);
                      }
                    });
                  },
                  backgroundColor: isSelected ? Colors.pinkAccent[100] : null,
                  selectedColor:
                      Colors.pink[100], // Set the selected color explicitly
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            MyButton(
              onTap: () {
                // Handle updating the profile data
                String skills = _skillsController.text;
                String about = _aboutController.text;
                String experience = _experienceController.text;

                // Perform the update logic, e.g., send data to a server
                // You can replace this with your actual update logic

                // After updating, you might want to navigate back to the profile page or another page
                Navigator.pop(context);
              },
              text: "Update Profile",
            ),
          ],
        ),
      ),
    );
  }
}

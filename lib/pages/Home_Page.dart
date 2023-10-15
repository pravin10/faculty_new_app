import 'package:faculty_colloboration/pages/LoginPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faculty Collaboration',
      home: AppHomePage(),
    );
  }
}

class AppHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/ooty3.jpeg'), 
                  
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt,color: Colors.blue[300],),
            onPressed: () {
              // Handle camera button press
            },
          ),
          IconButton(
            icon: Icon(Icons.send,color: Colors.blue[300],),
            onPressed: () {
              // Handle direct messages button press
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>LoginPage(onTap: null) ),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
        ],
      ),
      drawer: FacultyAppDrawer(),
      body: FacultyFeed(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FacultyFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Post> posts = generateDummyPosts();

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return FacultyPostCard(post: posts[index]);
      },
    );
  }

  List<Post> generateDummyPosts() {
    return List.generate(10, (index) => Post(username: 'user$index'));
  }
}

class FacultyPostCard extends StatelessWidget {
  final Post post;

  FacultyPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color.fromARGB(255, 229, 227, 227)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/ooty_5.jpeg'),
            ),
            title: Text(post.username),
            subtitle: Text('Location'),
            trailing: Icon(Icons.more_vert),
          ),
          Image.asset('assets/ooty2.webp'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 8),
                Icon(Icons.comment),
                SizedBox(width: 8),
                Icon(Icons.send),
                Spacer(),
                Icon(Icons.bookmark_border),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Liked by user1, user2, and 100 others'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.username, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text('Caption text goes here.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('View all 20 comments', style: TextStyle(color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/ooty2.webp'),
                  radius: 12,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('2 hours ago', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String username;

  Post({required this.username});
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
                accountEmail: Text("sonidivya564@gmail.com"),
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
                  // Handle job tap
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
            ],
          ),
        ],
      ),
    );
  }
}

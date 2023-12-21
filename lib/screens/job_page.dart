import 'package:faculty_colloboration/screens/add_post_screen.dart';
import 'package:flutter/material.dart';


class JobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobListPage(),
    );
  }
}

class JobListPage extends StatelessWidget {
  final List<Job> jobs = [
    Job("Software Engineer", "Developing awesome Flutter apps.",
        "Google", "assets/google.png", DateTime.now().subtract(Duration(hours: 3))),
    Job("Product Designer", "Creating beautiful and intuitive user interfaces.",
        "Microsoft", "assets/microsoft.jpg", DateTime.now().subtract(Duration(days: 1))),
    Job("Marketing Specialist", "Promoting our products to a global audience.",
        "Flipkart", "assets/flipkart.jpeg", DateTime.now().subtract(Duration(days: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Notifications'),
      ),
      drawer: FacultyAppDrawer(),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          Duration timeAgo = DateTime.now().difference(jobs[index].timePosted);
          String timeAgoString = _formatDuration(timeAgo);

          return Card(
            elevation: 1,
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundImage: AssetImage(jobs[index].imageUrl),
              ),
              title: Text(jobs[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(jobs[index].company),
                  SizedBox(height: 12,),
                  Text('$timeAgoString ago'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.bookmark_border), // Use bookmark icon
                onPressed: () {
                  // Add logic here to save the job post for later
                  // For simplicity, you can print a message for now
                  print('Job saved for later: ${jobs[index].title}');
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobDetailsPage(job: jobs[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }


  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return 'Now';
    }
  }
}

class JobDetailsPage extends StatelessWidget {
  final Job job;
  JobDetailsPage({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              job.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Posted by ${job.company}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Job {
  final String title;
  final String description;
  final String company;
  final String imageUrl;
  final DateTime timePosted;

  Job(this.title, this.description, this.company, this.imageUrl, this.timePosted);
}
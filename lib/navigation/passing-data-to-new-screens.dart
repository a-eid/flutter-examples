import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class PassingDataToNewScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Job {
  Job({
    required this.title,
    required this.description,
    this.fullDescription = const [],
  });

  String title;
  String description;
  List<String> fullDescription;
}

class Home extends StatelessWidget {
  final Faker faker = Faker();

  late final List<Job> jobs = List.generate(
    200,
    (index) => Job(
      title: faker.job.title(),
      description: faker.lorem.sentence(),
      fullDescription: faker.lorem.sentences(4),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jobs[index].title),
            subtitle: Text(jobs[index].description),
            onTap: () async {
              final String? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetails(job: jobs[index]),
                ),
              );

              //
              if (result is String) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("You $result it"),
                    ),
                  );
              }
            },
          );
        },
      ),
    );
  }
}

class JobDetails extends StatelessWidget {
  final Job job;
  JobDetails({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.title),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(job.description),
            SizedBox(height: 12),
            ...job.fullDescription.map(
              (e) => Column(
                children: [
                  Text(e),
                  SizedBox(height: 12),
                ],
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'like');
                  },
                  child: Text("Like it"),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'hate');
                  },
                  child: Text("hate it"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

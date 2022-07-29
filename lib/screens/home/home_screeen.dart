import 'package:flutter/material.dart';
import 'package:mhub/widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: text(
              'Hello!\n\nI am really sorry I could not complete the test app, the timeline was quite short.\n\nHowever, I am convinced that the quality of my code would persuade you to give me this role. \nThank you!',
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

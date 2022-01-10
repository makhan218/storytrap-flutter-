import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer' as dev;
import 'package:storytrapflutter/helper_files/google_auth_api.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x707070),
      appBar: AppBar(
        title: const Text("Feed Back"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "How satisfied are you with Story Trap",
                style: TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sentiment_very_dissatisfied_outlined,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sentiment_neutral_outlined,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sentiment_satisfied_alt_rounded,
                        color: Colors.white,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sentiment_very_satisfied_rounded,
                        color: Colors.yellowAccent,
                        size: 40,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (input) {
                    if (input == null) {
                      return;
                    }
                    input.isValidEmail() ? null : "Check your email";
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Enter your email",
                      fillColor: Colors.white70),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 8,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Enter your email",
                      fillColor: Colors.white70),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future sendEmail() async {
  dev.debugger();
  send();

  // final user = await GoogleAuthApi.signIn();
}

Future<void> send() async {
  final Email email = Email(
    body: "body text",
    subject: "subject",
    recipients: ["storytrapfeedback@gmail.com"],
    // attachmentPaths: attachments,
    isHTML: false,
  );

  String platformResponse;

  try {
    await FlutterEmailSender.send(email);
    platformResponse = 'success';
    print(platformResponse);
  } catch (error) {
    platformResponse = error.toString();
    print(platformResponse);
  }

  // if (!mounted) return;

  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(platformResponse),
  //   ),
  // );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

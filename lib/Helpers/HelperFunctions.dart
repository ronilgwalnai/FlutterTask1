import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Helpers/Constants.dart';

void startNewPage(BuildContext context, Widget page,
    {bool finishCurrent = true, bool finishAll = false}) {
  if (finishAll) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }), (route) => false);
  } else {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return !finishCurrent;
            },
            child: page);
      }),
    );
  }
}

AlertDialog? dialogue;

void cancelDialogue(BuildContext context) {
  if (dialogue != null) {
    Navigator.pop(context);
  }
}

void showDialogue(BuildContext context) {
  dialogue ??= AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Button border radius
    ),
    title: InkWell(
        onTap: () {
          cancelDialogue(context);
        },
        child: const Text(Strings.loading)),
    content: SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.orange,
            color: Colors.green,
          ),
          const SizedBox(height: 46.0),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Text(Strings.pleaseWait)),
        ],
      ),
    ),
    // actions: [
    //   ElevatedButton(
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //     },
    //     child: Text('Close'),
    //   ),
    // ],
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: dialogue!);
    },
  );
  // startFirstPage(dialogue);
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

class DemoPage extends StatelessWidget {
   DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Hero(
        tag: Strings.login,
        child: Center(
          child: Container(
            width: 400,height: 400,

            color: Colors.green,
          ),
        ),
      ),
    );
  }

}

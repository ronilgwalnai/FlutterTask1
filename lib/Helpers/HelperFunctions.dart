import 'package:flutter/material.dart';
import 'package:task/Helpers/Constants.dart';

void startNewPage(BuildContext context, String page,
    {bool finishCurrent = true, bool finishAll = false, Object? arguments}) {
  if (finishAll) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(page, arguments: arguments, (route) => false);
  } else {
    if (finishCurrent) {
      Navigator.of(context).pushReplacementNamed(page, arguments: arguments);
    } else {
      Navigator.of(context).pushNamed(page, arguments: arguments);
    }
  }
}

void onBackPress(BuildContext context){
  Navigator.pop(context);
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
            width: 400,
            height: 400,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

Widget gridItem(String title, String imagePath) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              spreadRadius: 0.001,
              color: Colors.grey,
              blurRadius: 0.001,
              offset: Offset(0.1, 0.1))
        ],
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imagePath == ''
            ? const Image(image: AssetImage(ImagesPath.demo))
            : Image(image: NetworkImage(imagePath)),
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text(title,maxLines: 2,),
        )
      ],
    ),
  );
}



import 'dart:async';
import 'dart:collection';

import 'package:http/http.dart' as http;

class MyApiCalls {
  String url;
  StreamSubscription<http.Response>? _requestSubscription;

  void _cancelRequest() {
    _requestSubscription?.cancel();
    _requestSubscription = null;
  }

  bool _cancel = true;

  MyApiCalls({required this.url, bool cancel = true}) {
    _cancel = cancel;
  }

  Future<void> getRequest<T>(HashMap<String, String> hashMap,
      Function(String) onApiSuccess, Function(Error) onApiFailed) async {
    if (_cancel) {

      _cancelRequest();
    }
    var tempUri = Uri.parse(url);
    var request = http.get(
      Uri.https(tempUri.authority, tempUri.path, hashMap),
    );
    _requestSubscription = request.asStream().listen((response) {
      if (response.statusCode == 200) {
        print("GET --- ${response.body}");
        onApiSuccess(response.body);
      } else {
        // Error handling
        onApiFailed(
            Error(statusCode: response.statusCode, message: response.body));
      }
    }, onError: (error) {
      onApiFailed(
          Error(statusCode: error.statusCode, message: error.toString()));
      // Handle any errors
    });
  }

  Future<void> postRequest(HashMap hashMap, Function(String) onApiSuccess,
      Function(Error) onApiFailed) async {
    if (_cancel) {
      _cancelRequest();
    }
    var request = http.post(Uri.parse(url), body: hashMap);
    _requestSubscription = request.asStream().listen((response) {
      if (response.statusCode == 200) {
        print(response.body);
        onApiSuccess(response.body);
      } else {
        onApiFailed(
            Error(statusCode: response.statusCode, message: response.body));
      }
    }, onError: (error) {
      // Handle any errors
    });
  }
}

class Error {
  int statusCode;
  String? message;

  Error({required this.statusCode, required this.message});
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:digital14_events/constant/credentials.dart';
import 'package:digital14_events/constant/urls.dart';

Future<http.Response?> apiCall({
  required String url,
  Map<String, String>? body,
}) async {
  if (body != null) {
    body.putIfAbsent(queryClientId, () => Credential.clientId);
  } else {
    body = {queryClientId: Credential.clientId};
  }
  var endPoint = Uri.https(domain, url, body);
  try {
    return await http.get(endPoint);
  } catch (ex) {
    debugPrint(ex.toString());
    return null;
  }
}

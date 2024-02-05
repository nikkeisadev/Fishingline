import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openFacebook(BuildContext context) async {
  const url = 'https://www.facebook.com/profile.php?id=100089441516254';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// Importing Packages
import 'package:flutter/material.dart';
import 'package:location_tracking_2/constants.dart';
import 'package:share_plus/share_plus.dart';

// Shares the app
Future shareApp(BuildContext context) async{
  final box = context.findRenderObject() as RenderBox;
  await Share.share(
    kShareText,
    subject: kShareSubject,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();

  String formattedDate = "$year-$month-$day";

  return formattedDate;
}

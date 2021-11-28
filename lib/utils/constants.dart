import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  // static String appName = "AshabulHadith";
  // static String applink = "https://ashabulhadith.com";

  static final Color maincolor = Color.fromRGBO(143, 148, 251, 1);
  static final Color green = Colors.green;

  static int gender = -1;

  static List<String> heights = [
    "4’11",
    "5’1",
    "5’2",
    "5’3",
    "5’4",
    "5’5",
    "5’6",
    "5’7",
    "5’8",
    "5’9",
    "5’10",
    "5’11",
    "6’1",
    "6’2",
    "6’3",
    "6’4",
    "6’5",
    "6’6",
    "6’7",
    "6’8",
    "6’9",
    "6’10",
    "6’11",
    "Any"
  ];

  static List<String> weight = [
    "100lbs",
    "120lbs",
    "140lbs",
    "160lbs",
    "180lbs",
    "200lbs",
    "220lbs",
    "240lbs",
    "260lbs",
    "280lbs"
  ];

  static List<String> hair = [
    "Blonde",
    "Brunette",
    "Black",
    "Red",
  ];
    static List<String> eyeColor = [
    "Brown",
    "blue",
    "green",
    "Hazel",
  ];
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String getRandomString(int length) {
  Random _rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

final postNotificationURL = "https://fcm.googleapis.com/fcm/send";
final headers = {
  'content-type': 'application/json',
  'Authorization': env["authServerKeyFirebase"]
};
List<String> categories = [
  "Advertising/Marketing",
  "Artist",
  "Apparel/Accessories",
  "Automotive",
  "Beauty",
  "Cosmetics/Fragrances",
  "Designer",
  "E-commerce",
  "Education",
  "Electronics",
  "Events",
  "Film/TV/Cable",
  "Financial",
  "Food/Beverage",
  "Haircare",
  "Health/Fitness",
  "Home/Furniture",
  "Hospitality/Hotel",
  "Hotel/Resort",
  "Industrial",
  "Makeup Artist",
  "Medical",
  "Music",
  "Other",
  "Photographer",
  "Publication",
  "Real Estate",
  "Retail",
  "Skincare",
  "Spa",
  "Sports",
  "Stylist",
  "Technology",
  "Travel",
  "Videographer",
];

List<int> categoryIndex = [
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
];

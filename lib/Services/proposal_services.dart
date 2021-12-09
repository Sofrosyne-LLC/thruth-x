import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProposalService {
  static submitProposal(
      {String uid,
      var hourlyRate,
      String jobtype,
      String duration,
      List<DateTime> potDates,
      List<String> locations,
      String wardrob,
      String wardspecs,
      String anythingElse,
      String isMakeupReady}) async {
    print("$uid");
    await FirebaseFirestore.instance
        .collection("user")
        .doc(uid.trim())
        .collection("gigs")
        .add({
          "clientDp": FirebaseAuth.instance.currentUser.photoURL,
          "clientID": FirebaseAuth.instance.currentUser.uid,
          "clientName": FirebaseAuth.instance.currentUser.displayName,
          "dateCreated": DateTime.now(),
          "desc": "Jxjjkdkkdkkdkdd",
          "gigOrder": Random().nextInt(900000) + 100000,
          "hourlyRate": double.parse(hourlyRate.toString()),
          "jobtype": jobtype,
          "estDuration": duration,
          "potentialDates": potDates,
          "locations": locations,
          "wardrob": wardrob,
          "wardrobSpecs": wardspecs,
          "else": anythingElse,
          "isMakeupReady": isMakeupReady
        })
        .then((value) => print(value))
        .onError((error, stackTrace) => print(error));
  }
}

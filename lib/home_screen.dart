import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_examination/detail.dart';
import 'package:eye_examination/instruction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

final List<UserTransaction> transactions = [];

class HomeScreen extends StatelessWidget {
  // final List<Transactions> _transactions = [
  //   Transactions(name: "Julia", note: "color blind"),
  //   Transactions(name: "Julia", note: "color blind"),
  //   Transactions(name: "Julia", note: "color blind"),
  // ];
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Нүдний тест ",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Colors.blue.shade100,
        ),
      ),
      body: user != null ? StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .collection("eyeExam")
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final _testDocs = snapshots.data;
          return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTapDown: (details) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(_testDocs, index),
                          ),
                        );
                      },
                      child: Container(
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 0.1,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 7) // changes position of shadow
                                ),
                          ],
                        ),
                        margin:
                            const EdgeInsets.only(left: 12, right: 12, top: 7),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.blue[100],
                                // Image.asset("assets/images/default_user.png"),
                                child: Image.asset(
                                    "assets/images/default_user.png"),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 15),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 200,
                                    child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                            "Нэр : ${_testDocs!.docs[index]['name']}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      "Өвчин : ${_testDocs.docs[index]['notes']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        // child: transactions.isEmpty
        //     ? Instruction()
        // : ListView.builder(
        //     itemCount: transactions.length,
        //     itemBuilder: (ctx, index) {
        //       return
        // Column(
        //         children: [
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           GestureDetector(
        //             onTapDown: (details) {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) =>
        //                       Detail(transactions[index], index),
        //                 ),
        //               );
        //             },
        //             child: Container(
        //               //color: Colors.white,
        //               decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 border: Border.all(color: Colors.black, width: 2.3),
        //                 borderRadius:
        //                     const BorderRadius.all(Radius.circular(7)),
        //                 boxShadow: [
        //                   BoxShadow(
        //                       color: Colors.black.withOpacity(0.3),
        //                       spreadRadius: 0.1,
        //                       blurRadius: 5,
        //                       offset: const Offset(
        //                           0, 7) // changes position of shadow
        //                       ),
        //                 ],
        //               ),
        //               margin: const EdgeInsets.only(
        //                   left: 12, right: 12, top: 7),
        //               child: Row(
        //                 children: <Widget>[
        //                   Container(
        //                     child: CircleAvatar(
        //                       radius: 24,
        //                       backgroundColor: Colors.blue[100],
        //                       // Image.asset("assets/images/default_user.png"),
        //                       child: Image.asset(
        //                           "assets/images/default_user.png"),
        //                     ),
        //                     margin: const EdgeInsets.symmetric(
        //                         vertical: 12, horizontal: 15),
        //                   ),
        //                   Padding(
        //                     padding:
        //                         const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: <Widget>[
        //                         Text(
        //                           "Name : ${transactions[index].name}",
        //                           style: const TextStyle(
        //                               fontSize: 16,
        //                               fontWeight: FontWeight.w500),
        //                         ),
        //                         const SizedBox(
        //                           height: 8,
        //                         ),
        //                         Text(
        //                             "Disease : ${transactions[index].notes}",
        //                             style: const TextStyle(
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.w500)),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //   ),
      ) : Instruction()
    );
  }
}

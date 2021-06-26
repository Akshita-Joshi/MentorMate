import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/chat_screen.dart';
import 'package:mentor_mate/components/bottom_drawer.dart';
import 'package:mentor_mate/components/popup.dart';
import 'package:mentor_mate/globals.dart';

class TeacherChatScreen extends StatefulWidget {
  final Map<String, dynamic>? userMap;
  String? chatRoomId;

  TeacherChatScreen({this.chatRoomId, this.userMap});
  @override
  _TeacherChatScreenState createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const String _heroAddTodo = 'add-todo-hero';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.082), //70
        child: AppBar(
          leadingWidth: height * 0.082, //70
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
              customBorder: new CircleBorder(),
              splashColor: Colors.black.withOpacity(0.2),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: height * 0.035, //30
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(child: SvgPicture.asset('assets/back.svg')))),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userMap!['name'],
                style: TextStyle(
                    fontFamily: "MontserratB",
                    fontSize: 16, //24
                    color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                widget.userMap!['studentKey'],
                style: TextStyle(
                    fontFamily: "MontserratM",
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.4)),
              ),
            ],
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(
                    left: width * 0.045, right: width * 0.071), //18 28
                child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(HeroDialogRoute(builder: (context) {
                        return MeetAcceptPopupCard();
                      }));
                    },
                    child: Hero(
                        tag: _heroAddTodo,
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin, end: end);
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                              height: height * 0.07, //60
                              width: width * 0.152, //60
                              child: Center(
                                  child: SvgPicture.asset('assets/meet.svg'))),
                        ))))
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('chatroom')
                          .doc(widget.chatRoomId)
                          .collection('chats')
                          .doc(widget.chatRoomId)
                          .collection('doubts')
                          .orderBy('time', descending: false)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                Map<String, dynamic> map =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                if (map['type'] == 'link') {
                                  return MeetCard();
                                } else {
                                  return map['type'] == 'message'
                                      ? Message(
                                          check: 'teacher',
                                          map: map,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                HeroDialogRoute(
                                                    builder: (context) {
                                              return DoubtSolvedPopup(
                                                  doubtid: document.id,
                                                  id: widget.chatRoomId!,
                                                  map: map);
                                            }));
                                          },
                                          child: Hero(
                                              tag: 'doubt',
                                              createRectTween: (begin, end) {
                                                return CustomRectTween(
                                                    begin: begin, end: end);
                                              },
                                              child: DoubtMessage(map: map)));
                                }
                              });
                        } else {
                          return Container();
                        }
                      })),
              Container(width: width, child: TextInput()),
            ],
          ),
        ],
      ),
    );
  }
}

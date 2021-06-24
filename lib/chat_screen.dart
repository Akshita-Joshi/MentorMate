import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/chat/firebase.dart';
import 'package:mentor_mate/components/bottom_drawer.dart';
import 'package:mentor_mate/components/popup.dart';
import 'package:mentor_mate/models/models.dart';
import 'globals.dart';
//this file has the chat screen

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic>? userMap;
  String? chatRoomId;

  ChatScreen({this.chatRoomId, this.userMap});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messagetitle = TextEditingController();
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      print(_message.text);
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.displayName,
        "message": _message.text,
        'title': _messagetitle,
        "time": FieldValue.serverTimestamp(),
      };
      message.clear();

      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(widget.chatRoomId)
          .collection('doubts')
          .add(messages);
    } else {
      print('Enter Some Text');
    }
  }

  List<Messages> _msgs = [
    Messages(
        from: "receiver",
        message:
            "It's very simple, just change your settings in your IDE regarding declaration and it will work",
        time: '9:36 AM',
        type: 'chat'),
    Messages(from: "sender", message: "..", time: '9:31 AM', type: 'chat'),
    Messages(
        from: "sender", message: "Okay ma'am", time: '9:31 AM', type: 'chat'),
    Messages(
        from: "receiver",
        message: "Lets schedule a meet at 5:30 pm",
        time: '9:30 AM',
        type: 'chat'),
    Messages(
        from: "receiver",
        message: "null",
        time: '9:30 AM',
        type: 'doubt',
        title: 'What are classes in CPP ?',
        description:
            'Good evening ma’am , I was trying to make a class in cpp but the compiler is showing error everytime. '),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const String _heroAddTodo = 'add-todo-hero';

    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
          title: Text(
            "Teacher",
            style: TextStyle(
                fontFamily: "MontserratB",
                fontSize: width * 0.0611, //24
                color: Colors.black),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.045, right: width * 0.071), //18 28
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        type = 'doubt';
                        Drawerclass.showMenu = true;
                      });
                    },
                    child: Text("AskDoubt",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: width * 0.04, //16
                            color: Colors.black)),
                  ),
                  SizedBox(
                    width: width * 0.076, //30
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return MeetRequestPopupCard();
                        }));
                      },
                      child:
                          /*Container(
                        height: width * 0.152, //60
                        child:
                            Center(child: SvgPicture.asset('assets/meet.svg'))),*/
                          Hero(
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
                                        child: SvgPicture.asset(
                                            'assets/meet.svg'))),
                              )))
                ],
              ),
            )
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
                              reverse: true,
                              itemBuilder: (BuildContext context, index) {
                                Map<String, dynamic> map =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return map['type'] == 'message'
                                    ? Message(
                                        map: map,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              HeroDialogRoute(
                                                  builder: (context) {
                                            return DoubtSolvedPopup(map: map);
                                          }));
                                        },
                                        child: Hero(
                                            tag: 'doubt',
                                            createRectTween: (begin, end) {
                                              return CustomRectTween(
                                                  begin: begin, end: end);
                                            },
                                            child: DoubtMessage(map: map)));
                                /*_msgs[index].type.toString() == 'chat'
                                    ? Message(
                                        from: _msgs[index].from.toString(),
                                        message:
                                            _msgs[index].message.toString(),
                                        time: _msgs[index].time.toString(),
                                        map: map,
                                      )
                                    : DoubtMessage(
                                        title: _msgs[index].title.toString(),
                                        description:
                                            _msgs[index].description.toString(),
                                        time: _msgs[index].time.toString(),
                                      );*/
                              });
                        } else {
                          return Container();
                        }
                      })),
              Container(width: width, child: TextInput()),
            ],
          ),

          //this widget is bottom drawer
          BottomDrawer(
            showMenu: Drawerclass.showMenu,
          )
        ],
      ),
    );
  }
}

class Message extends StatefulWidget {
  Map<String, dynamic> map;
  Message({required this.map});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.061, vertical: height * 0.009), //24 8
      child: Container(
        alignment: widget.map['sendby'] == auth.currentUser!.displayName
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: width * 0.71, minWidth: width * 0.25), //280 100
          decoration: BoxDecoration(
              color: grey, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.018), //16 16
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(/*widget.message!*/ widget.map['message'],
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: width * 0.045, //18
                        color: Colors.black)),
                SizedBox(height: height * 0.009), //8
                Text(widget.map['time'].toString(),
                    style: TextStyle(
                        fontFamily: "MontserratM",
                        fontSize: width * 0.025, //10
                        color: Colors.black.withOpacity(0.3)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoubtMessage extends StatefulWidget {
  Map<String, dynamic> map;
  DoubtMessage({required this.map});
  @override
  _DoubtMessageState createState() => _DoubtMessageState();
}

class _DoubtMessageState extends State<DoubtMessage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.045, vertical: height * 0.021), //18 18
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: height * 0.023, //20
                  width: width * 0.05, //20
                  child: Center(
                    child: widget.map['solved']
                        ? SvgPicture.asset(
                            'assets/tick.svg',
                            height: 10,
                          )
                        : SvgPicture.asset(
                            'assets/round.svg',
                            height: 5,
                          ),
                  ),
                ),
                Text(widget.map['title'],
                    style: TextStyle(
                      fontFamily: "MontserratSB",
                      fontSize: width * 0.061, //24
                      color: Colors.black,
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.05,
                  top: height * 0.011,
                  bottom: height * 0.011), //20 10 10
              child: Text(
                widget.map['description'],
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.045, //18
                    color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.05, top: height * 0.009), //20 8
              child: Text(widget.map['time'].toString(),
                  style: TextStyle(
                      fontFamily: "MontserratM",
                      fontSize: width * 0.035, //14
                      color: Colors.black.withOpacity(0.3))),
            ),
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.045, vertical: height * 0.021), //18 18
      child: Container(
        height: height * 0.058, //50
        width: width,
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.014), //12 12
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.028, //24
                child: SvgPicture.asset('assets/paperclip.svg'),
              ),
              SizedBox(
                width: width * 0.025, //10
              ),
              Flexible(
                /*height: 50,
                width: 200,*/
                child: TextFormField(
                  controller: message,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: width * 0.045, //18
                      color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.045, //18
                          color: Colors.black.withOpacity(0.3)),
                      hintText: "Type Something ....."),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    type = 'message';
                  });
                  onSendMessage();
                },
                child: Container(
                  height: height * 0.058, //50
                  width: width * 0.101, //40
                  child: Text(
                    'Send',
                    style: TextStyle(
                        fontFamily: "MontserratM",
                        fontSize: width * 0.035, //14
                        color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

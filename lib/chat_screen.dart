import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/components/bottom_drawer.dart';
import 'globals.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    //bool showMenu = false;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          leadingWidth: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
              customBorder: new CircleBorder(),
              splashColor: Colors.black.withOpacity(0.2),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 30,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(child: SvgPicture.asset('assets/back.svg')))),
          title: Text(
            "Teacher",
            style: TextStyle(
                fontFamily: "MontserratB", fontSize: 24, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Drawerclass.showMenu = true;
                      });
                    },
                    child: Text("AskDoubt",
                        style: TextStyle(
                            //decoration: TextDecoration.underline,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            color: Colors.black)),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                      height: 60,
                      child: Center(child: SvgPicture.asset('assets/meet.svg')))
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  DoubtMessage(),
                  Message(
                      from: "receiver",
                      message: "Lets schedule a meet at 5:30 pm",
                      time: '9:30 AM'),
                  Message(
                      from: "sender", message: "Okay ma'am", time: '9:31 AM'),
                  Message(from: "sender", message: "..", time: '9:31 AM'),
                  Message(
                      from: "receiver",
                      message:
                          "It's very simple, just change your settings in your IDE regarding declaration and it will work",
                      time: '9:36 AM'),
                ],
              ),
            ),
            //Positioned(width: width, bottom: 8, child: TextInput()),
            BottomDrawer(
              showMenu: Drawerclass.showMenu,
            )
          ],
        ),
      ),
      bottomNavigationBar: TextInput(),
    );
  }
}

class Message extends StatefulWidget {
  String from;
  String message;
  String time;
  bool read;

  Message({this.from, this.message, this.time, this.read});
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Container(
        alignment:
            widget.from == 'receiver' ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: 280, minWidth: 100),
          decoration: BoxDecoration(
              color: grey, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.message,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        color: Colors.black)),
                SizedBox(height: 8),
                Text(widget.time,
                    style: TextStyle(
                        fontFamily: "MontserratM",
                        fontSize: 10,
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
  @override
  _DoubtMessageState createState() => _DoubtMessageState();
}

class _DoubtMessageState extends State<DoubtMessage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    return Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/round.svg',
                      height: 5,
                    ),
                  ),
                ),
                Text('What are classes in CPP ?',
                    style: TextStyle(
                      fontFamily: "MontserratSB",
                      fontSize: 24,
                      color: Colors.black,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
              child: Text(
                'Good evening ma’am , I was trying to make a class in cpp but the compiler is showing error everytime. ',
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.6)),
              ),
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
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 50,
        width: width,
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 24,
                child: SvgPicture.asset('assets/paperclip.svg'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                /*height: 50,
                width: 200,*/
                child: TextFormField(
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                      color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.3)),
                      hintText: "Type Something ....."),
                ),
              ),
              Container(
                height: 50,
                width: 40,
                child: Text(
                  'Send',
                  style: TextStyle(
                      fontFamily: "MontserratM",
                      fontSize: 14,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

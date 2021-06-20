import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/components/bottom_drawer.dart';
import 'globals.dart';
//this file has the chat screen

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  Container(
                      height: width * 0.152, //60
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
            Positioned(
                bottom: 18, //18
                child: Container(width: width, child: TextInput())),
            //this widget is bottom drawer
            BottomDrawer(
              showMenu: Drawerclass.showMenu,
            )
          ],
        ),
      ),
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
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.061, vertical: height * 0.009), //24 8
      child: Container(
        alignment:
            widget.from == 'receiver' ? Alignment.topLeft : Alignment.topRight,
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
                Text(widget.message,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: width * 0.045, //18
                        color: Colors.black)),
                SizedBox(height: height * 0.009), //8
                Text(widget.time,
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
                    child: SvgPicture.asset(
                      'assets/round.svg',
                      height: 5,
                    ),
                  ),
                ),
                Text('What are classes in CPP ?',
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
                'Good evening ma’am , I was trying to make a class in cpp but the compiler is showing error everytime. ',
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.045, //18
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
            crossAxisAlignment: CrossAxisAlignment.baseline,
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
              Container(
                height: height * 0.058, //50
                width: width * 0.101, //40
                child: Text(
                  'Send',
                  style: TextStyle(
                      fontFamily: "MontserratM",
                      fontSize: width * 0.035, //14
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

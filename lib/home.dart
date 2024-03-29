import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_mate/authentication/authenticate.dart';
import 'package:mentor_mate/chat/firebase.dart';
import 'package:mentor_mate/chat_screen.dart';
import 'package:mentor_mate/components/request.dart';
import 'package:mentor_mate/doubt_screen.dart';
import 'package:mentor_mate/doubts_list.dart';
import 'package:mentor_mate/forum.dart';
import 'package:mentor_mate/globals.dart';
import 'package:mentor_mate/models/models.dart';

class StudentHome extends StatefulWidget {
  Map<String, dynamic> userMap;
  StudentHome({required this.userMap});
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  //this widget is the text style for subjects
  static TextStyle _textStyle() {
    return TextStyle(
        fontFamily: "MontserratSB",
        fontSize: width! * 0.061, //24
        color: Colors.black);
  }

  List<Widget> _subTiles = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? currentNameDisplay;

  @override
  void initState() {
    super.initState();
    getUser();
    _firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      print(value.data());
      print(value.data()!['name']);
      currentUser = value.data()!['name'];
      setState(() {
        currentNameDisplay = value.data()!['name'];
      });
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _addSubs();
    });
  } ////
// Future logOut(BuildContext context) async {

//   FirebaseAuth _auth = FirebaseAuth.instance;

//   try {
//     await _auth.signOut().then((value) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()), );
//     });
//   } catch (e) {
//     print("error");
//   }
// }///////
  void _addSubs() {
    List<Sub> sub = [
      Sub(name: "Applied Mathematics"),
      Sub(name: "Computer Networks"),
      Sub(name: "Object Oriented Programming"),
      Sub(name: "Data Structures"),
      Sub(name: "Theory of Computation"),
      Sub(name: "Microprocessors"),
    ];

    Future ft = Future(() {});
    sub.forEach((Sub sub) {
      ft = ft.then((data) {
        return Future.delayed(const Duration(milliseconds: 10), () {
          _subTiles.add(_buildTile(sub));
          _listKey.currentState!.insertItem(_subTiles.length - 1);
        });
      });
    });
  }

  //Map<String, dynamic>? userMap;
  var collectionss;

  void displayuserss() async {
    var documents = await _firestore.collection('users').get();
    print("this is display useer");
    print(documents);
  }

//this widget is the subject card
  Widget _buildTile(Sub sub) {
    return InkWell(
      radius: 320,
      splashColor: Colors.black.withOpacity(0.2),
      onTap: () {
        /*String roomId =
            chatRoomId(_auth.currentUser!.displayName!, userMap?['name']);*/

        /*Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DoubtScreen(
                  chatRoomId: roomId,
                  userMap: userMap,
                )));*/
        /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(), //directs to chat screen on tap
            ));*/
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: height! * 0.014, top: height! * 0.014), //12 12
          child: Text(
            sub.name!,
            style: _textStyle(),
          ),
        ),
      ),
    );
  }

//these two variables are related to animations
  Tween<Offset> _offset = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    displayuserss();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              logOut(context);
            },
            child: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.only(
                left: width * 0.045, right: width * 0.045), //18 18
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    fontFamily: "MontserratB",
                    fontSize: width * 0.112, //44
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.userMap['name'],
                  style: TextStyle(
                    fontFamily: "MontserratT",
                    fontSize: width * 0.076, //30
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: height * 0.141, //120
                ),
                Expanded(
                    child:
                        /*AnimatedList(
                      key: _listKey,
                      initialItemCount: _subTiles.length,
                      itemBuilder: (context, index, animation) {
                        return SlideTransition(
                            position: animation.drive(_offset),
                            child: _subTiles[index]);
                      }),*/
                        StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('teachers')
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot<QuerySnapshot> usersnapshot) {
                    if (usersnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: usersnapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                usersnapshot.data!.docs[index];
                            var currentName;
                            var currentYear;

                            _firestore
                                .collection("users")
                                .doc(auth.currentUser!.uid)
                                .get()
                                .then((value) {
                              print(value.data());
                              print(value.data()!['name']);
                              print(value.data()!['year']);
                              currentName = value.data()!['name'];
                              currentYear = value.data()!['year'];
                            });

                            Map<String, dynamic> map =
                                usersnapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            if (document.id == auth.currentUser?.uid) {
                              collectionss = document.data().toString();
                              return Container(height: 0);
                            }
                            return InkWell(
                              radius: 320,
                              splashColor: Colors.black.withOpacity(0.2),
                              onTap: () {
                                String roomId1 =
                                    chatRoomId(currentName, map['name']);
                                setState(() {
                                  roomId = roomId1;
                                  to = map['name'];
                                });

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                        chatRoomId: roomId1,
                                        userMap: map,
                                        name1: currentName,
                                        name2: map['name'])));
                              },
                              child:
                                  map['${widget.userMap['year']}'].toString() !=
                                          'null'
                                      ? Container(
                                          child: Text(
                                          map['${widget.userMap['year']}']
                                              .toString(),
                                          style: _textStyle(),
                                        ))
                                      : Container(
                                          height: 0,
                                        ),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
                
                )
                
              ],
            ),
          ),
        ),
        Positioned(
          bottom: height * 0.023, //20
          child: Container(
            width: width,
            height: height * 0.058, //50
            child: Center(
              child: SvgPicture.asset(
                'assets/logo.svg',
                color: Color(0xFFe0e3e3).withOpacity(0.9),
              ),
            ),
          ),
        ),
      ]),
       floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 26.0,bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child: FloatingActionButton(
                      child: Text("Forum",style: TextStyle(color: Colors.black),),
                      backgroundColor: Colors.white,
                      
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FormDart(
                                  teacherMap: widget.userMap,
                                )));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.white)),
                )
            )]
       ),));
  }
}

class TeacherHome extends StatefulWidget {
  Map<String, dynamic> teacherMap;
  TeacherHome({required this.teacherMap});
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height! * 0.082), //70
            child: AppBar(
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  FormDart(teacherMap: widget.teacherMap)));
                    },
                    child: Text("forum"))
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: height! * 0.018, //16
                    ),
                    TabBar(
                      indicatorColor: Colors.white,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black.withOpacity(0.3),
                      labelStyle: TextStyle(
                          fontFamily: "MontserratM",
                          fontSize: width! * 0.040, //16
                          color: Colors.black),
                      unselectedLabelStyle: TextStyle(
                          fontFamily: "MontserratM",
                          fontSize: width! * 0.040, //16
                          color: Colors.black.withOpacity(0.4)),
                      controller: _controller,
                      isScrollable: false,
                      tabs: [
                        Tab(
                          text: 'FY BTech',
                        ),
                        Tab(
                          text: 'SY BTech',
                        ),
                        Tab(
                          text: 'TY BTech',
                        ),
                        Tab(
                          text: 'BTech',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(children: [
            TabBarView(
              controller: _controller,
              children: [
                DoubtPage(checkYear: "FY", teacherMap: widget.teacherMap),
                DoubtPage(checkYear: "SY", teacherMap: widget.teacherMap),
                DoubtPage(checkYear: "TY", teacherMap: widget.teacherMap),
                DoubtPage(checkYear: "BTech", teacherMap: widget.teacherMap),
              ],
            ),
            // Positioned(
            //     top: height! * 0.082, //70
            //     child: RequestList(teacherMap: widget.teacherMap))
          ]),
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(left: 26.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Center(
          //           child: FloatingActionButton(
          //         onPressed: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (_) => FormDart(
          //                         teacherMap: widget.teacherMap,
          //                       )));
          //         },
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(18),
          //             side: BorderSide(color: Colors.white)),
          //       )
          //       ),
          //     ],
          //   ),
          // )
          
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_mate/chat_screen.dart';
import 'package:mentor_mate/components/request.dart';
import 'package:mentor_mate/doubts_list.dart';
import 'package:mentor_mate/models/models.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  static TextStyle _textStyle() {
    return TextStyle(
        fontFamily: "MontserratSB", fontSize: 24, color: Colors.black);
  }

  List<Widget> _subTiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addSubs();
    });
  }

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
          _listKey.currentState.insertItem(_subTiles.length - 1);
        });
      });
    });
  }

  Widget _buildTile(Sub sub) {
    return InkWell(
      radius: 320,
      splashColor: Colors.black.withOpacity(0.2),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, top: 12),
          child: Text(
            sub.name,
            style: _textStyle(),
          ),
        ),
      ),
    );
  }

  Tween<Offset> _offset = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    fontFamily: "MontserratB",
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Durgesh Kudalkar",
                  style: TextStyle(
                    fontFamily: "MontserratT",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Expanded(
                  child: AnimatedList(
                      key: _listKey,
                      initialItemCount: _subTiles.length,
                      itemBuilder: (context, index, animation) {
                        return SlideTransition(
                            position: animation.drive(_offset),
                            child: _subTiles[index]);
                      }),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            width: width,
            height: 50,
            child: Center(
              child: SvgPicture.asset(
                'assets/logo.svg',
                color: Color(0xFFe0e3e3).withOpacity(0.9),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

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
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black.withOpacity(0.3),
                    labelStyle: TextStyle(
                        fontFamily: "MontserratM",
                        fontSize: 16,
                        color: Colors.black),
                    unselectedLabelStyle: TextStyle(
                        fontFamily: "MontserratM",
                        fontSize: 16,
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
              DoubtPage(),
              DoubtPage(),
              DoubtPage(),
              DoubtPage(),
            ],
          ),
          Positioned(top: 70, child: RequestList())
        ]),
      ),
    );
  }
}

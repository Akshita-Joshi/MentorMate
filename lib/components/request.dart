import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/chat_screen.dart';
import 'package:mentor_mate/globals.dart';
import 'package:mentor_mate/models/models.dart';

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  List<Widget> _requestTiles = [];
  Tween<Offset> _offset = Tween(begin: Offset(0, -1), end: Offset(0, 0));
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addreq();
    });
  }

  void _addreq() {
    List<Request> req = [
      Request(student: "Durgesh Kudalkar"),
      Request(student: "Varun Lohade"),
    ];

    Future ft = Future(() {});
    req.forEach((Request req) {
      ft = ft.then((data) {
        return Future.delayed(const Duration(milliseconds: 10), () {
          _requestTiles.add(_buildTile(req));
          _listKey.currentState.insertItem(_requestTiles.length - 1);
        });
      });
    });
  }

  Widget _buildTile(Request req) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 80,
              width: width,
              decoration: BoxDecoration(
                  color: grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        child: SvgPicture.asset('assets/meet.svg'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Text(
                          '${req.student} has requested for a meet',
                          style: TextStyle(
                              fontFamily: "MontserratM", fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
          key: _listKey,
          initialItemCount: _requestTiles.length,
          itemBuilder: (context, index, animation) {
            return SlideTransition(
                position: animation.drive(_offset),
                child: _requestTiles[index]);
          }),
    );
  }
}

class RequestCard extends StatefulWidget {
  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

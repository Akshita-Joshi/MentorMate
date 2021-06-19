import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/chat_screen.dart';
import 'package:mentor_mate/globals.dart';

class BottomDrawer extends StatefulWidget {
  bool showMenu;
  BottomDrawer({this.showMenu});
  @override
  _BottomDrawerState createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  double doubtOpacity = 0;
  double doubtdesOpacity = 0;
  static AnimatedOpacity _label(double value, String text) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 120),
      opacity: value,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "MontserratM",
              fontSize: 14,
              color: Colors.black.withOpacity(0.3)),
        ),
      ),
    );
  }

  static TextStyle _hintText() {
    return TextStyle(
        fontFamily: "MontserratM",
        fontSize: 24,
        color: Colors.black.withOpacity(0.3));
  }

  static TextStyle _inputText1() {
    return TextStyle(
      fontFamily: "MontserratSB",
      fontSize: 24,
      color: Colors.black,
    );
  }

  static TextStyle _inputText2() {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: 18,
        color: Colors.black.withOpacity(0.6));
  }

  final ScrollController _scrollController = ScrollController();
  void _callOnTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
      left: 0,
      bottom: (widget.showMenu)
          ? -140 //-(height * 0.094) //-(height * 0.164)//80
          : -(height * 0.822), //140 and 700
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              height: height * 0.687, //500
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius:
                        widget.showMenu ? 500.0 : 0, //extend the shadow
                    offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.all(28), //40/*height * 0.047*/
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 1,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  Drawerclass.showMenu = false;
                                  widget.showMenu = false;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.black.withOpacity(0.05)),
                                child: Center(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            controller: _scrollController,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              _label(doubtOpacity, "Doubt title"),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 2,
                                style: _inputText1(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: _hintText(),
                                    hintText: "Doubt title"),
                                onChanged: (value) {
                                  setState(() {
                                    value != ''
                                        ? doubtOpacity = 1
                                        : doubtOpacity = 0;
                                  });
                                },
                                onFieldSubmitted: (value) {
                                  _callOnTop();
                                },
                              ),
                              SizedBox(height: 10),
                              _label(doubtdesOpacity, "Doubt description"),
                              TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                style: _inputText2(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: _hintText(),
                                    hintText: "Doubt description"),
                                onChanged: (value) {
                                  setState(() {
                                    value != ''
                                        ? doubtdesOpacity = 1
                                        : doubtdesOpacity = 0;
                                  });
                                },
                                onFieldSubmitted: (value) {
                                  _callOnTop();
                                },
                              ),
                              SizedBox(height: 30),
                              Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16,
                                          child: SvgPicture.asset(
                                              'assets/paperclip.svg'),
                                        ),
                                        SizedBox(width: 8),
                                        Text("Attach image",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 12,
                                                color: Colors.black))
                                      ],
                                    ),
                                  )))
                            ],
                          ),
                        )
                      ])))
        ],
      ),
    );
  }
}

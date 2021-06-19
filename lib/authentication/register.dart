import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  double nameOpacity = 0.0;
  double branchOpacity = 0.0;
  double divOpacity = 0.0;
  double rollOpacity = 0.0;
  double yearOpacity = 0.0;

  static TextStyle _hintText() {
    return TextStyle(
        fontFamily: "MontserratM",
        fontSize: 24,
        color: Colors.black.withOpacity(0.3));
  }

  static TextStyle _inputText() {
    return TextStyle(
        fontFamily: "MontserratM", fontSize: 24, color: Colors.black);
  }

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

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(alignment: Alignment.center, children: [
        Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 260,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.9), BlendMode.srcOver),
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/3.jpg'))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 56),
                      InkWell(
                        customBorder: new CircleBorder(),
                        splashColor: Colors.black.withOpacity(0.2),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            child: Center(
                                child: SvgPicture.asset('assets/back.svg'))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Register ",
                        style: TextStyle(
                          fontFamily: "MontserratB",
                          fontSize: 44,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ListView(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //--------------------------------
                      _label(nameOpacity, "Name"),
                      TextFormField(
                        style: _inputText(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: _hintText(),
                            hintText: "Name"),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? nameOpacity = 1 : nameOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      SizedBox(height: 10),
                      //--------------------------------
                      _label(yearOpacity, "Year"),
                      TextFormField(
                        style: _inputText(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: _hintText(),
                            hintText: "Year"),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? yearOpacity = 1 : yearOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      SizedBox(height: 10),
                      //--------------------------------
                      _label(branchOpacity, "Branch"),
                      TextFormField(
                        style: _inputText(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: _hintText(),
                            hintText: "Branch"),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? branchOpacity = 1 : branchOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      SizedBox(height: 10),
                      //--------------------------------
                      _label(divOpacity, "Division"),
                      TextFormField(
                        style: _inputText(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: _hintText(),
                            hintText: "Division"),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? divOpacity = 1 : divOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      SizedBox(height: 10),
                      //--------------------------------
                      _label(rollOpacity, "Roll No"),
                      TextFormField(
                        style: _inputText(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintStyle: _hintText(),
                            hintText: "Roll No"),
                        onChanged: (value) {
                          setState(() {
                            value != '' ? rollOpacity = 1 : rollOpacity = 0;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _callOnTop();
                        },
                      ),
                      SizedBox(
                        height: height / 2 - 300,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 100,
          bottom: 60,
          child: [
            nameOpacity,
            divOpacity,
            branchOpacity,
            yearOpacity,
            rollOpacity
          ].every((element) => element == 1.0)
              ? AnimatedTextKit(
                  pause: Duration(milliseconds: 1500),
                  repeatForever: true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentHome(),
                        ));
                  },
                  animatedTexts: [
                      TyperAnimatedText(
                        'Next →',
                        textStyle: TextStyle(
                          fontFamily: "MontserratSB",
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      )
                    ])
              : Container(),
        )
      ]),
    );
  }
}

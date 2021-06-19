import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_mate/authentication/login.dart';
import 'package:mentor_mate/authentication/register.dart';
import 'package:mentor_mate/authentication/signup.dart';
import 'package:mentor_mate/authentication/teacherlogin.dart';
import 'package:mentor_mate/globals.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final grey = const Color(0xFFe0e3e3).withOpacity(0.5);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
              top: 40,
              left: -10,
              child: SvgPicture.asset('assets/illustration1.svg')),
          Positioned(
              top: 240,
              child: Container(
                  width: width,
                  child: Center(child: SvgPicture.asset('assets/logo.svg')))),
          Positioned(
              top: 340,
              right: -10,
              child: SvgPicture.asset('assets/illustration2.svg')),
          Positioned(
            bottom: 60,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Authcheck.process = "signup";
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentorTeacher(),
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: width - 56,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontFamily: "MontserratSB",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Already a member?  ',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Authcheck.process = "login";
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentorTeacher(),
                              ));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontFamily: "MontserratB",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class StudentorTeacher extends StatefulWidget {
  @override
  _StudentorTeacherState createState() => _StudentorTeacherState();
}

class _StudentorTeacherState extends State<StudentorTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: InkWell(
                radius: 320,
                splashColor: Colors.black.withOpacity(0.2),
                onTap: () {},
                child: Container(
                  child: AnimatedTextKit(
                      onTap: () {
                        Authcheck.process == 'signup'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                      },
                      totalRepeatCount: 2,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          'Student',
                          textStyle: TextStyle(
                            fontFamily: "MontserratB",
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 1,
              color: Colors.black.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: InkWell(
                radius: 320,
                splashColor: Colors.black.withOpacity(0.2),
                onTap: () {},
                child: Container(
                  child: AnimatedTextKit(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherLogin(),
                            ));
                      },
                      totalRepeatCount: 2,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          'Teacher',
                          textStyle: TextStyle(
                            fontFamily: "MontserratB",
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

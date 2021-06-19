import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Doubts extends StatefulWidget {
  @override
  _DoubtsState createState() => _DoubtsState();
}

class _DoubtsState extends State<Doubts> {
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Durgesh Kudalkar',
                      style: TextStyle(
                          fontFamily: "MontserratM",
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        width: width,
                        color: grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 2, bottom: 10),
              child: Text(
                'CSE A 53',
                style: TextStyle(
                    fontFamily: "MontserratM",
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.3)),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8.0),
              child: Text("9:30 AM",
                  style: TextStyle(
                      fontFamily: "MontserratM",
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.3))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: grey,
                ),
                //border: Border.all(width: 1)),
                child: Center(
                  child: Text('Reply',
                      style: TextStyle(
                        fontFamily: "MontserratM",
                        fontSize: 15,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

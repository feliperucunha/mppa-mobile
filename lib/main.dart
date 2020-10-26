import 'package:flutter/material.dart';
import 'package:hello_world/interface1.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Color(0xFF1A237E)),
        home: IntroScreen());
  }
}

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        marginTitle: EdgeInsets.only(top: 120.0, bottom: 30.0),
        title: "",
        styleTitle: TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        marginDescription: EdgeInsets.only(left: 10.0, right: 10.0, top: 80.0),
        description:
            "Aplicativo prático para facilitar a verificação dos seus documentos via GEDOC.",
        styleDescription: TextStyle(
            color: Color(0xFF1A237E),
            fontSize: 25.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "images/GEDOC.png",
        widthImage: 200.0,
        heightImage: 100.0,
        colorBegin: Color(0xFFFFFFFF),
        colorEnd: Color(0xFF1A237E),
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Interface1()),
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xFFFFFFFF),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33000000),
      highlightColorDoneBtn: Color(0xff000000),

      // Dot indicator
      colorDot: Color(0xFFFFFFFF),
      colorActiveDot: Color(0xFFFFFFFF),
      sizeDot: 13.0,

      // Show or hide status bar
      shouldHideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}

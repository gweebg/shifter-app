import 'package:flutter/material.dart';
import 'package:shifter_webapp/widgets/desktop_navbar.dart';
import 'package:shifter_webapp/widgets/api_request_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 100),
            child: DesktopNavbar(opacity: _opacity)),
        body: const SingleChildScrollView(child: RequestForm()));
  }
}

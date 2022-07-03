import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shifter_webapp/helpers/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DesktopNavbarElement extends StatefulWidget {
  final String url;
  final String text;

  const DesktopNavbarElement({Key? key, required this.text, required this.url})
      : super(key: key);

  @override
  State<DesktopNavbarElement> createState() => _DesktopNavbarElementState();
}

class _DesktopNavbarElementState extends State<DesktopNavbarElement> {
  bool _isHovering = false;

  Future<void> _launchInBrowser(String url) async {
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering = true : _isHovering = false;
          });
        },
        onTap: () {
          _launchInBrowser(widget.url);
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 7),
          Text(widget.text,
              style: GoogleFonts.poppins(
                  fontSize: 20, color: _isHovering ? purple : brown)),
          const SizedBox(height: 5),
          Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: _isHovering,
              child: Container(height: 2, width: 20, color: purple))
        ]));
  }
}

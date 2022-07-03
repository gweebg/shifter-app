import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shifter_webapp/widgets/desktop_navbar_element.dart';

class DesktopNavbar extends StatefulWidget {
  final double opacity;

  const DesktopNavbar({Key? key, required this.opacity}) : super(key: key);

  @override
  State<DesktopNavbar> createState() => _DesktopNavbarState();
}

class _DesktopNavbarState extends State<DesktopNavbar> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        color: Colors.white.withOpacity(widget.opacity),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    //SizedBox(width: screenSize.width / 4),
                    const DesktopNavbarElement(
                        text: "Github",
                        url: "https://github.com/gweebg/shifter"),
                    SizedBox(width: screenSize.width / 15),
                    Text("Shifter",
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            color: const Color.fromRGBO(87, 74, 74, 1.0),
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: screenSize.width / 15),
                    const DesktopNavbarElement(
                        text: "Schedules",
                        url:
                            "https://alunos.uminho.pt/pt/estudantes/paginas/infouteishorarios.aspx"),
                  ]))
            ])));
  }
}

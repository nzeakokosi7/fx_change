import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Press extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color background;
  final Color foreground;
  final bool loading;


  Press.light(this.title, {this.onPressed, this.loading = false})
      : background = Colors.white,
        foreground = liveTextColor;

  Press.dark(this.title, {this.onPressed, this.loading = false})
      : background = const Color(0xFF191C32),
        foreground = white;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            child: loading
                ? const SizedBox(
                    child: CircularProgressIndicator(),
                    height: 25,
                    width: 25,
                  )
                : Text(
                    title,
                    style: GoogleFonts.poppins(
                        color: foreground, fontWeight: FontWeight.bold),
                  ),
            onPressed: loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
                minimumSize: Size(1.0.ofWidth, 50),
                primary: background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
        ),
      ],
    );
  }
}

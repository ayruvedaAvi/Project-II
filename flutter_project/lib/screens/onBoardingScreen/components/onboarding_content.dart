import 'package:flutter/material.dart';
import 'package:flutter_project/utils/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../onboarding_screen.dart';

class OnbordingContent extends StatelessWidget {
  const OnbordingContent({
    super.key,
    this.isTextOnTop = false,
    required this.title,
    required this.description,
    required this.image,
  });

  final bool isTextOnTop;
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        if (isTextOnTop)
          OnbordTitleDescription(
            title: title,
            description: description,
          ),
        if (isTextOnTop) const Spacer(),

        /// if you are using SVG then replace [Image.asset] with [SvgPicture.asset]

        Image.asset(
          image,
          height: 250,
        ),
        if (!isTextOnTop) const Spacer(),
        if (!isTextOnTop)
          const OnbordTitleDescription(
            title: "Find the job \nyou're capable of",
            description:
                "Here, you can find a job that suits your skills, and you can apply for it with just a click.",
          ),

        const Spacer(),
      ],
    );
  }
}

class OnbordTitleDescription extends StatelessWidget {
  const OnbordTitleDescription({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            textAlign: TextAlign.center,
            // style: Theme.of(context)
            //     .textTheme
            //     .headlineSmall!
            //     .copyWith(fontWeight: FontWeight.w500),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: disabledForegroundColor,
              fontFamily: GoogleFonts.ubuntu().fontFamily,

            )),
        const SizedBox(height: defaultPadding),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBackgroundColor,
            fontFamily: GoogleFonts.ubuntu().fontFamily,
          ),
        ),
      ],
    );
  }
}

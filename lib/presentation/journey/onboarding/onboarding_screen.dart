import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p_borrower/common/constants/image_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';
import 'package:p2p_borrower/presentation/common/package_widgets/introduction_screen/introduction_screen.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding_constants.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushReplacementNamed(context, AuthenticationRoute.inputPhoneID);
  }

  Widget _buildImage(
    String assetName,
  ) {
    return Image.asset(
      assetName,
      fit: BoxFit.cover,
      height: OnBoardingConstants.heightPicture,
      width: ScreenUtil().screenWidth,
    );
  }

  Widget _buildTextButton(String content) {
    return Text(
      content,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: mColorBodyTextGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline3!,
      bodyTextStyle: Theme.of(context)
          .textTheme
          .textDescriptionBlackNormal,
      pageColor: mColorBackground,
    );

    return AnnotatedRegion(
      value: SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
      sized: false,
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: mColorBackground,
        pages: [
          PageViewModel(
            title: S.current.boarding1Title,
            body: S.current.boarding1Msg,
            image: _buildImage(ImageConstants.image),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: S.current.boarding2Title,
            body: S.current.boarding2Msg,
            image: _buildImage(ImageConstants.image1),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: S.current.boarding3Title,
            body: S.current.boarding3Msg,
            image: _buildImage(ImageConstants.image2),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: _buildTextButton(
          S.current.skip.toUpperCase(),
        ),
        next: _buildTextButton(
          S.current.next.toUpperCase(),
        ),
        done: _buildTextButton(
          S.current.start.toUpperCase(),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        dotsDecorator: DotsDecorator(
          size: Size(4.0.w, 4.0.w),
          color: mColorPlaceholder,
          spacing: EdgeInsets.symmetric(horizontal: 2.w),
          activeSize: Size(11.0.w, 4.0.w),
          activeColor: mColorDots,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
          ),
        ),
      ),
    );
  }
}

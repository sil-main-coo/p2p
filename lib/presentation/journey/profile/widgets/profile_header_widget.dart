import 'package:flutter/material.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/data/model/response/facebook_info_response.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/cubit/connect_social_cubit.dart';

class ProfileHeaderWidget extends StatelessWidget {
  ProfileHeaderWidget({Key? key}) : super(key: key);

  FacebookInfoResponse _fbProfile = FacebookInfoResponse();
  final _phoneUser = SessionPref.getUserName();

  @override
  Widget build(BuildContext context) {
    final connectSocialState = context.watch<ConnectSocialCubit>().state;

    if (connectSocialState is ConnectSocialLogged) {
      _fbProfile = connectSocialState.fbProfile;
    }

    return Column(
      children: [
        Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            image: _fbProfile.pictureUInt8List != null
                ? DecorationImage(
                    image: MemoryImage(_fbProfile.pictureUInt8List!),
                    fit: BoxFit.cover,
                  )
                : null,
            borderRadius: BorderRadius.all(Radius.circular(90)),
            border: Border.all(
              color: mColorBordersLines,
              width: 2.0,
            ),
          ),
          child: _fbProfile.picture == null
              ? Icon(
                  Icons.person,
                  size: 32.w,
                  color: mPrimaryColor,
                )
              : null,
        ),
        VerticalSpace.init16(),
        if (_fbProfile.name != null)
          Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: Text(
                _fbProfile.name!,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.w600),
              )),
        Text(
          _phoneUser!,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: mColorSubtext),
        )
      ],
    );
  }
}

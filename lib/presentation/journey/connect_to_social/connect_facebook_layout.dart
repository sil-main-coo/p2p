import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_navigator_widget.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/widgets/connect_social_bottom_sheet.dart';

import 'cubit/connect_social_cubit.dart';

class ConnectFacebookLayout extends StatelessWidget {
  ConnectFacebookLayout({Key? key}) : super(key: key);

  final _loadingDialog = AppLoadingDialog();

  void _showFailureDialog(BuildContext context, String error) {
    ActionDialogs.showAction(
        context: context,
        message: error,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderCubit, LoaderState>(
      bloc: BlocProvider.of<ConnectSocialCubit>(context).loaderCubit,
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoaderLoaded:
            _loadingDialog.popDialog();
            break;
          case LoaderSuccess:
            break;
          case LoaderFailure:
            _showFailureDialog(context, (state as LoaderFailure).messages[0]);
            break;
          default:
            _loadingDialog.showDefault(context);
        }
      },
      child: CompactLayout(
        child: Column(
          children: [
            _listTileFacebookInfo(context),
            VerticalSpace.init8(),
            Text(
              S.current.connectFacebookNote,
              style: Theme.of(context).textTheme.textSub,
            )
          ],
        ),
      ),
    );
  }

  Widget _listTileFacebookInfo(BuildContext context) {
    return BlocBuilder<ConnectSocialCubit, ConnectSocialState>(
      builder: (context, state) {
        if (state is ConnectSocialLogged) {
          return AppListTileNavigatorWidget(
            leadingIcon: Image.memory(state.fbProfile.pictureUInt8List!),
            paddingIcon: EdgeInsets.zero,
            label: S.current.connectFacebookAccount,
            title: state.fbProfile.name != null ? state.fbProfile.name! : '',
            actionIcon: SvgPicture.asset(
              IconConstants.icDetail,
              color: mColorIconGreen,
              width: 16.w,
              height: 16.w,
            ),
            callBack: () => ConnectSocialBottomSheet.show(
                context: context,
                changeFacebookAccount: () =>
                    BlocProvider.of<ConnectSocialCubit>(context)
                        .connectToFacebook()),
          );
        }
        return AppListTileNavigatorWidget(
          title: S.current.connectWithFacebook,
          leadingIcon: SvgPicture.asset(
            IconConstants.icFacebook,
          ),
          colorBgIcon: mColorFacebook,
          label: S.current.connectFacebookAccount,
          callBack: () =>
              BlocProvider.of<ConnectSocialCubit>(context).connectToFacebook(),
        );
      },
    );
  }
}

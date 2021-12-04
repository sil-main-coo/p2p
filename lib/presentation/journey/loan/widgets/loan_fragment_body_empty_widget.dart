import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/presentation/common/components/items/container_borders/circle_border_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/widgets/confirm_before_create_loan_dialog.dart';

class LoanFragmentBodyEmptyWidget extends StatelessWidget {
  const LoanFragmentBodyEmptyWidget({Key? key, required this.loanProducts})
      : super(key: key);

  final List<LoanProductsResponse> loanProducts;

  void _onTapLoanItem(BuildContext context, LoanProductsResponse item) {
    ConfirmBeforeCreateLoanDialog.showConfirmBeforeCreateLoan(context, item);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24.h) / 3;
    final double itemWidth = size.width / 3;

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 3,
          crossAxisSpacing: 24.w),
      itemCount: loanProducts.length,
      itemBuilder: (BuildContext context, int index) =>
          _itemWidget(context, loanProducts[index]),
    );
  }

  Widget _itemWidget(BuildContext context, LoanProductsResponse item) {
    final titleStyle = Theme.of(context).textTheme.textTitleItemLoanProduct;
    final subTitleStyle = Theme.of(context).textTheme.caption;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _onTapLoanItem(context, item),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleBorderWidget(
              height: 50.w,
              width: 50.w,
              child: SvgPicture.network(
                item.iconPath!,
                cacheColorFilter: true,
                color: mColorBodyText,
              ),
            ),
            VerticalSpace.init8(),
            Text(
              item.name!,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
            VerticalSpace.init4(),
            Text(
              '${item.minimumAmount!}-${item.maximumAmount!} ${item.amountUnitTranslated}',
              style: subTitleStyle,
            ),
          ],
        ),
      ),
    );
  }

}

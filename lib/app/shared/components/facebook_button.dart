import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacebookButton extends StatelessWidget {
  final GestureTapCallback onTap;
  const FacebookButton({Key key, @required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF4267B3),
        ),
        height: 45,
        width: ScreenUtil.screenWidthDp * .85,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 2,
              ),
              child: Icon(
                FontAwesome5Brands.facebook_f,
                color: Colors.white,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Conectar com Facebook',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
                textScaleFactor: ScreenUtil().scaleText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant.dart';

Widget buildShimmer(BuildContext context) {
  final mq = MediaQuery.of(context).size;

  return Container(
    height: mq.height * 0.26,
    width: mq.width,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    decoration: BoxDecoration(
      color: Color.fromRGBO(33, 64, 74, 1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: kSecondaryColor.withOpacity(0.5),
          highlightColor: kSecondaryColor.withOpacity(0.8),
          child: Container(
            height: mq.height * 0.12,
            width: mq.width * 0.25,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: kSecondaryColor.withOpacity(0.5),
              highlightColor: kSecondaryColor.withOpacity(0.8),
              child: Container(
                margin: EdgeInsets.all(5),
                height: mq.height * 0.01,
                width: mq.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: kSecondaryColor.withOpacity(0.5),
              highlightColor: kSecondaryColor.withOpacity(0.8),
              child: Container(
                margin: EdgeInsets.all(5),
                height: mq.height * 0.01,
                width: mq.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: kSecondaryColor.withOpacity(0.5),
              highlightColor: kSecondaryColor.withOpacity(0.8),
              child: Container(
                margin: EdgeInsets.all(5),
                height: mq.height * 0.01,
                width: mq.width * 0.32,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rootally_ai/constants/app_colors.dart';
import 'package:rootally_ai/utils/helper.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SessionTileUI extends StatelessWidget {
  final int index, itemCount;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const SessionTileUI(
      {Key? key,
      required this.index,
      required this.itemCount,
      required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: index == 0,
      isLast: index == itemCount - 1,
      afterLineStyle: index != itemCount - 1
          ? snapshot.data!.docs.elementAt(index + 1)["completed"]
              ? const LineStyle(color: AppColors.primaryColor)
              : const LineStyle(
                  color: AppColors.greyColor,
                )
          : const LineStyle(color: AppColors.primaryColor),
      beforeLineStyle: snapshot.data!.docs.elementAt(index)["completed"]
          ? const LineStyle(color: AppColors.primaryColor)
          : const LineStyle(
              color: AppColors.greyColor,
            ),
      indicatorStyle: snapshot.data!.docs.elementAt(index)["completed"]
          ? IndicatorStyle(
              color: AppColors.primaryColor,
              height: 20,
              width: 20,
              iconStyle: IconStyle(
                iconData: Icons.check,
                color: AppColors.whiteColor,
                fontSize: 14,
              ),
            )
          : IndicatorStyle(
              color: AppColors.greyColor,
              drawGap: true,
              indicator: Container(
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: AppColors.greyColor,
                      width: 3,
                    ),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
      endChild: sessionTile(
        index,
        snapshot.data!.docs.elementAt(index),
      ),
    );
  }

  Widget sessionTile(int index, QueryDocumentSnapshot snapshot) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.greyColor,
          width: 1,
        ),
      ),
      height: 140,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snapshot["name"],
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  snapshot["description"],
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.2,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              emptyVerticalBox(height: 5),
              snapshot["completed"]
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      height: 25,
                      child: const Center(
                        child: Text(
                          "Completed",
                          style: TextStyle(
                              color: AppColors.whiteColor, fontSize: 12),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.play_arrow_outlined,
                          color: AppColors.greyColor,
                        ),
                        Text(
                          "Finish session\n$index to start",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.greyColor,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
              emptyVerticalBox(height: 5),
              snapshot["completed"]
                  ? const Text(
                      "Performed at\n8:12 AM",
                      style: TextStyle(
                        height: 1,
                        fontSize: 12,
                        color: AppColors.greyColor,
                      ),
                    )
                  : Container(),
            ],
          ),
          emptyHorizontalBox(width: 30),
          Expanded(
            child: Image.asset(
              "assets/$index.png",
            ),
          ),
        ],
      ),
    );
  }
}

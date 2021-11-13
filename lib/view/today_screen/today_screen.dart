import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rootally_ai/constants/app_colors.dart';
import 'package:rootally_ai/utils/helper.dart';
import 'package:rootally_ai/view/today_screen/session_tile.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _sessionsStream = FirebaseFirestore.instance
        .collection('sessions')
        .orderBy("name")
        .snapshots();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              emptyVerticalBox(height: 50),
              const Text(
                "Good Morning \nJane",
                style: TextStyle(
                  fontSize: 30,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              emptyVerticalBox(),
              const Text(
                "You have 4 sessions \ntoday!",
                style: TextStyle(
                  fontSize: 18,
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greyColor,
                ),
              ),
              emptyVerticalBox(height: 30),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _sessionsStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.secondaryColor),
                        ),
                      );
                    }
                    int itemCount = snapshot.data!.docs.length;
                    return ListView.builder(
                      itemCount: itemCount + 1,
                      itemBuilder: (context, index) => itemCount != index
                          ? SessionTileUI(
                              index: index,
                              itemCount: itemCount,
                              snapshot: snapshot,
                            )
                          : emptyVerticalBox(height: 70),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.secondaryColor,
                  width: 3,
                ),
              ),
              height: 50,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.play_arrow,
                    color: AppColors.whiteColor,
                    size: 30,
                  ),
                  Text(
                    "Start Session",
                    style: TextStyle(fontSize: 14, color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

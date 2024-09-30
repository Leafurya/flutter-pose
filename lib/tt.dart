import 'package:flutter/material.dart';
import 'package:forth/pose_detect/painters/pose_painter.dart';

import 'pose_detect/pose_detector_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google ML Kit Demo App'),
          centerTitle: true,
          elevation: 0,
        ),
        body: PoseDetectorView(),
        bottomNavigationBar: Row(
          children: [
            TextButton(
                onPressed: () {
                  PosePainter.nowPose = NowPoses.standing;
                },
                child: Text("스탠딩 측면")),
            TextButton(
                onPressed: () {
                  PosePainter.nowPose = NowPoses.overheadDeepSquat;
                },
                child: Text("스쿼트 측면")),
            TextButton(
                onPressed: () {
                  PosePainter.nowPose = NowPoses.standingForwardBend;
                },
                child: Text("땅짚기 측면")),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ));
  }
}

// class CustomCard extends StatelessWidget {
//   final String _label;
//   final Widget _viewPage;
//   final bool featureCompleted;

//   const CustomCard(this._label, this._viewPage, {this.featureCompleted = true});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       margin: EdgeInsets.only(bottom: 10),
//       child: ListTile(
//         tileColor: Theme.of(context).primaryColor,
//         title: Text(
//           _label,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         onTap: () {
//           if (!featureCompleted) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('This feature has not been implemented yet')));
//           } else {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => _viewPage));
//           }
//         },
//       ),
//     );
//   }
// }

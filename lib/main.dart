import 'package:flutter/material.dart';
import 'pose_detect/painters/pose_painter.dart';
import 'pose_detect/pose_detector_view.dart';

Future<void> main() async {
  // 이 줄에 브레이크포인트를 설정합니다
  try {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  } catch (e, stackTrace) {
    print('Error during app initialization: $e');
    print('Stack trace: $stackTrace');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ErrorBoundary(child: Home()),
    );
  }
}

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  ErrorBoundary({required this.child});

  @override
  _ErrorBoundaryState createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool hasError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 여기에 필요한 초기화 코드를 추가하세요
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Scaffold(
        body: Center(
          child: Text('An error occurred. Please restart the app.'),
        ),
      );
    }
    return widget.child;
  }

  @override
  void catchError(Object error, StackTrace stackTrace) {
    setState(() {
      hasError = true;
    });
    print('Error caught by error boundary: $error');
    print('Stack trace: $stackTrace');
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NowPoses currentPose = NowPoses.standing;

  void changePose(NowPoses newPose) {
    setState(() {
      currentPose = newPose;
      PosePainter.nowPose = newPose;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: PoseDetectorView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: NowPoses.values.indexOf(currentPose),
        onTap: (index) => changePose(NowPoses.values[index]),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            label: '스탠딩 측면',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: '스쿼트 측면',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            label: '땅짚기 측면',
          ),
        ],
      ),
    );
  }
}

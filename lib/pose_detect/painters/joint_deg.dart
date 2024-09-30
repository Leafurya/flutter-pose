import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math';

class JointDeg {
  final Pose pose;

  JointDeg(this.pose);

  String? getLeftHip() {
    double? deg = findAngle(pose.landmarks[PoseLandmarkType.leftKnee], pose.landmarks[PoseLandmarkType.leftHip], pose.landmarks[PoseLandmarkType.leftShoulder]);
    return (deg == null) ? null : deg.toStringAsFixed(1);
  }

  String? getRightHip() {
    double? deg = findAngle(pose.landmarks[PoseLandmarkType.rightKnee], pose.landmarks[PoseLandmarkType.rightHip], pose.landmarks[PoseLandmarkType.rightShoulder]);
    return (deg == null) ? null : deg.toStringAsFixed(1);
  }

  String? getRightKnee() {
    double? deg = findAngle(pose.landmarks[PoseLandmarkType.rightAnkle], pose.landmarks[PoseLandmarkType.rightKnee], pose.landmarks[PoseLandmarkType.rightHip]);
    return (deg == null) ? null : deg.toStringAsFixed(1);
  }

  String? getRightHeel() {
    double? deg = findAngle(pose.landmarks[PoseLandmarkType.rightKnee], pose.landmarks[PoseLandmarkType.rightHeel], pose.landmarks[PoseLandmarkType.rightFootIndex]);
    return (deg == null) ? null : deg.toStringAsFixed(1);
  }

  String? getRightSholder() {
    double? deg = findAngle(pose.landmarks[PoseLandmarkType.rightHip], pose.landmarks[PoseLandmarkType.rightShoulder], pose.landmarks[PoseLandmarkType.rightElbow]);
    return (deg == null) ? null : deg.toStringAsFixed(1);
  }

  String? getRightNeck() {
    double? deg = findAngle(pose.landmarks[PoseLandmarkType.rightHip], pose.landmarks[PoseLandmarkType.rightShoulder], pose.landmarks[PoseLandmarkType.rightEar]);
    return (deg == null) ? null : deg.toStringAsFixed(1);
  }

  // 세 점이 이루는 각도를 구하는 함수 (라디안 값을 반환)
  double? findAngle(PoseLandmark? A, PoseLandmark? B, PoseLandmark? C) {
    if (A == null || B == null || C == null) {
      return null;
    }
    // 벡터 AB와 BC 구하기
    double AB_x = A.x - B.x;
    double AB_y = A.y - B.y;
    double BC_x = C.x - B.x;
    double BC_y = C.y - B.y;

    // 벡터 AB와 BC의 내적 구하기
    double dot = dotProduct(AB_x, AB_y, BC_x, BC_y);

    // 벡터 AB와 BC의 크기 구하기
    double magnitudeAB = vectorMagnitude(AB_x, AB_y);
    double magnitudeBC = vectorMagnitude(BC_x, BC_y);

    // 각도를 구하기 위해 내적 공식 사용
    double cosTheta = dot / (magnitudeAB * magnitudeBC);

    // 아크 코사인을 사용하여 각도를 라디안으로 구함
    double angleRadians = acos(cosTheta);

    // 라디안 값을 도(degree)로 변환
    double angleDegrees = angleRadians * (180.0 / pi);

    return angleDegrees;
  }

  double dotProduct(double x1, double y1, double x2, double y2) {
    return x1 * x2 + y1 * y2;
  }

  // 벡터의 크기를 구하는 함수
  double vectorMagnitude(double x, double y) {
    return sqrt(x * x + y * y);
  }
}

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unlimited_canvas_plan2/view_model/white_board_view_model.dart';
import 'package:unlimited_canvas_plan2/const/const_string.dart';

/// 背景层Widget
class BackgroundLayerWidget extends StatelessWidget {
  const BackgroundLayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhiteBoardViewModel>(
      id: ConstString.backgroundLayerWidgetId,
      builder: (WhiteBoardViewModel whiteBoardViewModel) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              whiteBoardViewModel.curCanvasOffset.dx,
              whiteBoardViewModel.curCanvasOffset.dy,
            )
            ..scale(whiteBoardViewModel.curCanvasScale),
          child: RepaintBoundary(
            child: CustomPaint(
              isComplex: true,
              painter: _BackgroundLayerPainter(),
            ),
          ),
        );
      },
    );
  }
}

class _BackgroundLayerPainter extends CustomPainter {
  final WhiteBoardViewModel _whiteBoardViewModel =
      Get.find<WhiteBoardViewModel>();

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("BackgroundLayerWidget===repaint");

    _drawDot(canvas);
  }

  @override
  bool shouldRepaint(covariant _BackgroundLayerPainter oldDelegate) {
    return true;
  }

  void _drawDot(Canvas canvas) {
    double dotRadius = 2;
    double dotSpace = 40;

    // 1/4屏的大小
    Size fakeVisibleAreaSize = _whiteBoardViewModel.visibleAreaSize / 2;
    // 缩放的时候影响fake大小
    fakeVisibleAreaSize /= _whiteBoardViewModel.curCanvasScale;

    // 右下角1/4屏
    // 平移的时候影响fake大小
    Size rightBottomFakeVisibleAreaSize = Size(
      fakeVisibleAreaSize.width +
          (_whiteBoardViewModel.visibleAreaCenter.dx -
                  _whiteBoardViewModel.curCanvasOffset.dx) /
              _whiteBoardViewModel.curCanvasScale,
      fakeVisibleAreaSize.height +
          (_whiteBoardViewModel.visibleAreaCenter.dy -
                  _whiteBoardViewModel.curCanvasOffset.dy) /
              _whiteBoardViewModel.curCanvasScale,
    );
    Rect rightBottomRect = Rect.fromLTWH(
      0,
      0,
      rightBottomFakeVisibleAreaSize.width,
      rightBottomFakeVisibleAreaSize.height,
    );
    debugPrint(
        "rightBottomRect===>${Offset(rightBottomRect.left, rightBottomRect.top)} $rightBottomFakeVisibleAreaSize");
    if (rightBottomFakeVisibleAreaSize > Size.zero) {
      for (double x = rightBottomRect.left;
          x <= rightBottomRect.left + rightBottomRect.width;
          x += dotSpace) {
        for (double y = rightBottomRect.top;
            y <= rightBottomRect.top + rightBottomRect.height;
            y += dotSpace) {
          canvas.drawCircle(
            Offset(
              x,
              y,
            ),
            dotRadius,
            Paint(),
          );
        }
      }
    }

    // 右上角1/4屏
    Size rightTopFakeVisibleAreaSize = Size(
      fakeVisibleAreaSize.width +
          (_whiteBoardViewModel.visibleAreaCenter.dx -
                  _whiteBoardViewModel.curCanvasOffset.dx) /
              _whiteBoardViewModel.curCanvasScale,
      fakeVisibleAreaSize.height -
          (_whiteBoardViewModel.visibleAreaCenter.dy -
                  _whiteBoardViewModel.curCanvasOffset.dy) /
              _whiteBoardViewModel.curCanvasScale,
    );
    Rect rightTopRect = Rect.fromLTWH(
      0,
      -rightTopFakeVisibleAreaSize.height,
      rightTopFakeVisibleAreaSize.width,
      rightTopFakeVisibleAreaSize.height,
    );
    debugPrint(
        "rightTopRect===>${Offset(rightTopRect.left, rightTopRect.top)} $rightTopFakeVisibleAreaSize");
    if (rightTopFakeVisibleAreaSize > Size.zero) {
      for (double x = rightTopRect.left + dotSpace;
          x <= rightTopRect.left + rightTopRect.width;
          x += dotSpace) {
        for (double y = rightTopRect.top + rightTopRect.height - dotSpace;
            y >= rightTopRect.top;
            y -= dotSpace) {
          canvas.drawCircle(
            Offset(
              x,
              y,
            ),
            dotRadius,
            Paint(),
          );
        }
      }
    }

    // 左上角1/4屏
    Size leftTopFakeVisibleAreaSize = Size(
      fakeVisibleAreaSize.width -
          (_whiteBoardViewModel.visibleAreaCenter.dx -
                  _whiteBoardViewModel.curCanvasOffset.dx) /
              _whiteBoardViewModel.curCanvasScale,
      fakeVisibleAreaSize.height -
          (_whiteBoardViewModel.visibleAreaCenter.dy -
                  _whiteBoardViewModel.curCanvasOffset.dy) /
              _whiteBoardViewModel.curCanvasScale,
    );
    Rect leftTopRect = Rect.fromLTWH(
      -leftTopFakeVisibleAreaSize.width,
      -leftTopFakeVisibleAreaSize.height,
      leftTopFakeVisibleAreaSize.width,
      leftTopFakeVisibleAreaSize.height,
    );
    debugPrint(
        "leftTopRect===>${Offset(leftTopRect.left, leftTopRect.top)} $leftTopFakeVisibleAreaSize");
    if (leftTopFakeVisibleAreaSize > Size.zero) {
      for (double x = leftTopRect.left + leftTopRect.width;
          x >= -leftTopRect.width;
          x -= dotSpace) {
        for (double y = leftTopRect.top + leftTopRect.height;
            y >= -leftTopRect.height;
            y -= dotSpace) {
          canvas.drawCircle(
            Offset(
              x,
              y,
            ),
            dotRadius,
            Paint(),
          );
        }
      }
    }

    // 左下角1/4屏
    Size leftBottomFakeVisibleAreaSize = Size(
      fakeVisibleAreaSize.width -
          (_whiteBoardViewModel.visibleAreaCenter.dx -
                  _whiteBoardViewModel.curCanvasOffset.dx) /
              _whiteBoardViewModel.curCanvasScale,
      fakeVisibleAreaSize.height +
          (_whiteBoardViewModel.visibleAreaCenter.dy -
                  _whiteBoardViewModel.curCanvasOffset.dy) /
              _whiteBoardViewModel.curCanvasScale,
    );
    Rect leftBottomRect = Rect.fromLTWH(
      -leftBottomFakeVisibleAreaSize.width,
      0,
      leftBottomFakeVisibleAreaSize.width,
      leftBottomFakeVisibleAreaSize.height,
    );
    debugPrint(
        "leftBottomRect===>${Offset(leftBottomRect.left, leftBottomRect.top)} $leftBottomFakeVisibleAreaSize");
    if (leftBottomFakeVisibleAreaSize > Size.zero) {
      for (double x = leftBottomRect.left + leftBottomRect.width - dotSpace;
          x >= -leftBottomRect.width;
          x -= dotSpace) {
        for (double y = leftBottomRect.top + dotSpace;
            y <= leftBottomRect.top + leftBottomRect.height;
            y += dotSpace) {
          canvas.drawCircle(
            Offset(
              x,
              y,
            ),
            dotRadius,
            Paint(),
          );
        }
      }
    }
  }
}

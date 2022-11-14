import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unlimited_canvas_plan2/algorithm/algorithm_util.dart';
import 'package:unlimited_canvas_plan2/const/const_string.dart';
import 'package:unlimited_canvas_plan2/view_model/white_board_view_model.dart';
import 'package:unlimited_canvas_plan2/model/graphics_element_model.dart';

/// 图形层Widget
class GraphicsLayerWidget extends StatelessWidget {
  const GraphicsLayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhiteBoardViewModel>(
      id: ConstString.graphicsLayerPainterId,
      builder: (_) {
        return Container(
          color: Colors.red.withOpacity(0.5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RepaintBoundary(
            child: CustomPaint(
              isComplex: true,
              painter: _GraphicsLayerPainter(),
            ),
          ),
        );
      },
    );
  }
}

class _GraphicsLayerPainter extends CustomPainter {
  final WhiteBoardViewModel _whiteBoardViewModel =
      Get.find<WhiteBoardViewModel>();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(
      _whiteBoardViewModel.curCanvasOffset.dx,
      _whiteBoardViewModel.curCanvasOffset.dy,
    );
    canvas.scale(
      _whiteBoardViewModel.curCanvasScale,
      _whiteBoardViewModel.curCanvasScale,
    );

    for (GraphicsElementModel graphicsElementModel
        in _whiteBoardViewModel.graphicsElementModelList) {
      canvas.drawRect(
        Rect.fromPoints(
          graphicsElementModel.p1,
          graphicsElementModel.p2,
        ),
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GraphicsLayerPainter oldDelegate) {
    return true;
  }
}

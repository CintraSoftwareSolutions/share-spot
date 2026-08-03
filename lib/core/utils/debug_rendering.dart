import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

bool _debugRenderingGuardInstalled = false;

const _defaultDebugRepaintColor = HSVColor.fromAHSV(0.4, 60, 1, 1);

bool get _debugRenderingOverlayIsEnabled =>
    debugPaintBaselinesEnabled ||
    debugPaintSizeEnabled ||
    debugPaintLayerBordersEnabled ||
    debugPaintTextLayoutBoxes ||
    debugPaintPointersEnabled ||
    debugRepaintRainbowEnabled ||
    debugRepaintTextRainbowEnabled ||
    debugCurrentRepaintColor != _defaultDebugRepaintColor;

void _clearDebugRenderingOverlays() {
  debugPaintBaselinesEnabled = false;
  debugPaintSizeEnabled = false;
  debugPaintLayerBordersEnabled = false;
  debugPaintTextLayoutBoxes = false;
  debugPaintPointersEnabled = false;
  debugRepaintRainbowEnabled = false;
  debugRepaintTextRainbowEnabled = false;
  debugCurrentRepaintColor = _defaultDebugRepaintColor;
}

void _forceCleanRepaint() {
  late RenderObjectVisitor markNeedsPaint;
  markNeedsPaint = (RenderObject child) {
    child.markNeedsPaint();
    child.visitChildren(markNeedsPaint);
  };

  for (final renderView in RendererBinding.instance.renderViews) {
    renderView.visitChildren(markNeedsPaint);
  }
  SchedulerBinding.instance.scheduleFrame();
}

/// Flutter binding used by the application in debug mode.
///
/// Flutter registers its normal [drawFrame] callback before callbacks added by
/// the application. Clearing Inspector flags from a later persistent callback
/// can therefore happen after the yellow baselines have already been painted.
/// This binding clears them immediately before Flutter paints every frame.
class ShareSpotWidgetsBinding extends WidgetsFlutterBinding {
  @override
  void drawFrame() {
    assert(() {
      _clearDebugRenderingOverlays();
      return true;
    }());
    super.drawFrame();
  }
}

/// Installs [ShareSpotWidgetsBinding] only for debug builds.
///
/// In profile and release builds the assert is compiled out and Flutter's
/// standard binding is used, so this protection has no release-frame overhead.
void initializeShareSpotBinding() {
  assert(() {
    ShareSpotWidgetsBinding();
    return true;
  }());
  WidgetsFlutterBinding.ensureInitialized();
}

/// Keeps Flutter Inspector paint overlays disabled during debug builds.
///
/// Inspector toggles can be restored after [main] runs or during a hot reload.
/// The persistent callback catches that state on the next frame, clears it, and
/// requests one clean repaint. Assertions remove the entire guard in release.
void installDebugRenderingGuard() {
  assert(() {
    final overlayWasEnabled = _debugRenderingOverlayIsEnabled;
    _clearDebugRenderingOverlays();
    if (overlayWasEnabled) {
      _forceCleanRepaint();
    }

    if (!_debugRenderingGuardInstalled) {
      _debugRenderingGuardInstalled = true;
      SchedulerBinding.instance.addPersistentFrameCallback((_) {
        if (!_debugRenderingOverlayIsEnabled) {
          return;
        }

        _clearDebugRenderingOverlays();
        _forceCleanRepaint();
      });
    }

    return true;
  }());
}

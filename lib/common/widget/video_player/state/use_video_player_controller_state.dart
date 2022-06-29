import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController? useVideoControllerState({
  required String? path,
  required bool isPlaying,
  required bool isSound,
}) {
  final controllerState = useState<VideoPlayerController?>(null);
  useEffect(() {
    controllerState.value = null;
    if (path != null) {
      final controller = VideoPlayerController.network(path);
      controller.initialize().then((_) => controllerState.value = controller);
      return () => controller.dispose();
    }
  }, [path]);
  useEffect(() {
    if (controllerState.value != null) {
      if (isPlaying)
        controllerState.value!.play();
      else
        controllerState.value!.pause();
      if (isSound)
        controllerState.value!.setVolume(1);
      else
        controllerState.value!.setVolume(0);
    }
  }, [controllerState.value, isPlaying, isSound]);

  return controllerState.value;
}

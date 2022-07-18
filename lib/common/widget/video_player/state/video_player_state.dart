import 'package:app/common/widget/video_player/state/player_video_data.dart';
import 'package:app/common/widget/video_player/state/video_player_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerState {
  final VideoPlayerController? controller;
  final int progress;
  final int total;
  final bool isSound;
  final bool isFinished;
  final bool isPlaying;
  final bool isWaiting;
  final bool areControlsVisible;
  final bool showThumbnail;
  final bool isFullscreen;
  final Function() toggleControlsVisibility;
  final Function() togglePlaying;
  final Function() toggleVolume;
  final Function() repeat;
  final Function() toggleFullscreen;
  final Function(int) seekTo;
  final FocusNode focusNode;

  const VideoPlayerState({
    required this.seekTo,
    required this.controller,
    required this.total,
    required this.progress,
    required this.isWaiting,
    required this.areControlsVisible,
    required this.toggleControlsVisibility,
    required this.togglePlaying,
    required this.isFinished,
    required this.isPlaying,
    required this.repeat,
    required this.isSound,
    required this.toggleVolume,
    required this.showThumbnail,
    required this.focusNode,
    required this.toggleFullscreen,
    required this.isFullscreen,
  });
}

final dummyListenable = ValueNotifier<VideoPlayerValue?>(null);

VideoPlayerState useVideoPlayerState({
  required String videoPath,
  String? thumbnail,
  required bool isFullscreen,
  bool autoplay = false,
  bool looping = false,
  bool mute = true,
  bool isInView = true,
  bool showControls = true,
  Function(bool)? onTogglePlay,
  Function(String, String)? navigateToFullScreen,
}) {
  compute(int end) {
    return PlayerVideoData(path: videoPath, end: end, start: 0);
  }

  final context = useContext();

  final isStartedState = useState<bool>(autoplay && isInView);
  final FocusNode focusNode = useMemoized(() => FocusNode());

  final isPlayingState = useState<bool>(autoplay);
  final isSoundState = useState<bool>(!mute);
  final areControlsVisibilityState = useState<bool>(showControls && !autoplay);
  final pendingSeekMsState = useState<int?>(null);
  final controllerA = useVideoControllerState(
    path: isStartedState.value ? videoPath : null,
    isPlaying: isPlayingState.value && pendingSeekMsState.value == null,
    isSound: isSoundState.value,
  );

  final computedData = useState<PlayerVideoData>(compute(controllerA != null ? controllerA.value.duration.inMilliseconds : 0));

  useEffect(() {
    computedData.value = compute(controllerA != null ? controllerA.value.duration.inMilliseconds : 100);
  }, [controllerA?.value.isInitialized]);

  useListenable(computedData);
  final currentData = computedData.value;

  final controllerAValue = useValueListenable(controllerA ?? dummyListenable);

  final currentController = controllerA;
  final currentControllerValue = controllerAValue;
  final currentMs = computedData.value.start + (currentControllerValue?.position.inMilliseconds ?? 0);

  useSimpleEffect(() async {
    if (currentController != null && pendingSeekMsState.value != null) {
      final pendingSeek = pendingSeekMsState.value!;
      await currentController.seekTo(Duration(milliseconds: pendingSeek - currentData.start));
      pendingSeekMsState.value = null;
    }
  }, [pendingSeekMsState.value, currentData, currentController]);

  seekTo(int time) {
    pendingSeekMsState.value = time;
  }

  //looping
  useEffect(() {
    if (currentMs >= computedData.value.end && looping) seekTo(0);
    return null;
  }, [controllerAValue]);

  useSimpleEffect(() async {
    if (!focusNode.hasFocus) {
      isPlayingState.value = false;
    }
  }, [focusNode.hasFocus]);

  useSimpleEffect(() async {
    if (isInView && autoplay) {
      isPlayingState.value = true;
    } else {
      isPlayingState.value = false;
    }
  }, [isInView]);

  useSimpleEffect(() async {
    if (isPlayingState.value) {
      if (!focusNode.hasFocus) focusNode.requestFocus();
      if (!isStartedState.value) {
        isStartedState.value = true;
      }
    }

    if (isInView) {
      Wakelock.toggle(enable: true);
    } else {
      Wakelock.toggle(enable: false);
    }
  }, [isInView, isPlayingState.value]);

  return VideoPlayerState(
    seekTo: seekTo,
    controller: currentController,
    total: computedData.value.end,
    progress: pendingSeekMsState.value ?? currentMs,
    isWaiting: currentController == null,
    areControlsVisible: areControlsVisibilityState.value,
    toggleControlsVisibility: () {
      areControlsVisibilityState.value = !areControlsVisibilityState.value;
      if (areControlsVisibilityState.value && !isSoundState.value) {
        isSoundState.value = true;
      }
    },
    togglePlaying: () {
      isPlayingState.value = !isPlayingState.value;
      onTogglePlay?.call(isPlayingState.value);
      if (isPlayingState.value) isSoundState.value = true;
    },
    isFinished: currentMs >= computedData.value.end,
    isPlaying: isPlayingState.value,
    repeat: () => seekTo(0),
    toggleVolume: () => isSoundState.value = !isSoundState.value,
    isSound: isSoundState.value,
    showThumbnail: (pendingSeekMsState.value ?? currentMs) == 0,
    focusNode: focusNode,
    toggleFullscreen: () async {
      if (isFullscreen) {
        context.navigator.pop();
        context.navigator.pop();
      } else {
        navigateToFullScreen?.call(videoPath, thumbnail ?? '');
      }
    },
    isFullscreen: isFullscreen,
  );
}

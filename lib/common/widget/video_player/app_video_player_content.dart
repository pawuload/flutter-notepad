import 'package:app/common/widget/video_player/state/video_player_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

import 'widgets/app_video_player_loading.dart';

class AppVideoPlayerContent extends StatelessWidget {
  final VideoPlayerState state;
  final double? aspectRatio;
  final String? thumbnail;
  final Color loadingBackgroundColor;
  final Color loadingColor;
  final bool isAsset;

  const AppVideoPlayerContent({
    Key? key,
    required this.state,
    required this.loadingBackgroundColor,
    required this.loadingColor,
    this.aspectRatio,
    required this.isAsset,
    this.thumbnail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio != null
          ? aspectRatio!
          : state.isWaiting
          ? 16 / 9
          : state.controller!.value.aspectRatio,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: state.isWaiting
                  ? AppVideoPlayerLoading(
                backgroundColor: loadingBackgroundColor,
                bounceColor: loadingColor,
              )
                  : _buildVideoPlayer(state),
            ),
          ),
          if (state.showThumbnail && thumbnail != null) _buildThumbnail(),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return Positioned.fill(
      child: CachedNetworkImage(
        imageUrl: thumbnail!,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildVideoPlayer(VideoPlayerState state) {
    return Container(
      child: VideoPlayer(state.controller!),
    );
  }
}

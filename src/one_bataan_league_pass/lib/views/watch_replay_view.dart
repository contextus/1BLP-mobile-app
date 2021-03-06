import 'package:arch/arch.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:one_bataan_league_pass/view_models/view_models.dart';
import 'package:one_bataan_league_pass/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class WatchReplayView extends StatefulWidget {
  @override
  _WatchReplayViewState createState() => _WatchReplayViewState();
}

class _WatchReplayViewState extends ViewStateBase<WatchReplayView, WatchReplayViewModel> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/1bl_video.mp4'); // TODO: Change to [viewModel.gameToWatch.gameVideoUrl].
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Hero(
      tag: viewModel.game.id,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(controller: _chewieController),
          ),
        ),
      ),
    );
  }
}

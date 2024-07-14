import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_app/cubit/map/map_cubit.dart';
import 'package:geo_app/ui/map_widget.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<BorderRadius?> _borderRadius;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);
    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(50.0),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _borderRadius,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: _borderRadius.value,
              ),
              alignment: Alignment.center,
              child: _getAppTitleWidget(),
            );
          },
        ),
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return Text(
      "GeoApp",
      style: Theme.of(context).textTheme.headlineLarge,
    )
        .animate(onComplete: (controller) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => _getMapWidget(),
            ),
          );
        })
        .then(delay: 1.seconds)
        .fadeIn(duration: 500.ms)
        .then(delay: 1.seconds)
        .shimmer(duration: 400.ms)
        .then(delay: 1.seconds)
        .blur(duration: 500.ms)
        .then(delay: 100.ms);
  }

  Widget _getMapWidget() {
    return BlocProvider<MapCubit>(
      create: (_) => MapCubit(),
      child: MapWidget(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peacefulpalapp/presentation/widgets/custom_app_bar.dart';
import 'package:peacefulpalapp/presentation/widgets/primary_button.dart';

class BreathingScreen extends StatefulWidget {
  static const routeName = '/breathing';

  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  int _currentPhase = 0; 
  final List<int> _durations = [4, 7, 8]; 
  final List<String> _phases = ['Inhale', 'Hold', 'Exhale'];
  String get _phaseText => _phases[_currentPhase];

  bool _isStarted = false;
  Timer? _timer;
  late int _currentSecond;

  void _startBreathing() {
    setState(() {
      _isStarted = true;
      _currentPhase = 0;
      _currentSecond = _durations[0];
    });

    _runBreathingCycle();
  }

  void _runBreathingCycle() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.reset();

    _playPhase(0);
  }

  void _playPhase(int phaseIndex) {
    if (phaseIndex >= _phases.length) return;

    _currentSecond = _durations[phaseIndex];
    _currentPhase = phaseIndex;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentSecond--;

        if (_currentSecond <= 0) {
          timer.cancel();
          _playPhase(phaseIndex + 1);
        }
      });
    });

    if (phaseIndex == 0 || phaseIndex == 2) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'Breathing exercise'),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? const [
                        Color(0xFF4A3B78),
                        Color(0xFF1E1E2F),
                      ]
                    : const [
                        Color(0xFFC7B6F9),
                        Color(0xFFF5F0FA),
                      ],
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? const Color(0xFF8E7CC3).withOpacity(0.3)
                    : const Color(0xFFC7B6F9).withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? const Color(0xFF8E7CC3).withOpacity(0.3)
                    : const Color(0xFFC7B6F9).withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Follow animation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Text(
                    _isStarted ? _phaseText : '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    _isStarted ? '$_currentSecond sec.' : '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 40),

                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColor.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Text(
                              _isStarted ? _phaseText : 'Breathe...',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  if (!_isStarted)
                    PrimaryButton(
                      text: 'Start',
                      onPressed: _startBreathing,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';

class DealTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onExpire;

  const DealTimer({super.key, required this.duration, this.onExpire});

  @override
  State<DealTimer> createState() => _DealTimerState();
}

class _DealTimerState extends State<DealTimer> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining.inSeconds > 0) {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
      } else {
        _timer?.cancel();
        if (widget.onExpire != null) {
          widget.onExpire!();
        }
      }
    });
  }

  String _format(Duration d) =>
      '${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'Ends in ${_format(_remaining)}',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
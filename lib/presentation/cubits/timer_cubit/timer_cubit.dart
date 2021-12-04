import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'timer_ticker.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final TimerTicker _ticker;
  final int duration;

  StreamSubscription<int>? _tickerSubscription;

  TimerCubit({required TimerTicker ticker, required this.duration})
      : _ticker = ticker,
        super(TimerInitial(duration));

  void startTimer() {
    emit(TimerRunInProgress(duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: duration)
        .listen((duration) => _timerTicked(duration));
  }

  void _timerTicked(int duration) {
    emit(duration > 0 ? TimerRunInProgress(duration) : TimerRunComplete());
  }

  void timerReset() {
    _tickerSubscription?.cancel();
    emit(TimerInitial(duration));
    startTimer();
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

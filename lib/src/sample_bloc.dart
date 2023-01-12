import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_concurrency_sample/src/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SampleBloc extends Bloc<ShowEvent, SampleState> {
  final SampleRepository _sampleRepository;

  //sequential : 동기 방식 이벤트가 종료 되면 다음것 수행
  //restartable : 최근 이벤트만 수행 이전 이벤트는 제거
  //droppable : 이전 이벤트가 처리되는 동안 들어오는 이벤트 제거

  SampleBloc(this._sampleRepository) : super(SampleState.init()) {
    on<KimShowEvent>(_showKim, transformer: droppable());
    on<IUShowEvent>(_showIu);
  }

  void _showKim(event, emit) async {
    // await Future.delayed(Duration(milliseconds: 500));
    emit(state.copyWith(totalPoint: state.totalPoint - 1));
    var path = await _sampleRepository.getKim(state.totalPoint);
    emit(state.copyWith(path: path));
  }

  void _showIu(event, emit) async {
    emit(state.copyWith(totalPoint: state.totalPoint - 1));
    var path = await _sampleRepository.getIU(state.totalPoint);
    emit(state.copyWith(path: path));
  }

  @override
  void onTransition(Transition<ShowEvent, SampleState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

abstract class ShowEvent {}

class KimShowEvent extends ShowEvent {}

class IUShowEvent extends ShowEvent {}

class SampleState extends Equatable {
  int totalPoint;
  String? path;

  SampleState({
    required this.totalPoint,
    this.path = '',
  });

  SampleState copyWith({
    int? totalPoint,
    String? path,
  }) {
    return SampleState(
        totalPoint: totalPoint ?? this.totalPoint, path: path ?? this.path);
  }

  SampleState.init() : this(totalPoint: 3000);
  @override
  List<Object?> get props => [totalPoint, path];
}

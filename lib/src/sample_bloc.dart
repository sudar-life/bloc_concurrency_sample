import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_concurrency_sample/src/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SampleBloc extends Bloc<ShowEvent, SampleState> {
  final SampleRepository _sampleRepository;
  //concurrent : bloc의 기본 처리 방식
  //sequential : 동기 방식 이벤트가 종료 되면 다음것 수행
  //restartable : 최근 이벤트만 수행 이전 이벤트는 제거
  //droppable : 이전 이벤트가 처리되는 동안 들어오는 이벤트 제거

  SampleBloc(this._sampleRepository) : super(const SampleState.init()) {
    on<IUShowEvent>(_showIu, transformer: droppable());
  }

  void _showIu(event, emit) async {
    emit(state.copyWith(count: state.count + 1));
    var path = await _sampleRepository.getIU(state.count);
    emit(state.copyWith(path: path));
  }

  @override
  void onTransition(Transition<ShowEvent, SampleState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

abstract class ShowEvent {}

class IUShowEvent extends ShowEvent {}

class SampleState extends Equatable {
  final int count;
  final String? path;

  const SampleState({
    required this.count,
    this.path = '',
  });

  SampleState copyWith({
    int? count,
    String? path,
  }) {
    return SampleState(count: count ?? this.count, path: path ?? this.path);
  }

  const SampleState.init() : this(count: -1);
  @override
  List<Object?> get props => [count, path];
}

import 'package:bloc_concurrency_sample/src/repository.dart';
import 'package:bloc_concurrency_sample/src/sample_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SampleRepository(),
      child: BlocProvider(
        create: (context) => SampleBloc(context.read<SampleRepository>()),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  PreferredSize _appBarView(Size size) {
    return PreferredSize(
      preferredSize: Size(size.width, 160),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 40),
        child: BlocBuilder<SampleBloc, SampleState>(builder: (context, state) {
          return Text(
            'Point : ${state.totalPoint}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
        }),
      ),
    );
  }

  Widget show() {
    return BlocBuilder<SampleBloc, SampleState>(builder: (context, state) {
      return Container(
        height: 300,
        child: state.path == '' ? Container() : Text(state.path!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarView(MediaQuery.of(context).size),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            show(),
            ElevatedButton(
              onPressed: () {
                context.read<SampleBloc>().add(IUShowEvent());
              },
              child: Text('아이유 사진'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SampleBloc>().add(KimShowEvent());
              },
              child: Text('김채원 사진'),
            ),
          ],
        ),
      ),
    );
  }
}

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

  Widget show() {
    return BlocBuilder<SampleBloc, SampleState>(builder: (context, state) {
      return Column(
        children: [
          if (state.count >= 0)
            Text(
              state.count.toString(),
              style: TextStyle(fontSize: 20),
            ),
          Container(
            height: 300,
            child: state.path == ''
                ? Container()
                : Image.asset('assets/images/${state.path}'),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
    );
  }
}

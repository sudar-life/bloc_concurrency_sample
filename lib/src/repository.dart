class SampleRepository {
  List<String> iu = ['iu_0.png', 'iu_1.png', 'iu_2.png'];
  List<int> delay = [2000, 1400, 2500];

  Future<String> getIU(int index) async {
    print(index % 3);
    await Future.delayed(Duration(milliseconds: delay[index % 3]));
    print('result : ${iu[index % 3]}');
    return iu[index % 3];
  }
}

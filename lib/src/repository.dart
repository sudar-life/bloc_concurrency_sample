class SampleRepository {
  List<String> kims = ['kim_0.png', 'kim_1.png', 'kim_3.png'];
  List<String> iu = ['iu_0.png', 'iu_1.png', 'iu_3.png'];
  Future<String> getKim(int index) async {
    await Future.delayed(const Duration(milliseconds: 3000));
    return kims[index % 3];
  }

  Future<String> getIU(int index) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return iu[index % 3];
  }
}

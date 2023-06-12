class PatientData {
  final String name;
  final String address;
  PatientData({required this.name, required this.address});

  static String patientName = 'name';
  static String addressKey = 'address';

  static PatientData fromMap(item) {
    return PatientData(
        name: item?[patientName] ?? 'Desconhecido',
        address: item?[addressKey] ?? 'Desconhecido');
  }

  @override
  String toString() {
    return name;
  }
}

class Hotline {
  final String countryName;
  final List<String> policeNumbers;
  final List<String> ambulanceNumbers;
  final List<String> fireNumbers;

  Hotline({
    required this.countryName,
    required this.policeNumbers,
    required this.ambulanceNumbers,
    required this.fireNumbers,
  });

  factory Hotline.fromApi(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return Hotline(
      countryName: data['country']?['name'] ?? '',
      policeNumbers: List<String>.from(data['police']?['all'] ?? []),
      ambulanceNumbers: List<String>.from(data['ambulance']?['all'] ?? []),
      fireNumbers: List<String>.from(data['fire']?['all'] ?? []),
    );
  }
}

class Disease {
  String name;
  List<String> control;
  List<String> symptoms;
  String transmission;
  String image;

  Disease(
      {required this.name,
      required this.control,
      required this.symptoms,
      required this.transmission,
      required this.image});

  toJason() {
    return {
      "name": name,
      "image": image,
      "Transmission": transmission,
      "Control": control,
      "Symptoms": symptoms,
    };
  }
}

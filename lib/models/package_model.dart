class Package {
  final String title;
  final String price;
  final String desc;

  Package({required this.title, required this.price, required this.desc});

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      title: json['title'],
      price: json['price'],
      desc: json['desc'],
    );
  }
}

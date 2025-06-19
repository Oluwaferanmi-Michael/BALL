

class LocationInformation {
  final String name;
  final String address;
  final String city;
  final String price;
  final String? image;

  LocationInformation({required this.name, required this.address, required this.city, this.price = 'free', this.image = ''});

  LocationInformation.empty() : name = '', address = '', city = '' , price = '', image = null;
}
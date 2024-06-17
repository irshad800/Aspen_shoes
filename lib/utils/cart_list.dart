List<dynamic> Citems = [];
void Crt(
    {String? favName, String? favImage, int? favPrice, int? qty, int? index}) {
  Map<String, dynamic> caritems = {
    "name": favName,
    "image": favImage,
    "price": favPrice,
    "qty": qty,
    "index": index
  };
  print(caritems);
  Citems.add(caritems);
  print(Citems);
}

void delete({required int index}) {
  Citems.removeAt(index);
}

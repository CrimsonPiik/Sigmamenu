extension StringCasingExtension on String {
  String toCapitalized() =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String toTitleCase() => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}

 // FOR EDITTING COLLECTIONS IN FIREBASE
                          // await FirebaseFirestore.instance
                          //     .collection('salads')
                          //     .get()
                          //     .then((QuerySnapshot snapShot) async {
                          //   snapShot.docs.forEach((element) async {
                          //     await FirebaseFirestore.instance
                          //         .collection('Salads')
                          //         .doc(element.id)
                          //         .set(element.data() as Map<String, dynamic>);
                          //   });
                          // });
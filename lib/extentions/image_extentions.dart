

enum Images {
  courtA,
  courtB,
  courtC,
  icon

}

extension ImageExtension on Images {
  String get key {
    switch (this) {
      case Images.courtA:
        return 'assets/courtA.jpg';
      case Images.courtB:
        return 'assets/courtB.jpg';
      case Images.courtC:
        return 'assets/courtC.jpg';
      case Images.icon:
        return 'assets/tennis_ball.png';
    }
  }
}
class Utils {
  const Utils._();

  static String assetsPath(String path) => 'assets/$path';

  static String imagePath(String imagePath) => assetsPath('images/$imagePath');
}

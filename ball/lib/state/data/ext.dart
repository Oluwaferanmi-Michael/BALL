extension AssetLocation on String {
  String audioAssetPath() => 'audio/$this';
  String imageAssetPath() => 'assets/images/png/$this';
  String svgImageAssetPath() => 'assets/images/svg/$this';
}

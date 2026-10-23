class MediaPipeline {
  Future<String> outboundCompress(String path) async {
    // Compress ~80%, save compressed path
    return path.replaceAll('.jpg', '_compressed.jpg');
  }

  Future<void> inboundPreview(String mediaPath) async {
    // Write ~5KB blurry thumbnail to DB
  }

  Future<String> extractOnDemand(String mediaPath) async {
    // Only invoke when user taps thumbnail
    return mediaPath;
  }
}
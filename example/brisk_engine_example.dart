import 'dart:io';

import 'package:brisk_engine/brisk_engine.dart';

void main() async {
  /// Build the download item either by using this method or manually building it
  /// using HttpDownloadEngine.requestFileInfo(url). Note that buildDownloadItem(url)
  /// automatically uses an isolate to request for file information while requestFileInfo
  /// does so in the same isolate.
  String url =
      "https://github.com/AminBhst/brisk-engine/archive/refs/heads/main.zip";
  final downloadItem = await HttpDownloadEngine.buildDownloadItem(url);

  final settings = DownloadSettings(
    baseSaveDir: Directory("YOUR_BASE_DIRECTORY"),
    totalConnections: 8,
    loggerEnabled: false,
    baseTempDir: Directory("YOUR_BASE_DIRECTORY"),
    connectionRetryTimeoutMillis: 10000,
    maxConnectionRetryCount: -1, // Currently doesn't work
  );

  /// Start the engine
  DownloadEngine.start(
    downloadItem,
    settings,
    onButtonAvailability: (message) {
      /// Handle button availability. A download should only be paused or resumed
      /// when the buttons are available as notified in this method. Otherwise, it could
      /// lead to a corrupted file.
    },
    onDownloadProgress: (message) {
      /// Updates on the download progress will be notified here
    },
  );

  /// You can use the UID which is set on the downloadItem to pause/resume the download

  /// Pause the download
  DownloadEngine.pause(downloadItem.uid);

  /// Resume the download
  DownloadEngine.resume(downloadItem.uid);
}

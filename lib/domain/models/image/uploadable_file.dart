import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';

class UploadableFile {
  UploadableFile({
    this.id,
    this.name,
    this.localPath,
    this.extension,
    this.xFile,
  });

  UploadableFile copy() {
    return UploadableFile(
      id: id,
      name: name,
      localPath: localPath,
      extension: extension,
      xFile: xFile,
    );
  }

  String? id;
  String? name;
  String? localPath;
  String? extension;
  XFile? xFile;

  bool isUploaded() {
    return id?.isNotEmpty == true;
  }

  bool isSame(UploadableFile other) {
    return (id != null && id == other.id) ||
        (xFile?.path != null && xFile?.path == other.xFile?.path);
  }

  bool isNotUploaded() {
    return id == null || id?.isEmpty == true;
  }
}

// for path and extension manipulation

extension CroppedFileToUploadableFile on CroppedFile {
  UploadableFile toUploadableFileFromCroppedFile() {

    final file = File(path);
    final fileName = file.uri.pathSegments.last;
    final extension = fileName.split('.').last;
    final xFile = XFile(path);
    return UploadableFile(
      name: fileName,
      localPath: path,
      extension: extension,
      xFile: xFile,
    );
  }
}
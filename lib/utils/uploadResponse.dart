
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// Response Model
class UploadResponse {
  final bool success;
  final String url;
  final String? message;

  UploadResponse({
    required this.success,
    required this.url,
    this.message,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      success: json['success'] ?? false,
      url: json['data']?['url'] ?? '',
      message: json['message'],
    );
  }
}
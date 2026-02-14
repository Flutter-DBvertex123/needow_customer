
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// Models
class TimelineEvent {
  final String status;
  final String timestamp;
  final String note;
  final String updatedBy;
  final String id;

  TimelineEvent({
    required this.status,
    required this.timestamp,
    required this.note,
    required this.updatedBy,
    required this.id,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
      status: json['status'] ?? '',
      timestamp: json['timestamp'] ?? '',
      note: json['note'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class AgentLocation {
  final double latitude;
  final double longitude;

  AgentLocation({required this.latitude, required this.longitude});

  factory AgentLocation.fromJson(Map<String, dynamic> json) {
    return AgentLocation(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}

class DeliveryAgent {
  final String name;
  final String phone;
  final String id;

  DeliveryAgent({required this.name, required this.phone, required this.id});

  factory DeliveryAgent.fromJson(Map<String, dynamic> json) {
    return DeliveryAgent(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class TrackingData {
  final String status;
  final List<TimelineEvent> timeline;
  final AgentLocation? agentLocation;
  final DeliveryAgent? deliveryAgent;
  final String estimatedDeliveryTime;

  TrackingData({
    required this.status,
    required this.timeline,
    this.agentLocation,
    this.deliveryAgent,
    required this.estimatedDeliveryTime,
  });

  factory TrackingData.fromJson(Map<String, dynamic> json) {
    return TrackingData(
      status: json['status'] ?? '',
      timeline: (json['timeline'] as List?)
          ?.map((e) => TimelineEvent.fromJson(e))
          .toList() ??
          [],
      agentLocation: json['agentLocation'] != null
          ? AgentLocation.fromJson(json['agentLocation'])
          : null,
      deliveryAgent: json['deliveryAgent'] != null
          ? DeliveryAgent.fromJson(json['deliveryAgent'])
          : null,
      estimatedDeliveryTime: json['estimatedDeliveryTime'] ?? '',
    );
  }
}

class OrderTrackingModel {
  final int statusCode;
  final String message;
  final TrackingData data;

  OrderTrackingModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory OrderTrackingModel.fromJson(Map<String, dynamic> json) {
    return OrderTrackingModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: TrackingData.fromJson(json['data']),
    );
  }
}

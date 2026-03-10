import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/activity_stats.dart';
import '../models/team_stats.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<List<String>> fetchUserIds() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.cast<String>();
    } else {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }

  static Future<List<String>> fetchTeamIds() async {
    final response = await http.get(Uri.parse('$baseUrl/teams'));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List;
      return list.cast<String>();
    } else {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }

  static Future<ActivityStats> fetchUserActivities(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId/activities'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ActivityStats.fromJson(json);
    } else if (response.statusCode == 404) {
      throw Exception('Utilisateur "$userId" introuvable');
    } else {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }

  static Future<TeamStats> fetchTeamActivities(String teamId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/teams/$teamId/activities'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return TeamStats.fromJson(json);
    } else if (response.statusCode == 404) {
      throw Exception('Équipe "$teamId" introuvable');
    } else {
      throw Exception('Erreur serveur : ${response.statusCode}');
    }
  }
}

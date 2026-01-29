import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/data/models/content.dart';

abstract class FavoritesServiceInterface {
  Future<List<Content>> getFavorites();
  Future<void> addToFavorites(Content content);
  Future<void> removeFromFavorites(int contentId);
  Future<bool> isFavorite(int contentId);
}

class FavoritesService implements FavoritesServiceInterface {
  CollectionReference get _favoritesCollection {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception('Пользователь не авторизован');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites');
  }

  @override
  Future<List<Content>> getFavorites() async {
    try {
      final snapshot = await _favoritesCollection.get();
      return snapshot.docs
          .map((doc) => Content.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw Exception('Нет доступа к избранному. Проверьте правила безопасности Firestore.');
      }
      throw Exception(e.message ?? 'Не удалось получить список избранного');
    } catch (e) {
      throw Exception('Неизвестная ошибка при получении избранного: $e');
    }
  }

  @override
  Future<void> addToFavorites(Content content) async {
    try {
      await _favoritesCollection.doc(content.id.toString()).set({
        'id': content.id,
        'userId': content.userId,
        'title': content.title,
        'body': content.body,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw Exception('Нет доступа для добавления в избранное. Проверьте правила безопасности Firestore.');
      }
      throw Exception(e.message ?? 'Не удалось добавить в избранное');
    } catch (e) {
      throw Exception('Неизвестная ошибка при добавлении в избранное: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(int contentId) async {
    try {
      await _favoritesCollection.doc(contentId.toString()).delete();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw Exception('Нет доступа для удаления из избранного. Проверьте правила безопасности Firestore.');
      }
      throw Exception(e.message ?? 'Не удалось удалить из избранного');
    } catch (e) {
      throw Exception('Неизвестная ошибка при удалении из избранного: $e');
    }
  }

  @override
  Future<bool> isFavorite(int contentId) async {
    try {
      final doc = await _favoritesCollection.doc(contentId.toString()).get();
      return doc.exists;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw Exception('Нет доступа для проверки избранного. Проверьте правила безопасности Firestore.');
      }
      throw Exception(e.message ?? 'Не удалось проверить статус избранного');
    } catch (e) {
      throw Exception('Неизвестная ошибка при проверке избранного: $e');
    }
  }
}

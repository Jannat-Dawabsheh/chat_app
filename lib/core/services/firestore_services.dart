import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices{
  FirestoreServices._();
  static final instance =FirestoreServices._();
  FirebaseFirestore get firestore=> FirebaseFirestore.instance;

  Future<void> setData({ // collection/$documentId/another collection/$another documentId.....
    required String path,
    required Map<String,dynamic> data,
  }) async{
    final reference=firestore.doc(path);
    debugPrint('$path: $data');
    await reference.set(data);
  }

  Future<void>deleteData({required String path})async{
     final reference=firestore.doc(path);
    debugPrint('delete: $path');
    await reference.delete();
  }

  Stream<List<T>>collectionStream<T>({
    required String path,//collection/
    required T Function(Map<String,dynamic> data, String documentId)builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,

  }){
    Query query=firestore.collection(path);
    if(queryBuilder!=null){
      query=queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshots){
      final result=snapshots.docs
      .map((snapshots) => builder(snapshots.data() as Map<String,dynamic>, snapshots.id))
      .where((value) => value!=null)
      .toList();

      if(sort!=null){
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T>documentStream<T>({
    required String path,
    required T Function(Object? data, String documentID)builder,
  }){
    final reference=firestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshots)=>builder(snapshots.data(),snapshots.id));
  }

  Future<T>getDocument<T>({
    required String path,
    required T Function(Map<String,dynamic> data, String documentID)builder,
  })async{
    final reference=firestore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data() as Map<String,dynamic>, snapshot.id);
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String,dynamic> data, String documentId)builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  })async{
    Query query=firestore.collection(path);
    if(queryBuilder!=null){
      query=queryBuilder(query);
    }
    final snapshots = await query.get();
   
      final result=snapshots.docs
      .map((snapshot) => builder(snapshot.data() as Map<String,dynamic>, snapshot.id))
      .where((value) => value!=null)
      .toList();

      if(sort!=null){
        result.sort(sort);
      }
      return result;
  }
  
}
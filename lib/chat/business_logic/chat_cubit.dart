// import 'dart:io';
// import 'package:care_flow/chat/business_logic/chat_states.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
//
// class ChatCubit extends Cubit<ChatStates>{
//   ChatCubit():super(InitialState());
//   static ChatCubit get(BuildContext context) => BlocProvider.of(context);
//
//   List<UserModel> allUsers = [];
//  Future<void> getAllUsers() async {
//     await FirebaseFirestore.instance.collection('users').get().then((value) {
//       if (allUsers.length != value.docs.length) {
//         allUsers = [];
//         value.docs.forEach((element) {
//           if (element.id != uId) {
//             allUsers.add(UserModel.fromJson(element.data()));
//           }
//         });
//         emit(GetAllUsersSuccessState());
//       }
//     }).catchError((error) {
//       emit(GetAllUsersErrorState(error.toString()));
//     });
//   }
//
//   Future<void> sendMessage({
//     String? text,
//     String? audioMsg,
//     required String receiverId,
//   }) async {
//     emit(SendMessageLoadingState());
//     MessageModel model = MessageModel(
//         text: text,
//         audioMsg: audioMsg,
//         receiverId: receiverId,
//         senderId:uId,
//         dateTime: DateTime.now().toString());
// //set my chats
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(uId)
//         .collection('chats')
//         .doc(receiverId)
//         .collection('messages')
//         .add(model.toMap())
//         .then((value) {
//       emit(SendMessageSuccessState());
//     }).catchError((error) {
//       emit(SendMessageErrorState());
//     });
//
//     // set receiver chats
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverId)
//         .collection('chats')
//         .doc(uId)
//         .collection('messages')
//         .add(model.toMap())
//         .then((value) {
//       emit(SendMessageSuccessState());
//     }).catchError((error) {
//       emit(SendMessageErrorState());
//     });
//   }
//
//   List<MessageModel> messages = [];
//   getMessages({
//     required String receiverId,
//   }) async {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(uId)
//         .collection('chats')
//         .doc(receiverId)
//         .collection('messages')
//         .orderBy('dateTime')
//         .snapshots()
//         .listen((event) {
//       messages = [];
//       event.docs.forEach((element) {
//         messages.add(MessageModel.fromJson(element.data()));
//       });
//       emit(GetAllMessagesSuccessState());
//     });
//   }
//
//   uploadAudio({required String receiverId}) {
//     emit(UploadRecordLoadingState());
//     if (recordFilePath != null) {
//       firebase_storage.FirebaseStorage.instance
//           .ref()
//           .child('audios/${Uri.file(recordFilePath!).pathSegments.last}')
//           .putFile(File(recordFilePath!))
//           .then((value) {
//         emit(UploadRecordSuccessState());
//         value.ref.getDownloadURL().then((value) async {
//           await sendMessage(audioMsg: value.toString(), receiverId: receiverId);
//         });
//       }).catchError((error) {
//         emit(UploadRecordErrorState());
//       });
//     }
//   }
//
// }
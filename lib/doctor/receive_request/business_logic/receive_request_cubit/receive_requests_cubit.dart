import 'dart:async';
import 'dart:io';
import 'package:care_flow/core/di_container.dart';
import 'package:care_flow/core/utils/strings.dart';
import 'package:care_flow/doctor/receive_request/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'receive_requests_state.dart';

class ReceiveRequestsCubit extends Cubit<ReceiveRequestsState> {
  ReceiveRequestsCubit() : super(ReceiveRequestsInitial());

  static ReceiveRequestsCubit get(BuildContext context) =>
      BlocProvider.of<ReceiveRequestsCubit>(context);

  final firebaseCollection = FirebaseFirestore.instance
      .collection('doctors')
      .doc(sl<AppStrings>().uId)
      .collection('requests');
// late StreamSubscription? subscription;

  List<RequestModel> requests = [];

  Future<void> getRequests() async {
    try {
      emit(ReceiveRequestLoad());
      var currentRequests = await firebaseCollection.orderBy('time', descending: true).limit(5).get();
      currentRequests.docs.forEach((element) {
        requests.add(RequestModel.fromJson(element.data()));
      });
      emit(ReceiveRequestSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(ReceiveRequestError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(ReceiveRequestError(sl<AppStrings>().checkInternet));
      }
    }
  }

  Future<void> loadMoreData() async {
    try {
      emit(LoadMoreData());
      var moreData = await firebaseCollection
          .orderBy('time', descending: true)
          .where('time', isLessThan: requests.last.time)
          .limit(10)
          .get();
      if (moreData.docs.isNotEmpty) {
        print(moreData.docs);
        moreData.docs.forEach((element) {
          requests.add(RequestModel.fromJson(element.data()));
        });
      }
      emit(ReceiveRequestSuccess());
    } catch (error) {
      if (error is FirebaseException) {
        emit(ReceiveRequestError(sl<AppStrings>().errorMessage));
      } else if (error is SocketException) {
        emit(ReceiveRequestError(sl<AppStrings>().checkInternet));
      }
    }
  }

  Future<void> readRequest(String id) async {
    emit(ReadRequest());
    firebaseCollection.doc(id).update({'read': true});
  }

  Future<void> markFinish(String requestId) async {
    try {
      firebaseCollection.doc(requestId).update({'finished': true});
      emit(MarkFinishSuccess());
    } catch (error) {
      if (error is SocketException) {
        emit(ReceiveRequestError(sl<AppStrings>().checkInternet));
      } else {
        emit(ReceiveRequestError(sl<AppStrings>().errorMessage));
      }
    }
  }

// Future<void> getRequests() async {
//   emit(ReceiveRequestLoad());
//   try {
//    subscription= firebaseCollection
//         .orderBy('time', descending: true)
//         .limit(5)
//         .snapshots()
//         .listen((event) {
//       List<RequestModel> tempRequests = [];
//       for (var change in event.docChanges) {
//         switch (change.type) {
//           case DocumentChangeType.added:
//             if (change.doc.data() != null) {
//               tempRequests.add(RequestModel.fromJson(change.doc.data()!));
//             }
//             break;
//           case DocumentChangeType.modified:
//             // TODO: Handle this case.
//             break;
//           case DocumentChangeType.removed:
//             // TODO: Handle this case.
//             break;
//         }
//       }
//       tempRequests.reversed.forEach((element) {
//         requests.insert(0, element);
//       });
//       print(requests);
//       emit(ReceiveRequestSuccess());
//     });
//   } catch (error) {
//     if (error is FirebaseException) {
//       emit(ReceiveRequestError(sl<AppStrings>().errorMessage));
//     } else if (error is SocketException) {
//       emit(ReceiveRequestError(sl<AppStrings>().checkInternet));
//     }
//   }
// }

}

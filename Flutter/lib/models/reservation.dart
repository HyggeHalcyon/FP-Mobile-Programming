import 'dart:convert';

MyReservationResponse myReservationResponseFromJson(String str) => MyReservationResponse.fromJson(json.decode(str));

String myReservationResponseToJson(MyReservationResponse data) => json.encode(data.toJson());

class MyReservationResponse {
    bool status;
    String message;
    String? error;
    List<MyReservationData>? data;

    MyReservationResponse({
        required this.status,
        required this.message,
        this.error,
        this.data,
    });

    factory MyReservationResponse.fromJson(Map<String, dynamic> json) => MyReservationResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["data"] != null ? List<MyReservationData>.from(json["data"].map((x) => MyReservationData.fromJson(x))) : null, 
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,    
  };
}

class MyReservationData {
    String id;
    String status;
    String roomName;
    String roomPic;
    String startDate;
    String endDate;
    int capacity;

    MyReservationData({
        required this.id,
        required this.status,
        required this.roomName,
        required this.roomPic,
        required this.capacity,
        required this.startDate,
        required this.endDate,
    });

    factory MyReservationData.fromJson(Map<String, dynamic> json) => MyReservationData(
        id: json["id"],
        status: json["status"],
        roomName: json["room_name"],
        roomPic: json["room_pic"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        capacity: json["capacity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "capacity": capacity,
        "room_name": roomName,
        "room_pic": roomPic,
        "start_date": startDate,
        "end_date": endDate,
    };
}

ReservationDetailsResponse reservationDetailsFromJson(String str) => ReservationDetailsResponse.fromJson(json.decode(str));

String reservationDetailsToJson(ReservationDetailsResponse data) => json.encode(data.toJson());

class ReservationDetailsResponse {
    bool status;
    String message;
    String? error;
    ReservationDetailsData? data;

    ReservationDetailsResponse({
        required this.status,
        required this.message,
        this.error,
        this.data,
    });

    factory ReservationDetailsResponse.fromJson(Map<String, dynamic> json) => ReservationDetailsResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["data"] != null ? ReservationDetailsData.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "data": data?.toJson(),
    };
}

class ReservationDetailsData {
    String id;
    String roomId;
    String startDate;
    String endDate;
    String location;
    String roomName;
    int capacity;
    List<String>? facilities;

    ReservationDetailsData({
        required this.id,
        required this.roomId,
        required this.startDate,
        required this.endDate,
        required this.location,
        required this.roomName,
        required this.capacity,
        this.facilities,
    });

    factory ReservationDetailsData.fromJson(Map<String, dynamic> json) => ReservationDetailsData(
        id: json["id"],
        roomId: json["room_id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        location: json["location"],
        roomName: json["room_name"],
        capacity: json["capacity"],
        facilities: json["facilities"] != null?  List<String>.from(json["facilities"].map((x) => x)) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "start_date": startDate,
        "end_date": endDate,
        "location": location,
        "room_name": roomName,
        "capacity": capacity,
        if (facilities != null) "facilities": List<dynamic>.from(facilities!.map((x) => x))    
    };
}

DeleteReservationResponse deleteReservationResponseFromJson(String str) => DeleteReservationResponse.fromJson(json.decode(str));

String deleteReservationResponseToJson(DeleteReservationResponse data) => json.encode(data.toJson());

class DeleteReservationResponse {
    bool status;
    String message;
    String? error;

    DeleteReservationResponse({
        required this.status,
        required this.message,
        this.error,
    });

    factory DeleteReservationResponse.fromJson(Map<String, dynamic> json) => DeleteReservationResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
    };
}

CheckReservationResponse checkReservationResponseFromJson(String str) => CheckReservationResponse.fromJson(json.decode(str));

String checkReservationResponseToJson(CheckReservationResponse data) => json.encode(data.toJson());

class CheckReservationResponse {
    bool status;
    String message;
    String? error;
    CheckReservationData? data;

    CheckReservationResponse({
        required this.status,
        required this.message,
        this.error,
        this.data,
    });

    factory CheckReservationResponse.fromJson(Map<String, dynamic> json) => CheckReservationResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data:  json["error"] != null ? CheckReservationData.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "data": data?.toJson(),
    };
}

class CheckReservationData {
    bool available;

    CheckReservationData({
        required this.available,
    });

    factory CheckReservationData.fromJson(Map<String, dynamic> json) => CheckReservationData(
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
    };
}

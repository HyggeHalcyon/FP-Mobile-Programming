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

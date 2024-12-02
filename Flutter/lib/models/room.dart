import 'dart:convert';

RoomListResponse roomListResponseFromJson(String str) => RoomListResponse.fromJson(json.decode(str));

String roomListResponseToJson(RoomListResponse data) => json.encode(data.toJson());

class RoomListResponse {
    bool status;
    String message;
    String? error;
    List<RoomListData>? data;

    RoomListResponse({
        required this.status,
        required this.message,
        this.error,
        this.data,
    });

    factory RoomListResponse.fromJson(Map<String, dynamic> json) => RoomListResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: List<RoomListData>.from(json["data"].map((x) => RoomListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RoomListData {
    String id;
    String name;
    int capacity;
    String picture;
    List<String> facilities;

    RoomListData({
        required this.id,
        required this.name,
        required this.capacity,
        required this.picture,
        required this.facilities,
    });

    factory RoomListData.fromJson(Map<String, dynamic> json) => RoomListData(
        id: json["id"],
        name: json["name"],
        capacity: json["capacity"],
        picture: json["picture"],
        facilities: List<String>.from(json["facilities"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "capacity": capacity,
        "picture": picture,
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
    };
}

RoomDetailsReponse roomDetailsResponseFromJson(String str) => RoomDetailsReponse.fromJson(json.decode(str));

String roomDetailsResponseToJson(RoomDetailsReponse data) => json.encode(data.toJson());

class RoomDetailsReponse {
    bool status;
    String? error;
    String message;
    RoomDetailsData? data;

    RoomDetailsReponse({
        required this.status,
        this.error,
        required this.message,
        this.data,
    });

    factory RoomDetailsReponse.fromJson(Map<String, dynamic> json) => RoomDetailsReponse(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: json["data"] != null ? RoomDetailsData.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "data": data?.toJson(),
    };
}

class RoomDetailsData {
    String id;
    String name;
    int capacity;
    String location;
    List<String> facilities;

    RoomDetailsData({
        required this.id,
        required this.name,
        required this.capacity,
        required this.location,
        required this.facilities,
    });

    factory RoomDetailsData.fromJson(Map<String, dynamic> json) => RoomDetailsData(
        id: json["id"],
        name: json["name"],
        capacity: json["capacity"],
        location: json["location"],
        facilities: List<String>.from(json["facilities"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "capacity": capacity,
        "location": location,
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
    };
}

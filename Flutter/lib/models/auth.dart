import 'dart:convert';

LoginResponse authResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String authResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool status;
    String message;
    String? error;
    AuthData? data;

    LoginResponse({
        required this.status,
        required this.message,
        this.error,
        this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        error: json["error"],
        data: json["data"] != null ? AuthData.fromJson(json["data"]) : null, 
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "error": error,
        "data": data?.toJson(),
    };
}

class AuthData {
    String token;
    String role;

    AuthData({
        required this.token,
        required this.role,
    });

    factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        token: json["token"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "role": role,
    };
}

MeResponse meResponseFromJson(String str) => MeResponse.fromJson(json.decode(str));

String meResponseToJson(MeResponse data) => json.encode(data.toJson());

class MeResponse {
    bool status;
    String? error;
    String message;
    MeData? data;

    MeResponse({
        required this.status,
        this.error,
        required this.message,
        this.data,
    });

    factory MeResponse.fromJson(Map<String, dynamic> json) => MeResponse(
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: json["data"] != null ? MeData.fromJson(json["data"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "message": message,
        "data": data?.toJson(),
    };
}

class MeData {
    String id;
    String name;
    String nrp;
    String role;
    String profilePicture;

    MeData({
        required this.id,
        required this.name,
        required this.nrp,
        required this.role,
        required this.profilePicture,
    });

    factory MeData.fromJson(Map<String, dynamic> json) => MeData(
        id: json["id"],
        name: json["name"],
        nrp: json["nrp"],
        role: json["role"],
        profilePicture: json["profile_picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nrp": nrp,
        "role": role,
        "profile_picture": profilePicture,
    };
}

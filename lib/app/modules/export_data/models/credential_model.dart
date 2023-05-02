// To parse this JSON data, do
//
//     final credential = credentialFromJson(jsonString);

import 'dart:convert';

List<Credential> credentialFromJson(String str) =>
    List<Credential>.from(json.decode(str).map((x) => Credential.fromJson(x)));

String credentialToJson(List<Credential> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Credential {
  String address;
  DateTime birthdate;
  DateTime created;
  String definitionId;
  String emailAddress;
  String firstName;
  String fullName;
  String gender;
  String lastName;
  String middleName;
  String mobileNumber;
  String requestId;
  String status;
  DateTime updated;
  String username;
  String vcIssuerId;
  String verifier;
  String channelIssuerId;

  Credential({
    required this.address,
    required this.birthdate,
    required this.created,
    required this.definitionId,
    required this.emailAddress,
    required this.firstName,
    required this.fullName,
    required this.gender,
    required this.lastName,
    required this.middleName,
    required this.mobileNumber,
    required this.requestId,
    required this.status,
    required this.updated,
    required this.username,
    required this.vcIssuerId,
    required this.verifier,
    required this.channelIssuerId,
  });

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
        address: json["address"],
        birthdate: DateTime.parse(json["birthdate"]),
        created: DateTime.parse(json["created"]),
        definitionId: json["definition_id"],
        emailAddress: json["email_address"],
        firstName: json["firstName"],
        fullName: json["fullName"],
        gender: json["gender"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        mobileNumber: json["mobile_number"],
        requestId: json["requestId"],
        status: json["status"],
        updated: DateTime.parse(json["updated"]),
        username: json["username"],
        vcIssuerId: json["vc_issuer_id"],
        verifier: json["verifier"],
        channelIssuerId: json["channel_issuer_id"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "birthdate": birthdate.toIso8601String(),
        "created": created.toIso8601String(),
        "definition_id": definitionId,
        "email_address": emailAddress,
        "firstName": firstName,
        "fullName": fullName,
        "gender": gender,
        "lastName": lastName,
        "middleName": middleName,
        "mobile_number": mobileNumber,
        "requestId": requestId,
        "status": status,
        "updated": updated.toIso8601String(),
        "username": username,
        "vc_issuer_id": vcIssuerId,
        "verifier": verifier,
        "channel_issuer_id": channelIssuerId,
      };
}

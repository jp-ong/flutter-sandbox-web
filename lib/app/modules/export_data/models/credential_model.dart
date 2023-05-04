// To parse this JSON data, do
//
//     final credential = credentialFromJson(jsonString);

import 'dart:convert';

enum CredentialKeys {
  address("address"),
  birthdate("birthdate"),
  created("created"),
  definitionId("definition_id"),
  emailAddress("email_address"),
  firstName("firstName"),
  fullName("fullName"),
  gender("gender"),
  lastName("lastName"),
  middleName("middleName"),
  mobileNumber("mobile_number"),
  requestId("requestId"),
  status("status"),
  updated("updated"),
  username("username"),
  vcIssuerId("vc_issuer_id"),
  verifier("verifier"),
  channelIssuerId("channel_issuer_id");

  final String value;
  const CredentialKeys(this.value);
}

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
        address: json[CredentialKeys.address.value],
        birthdate: DateTime.parse(json[CredentialKeys.birthdate.value]),
        created: DateTime.parse(json[CredentialKeys.created.value]),
        definitionId: json[CredentialKeys.definitionId.value],
        emailAddress: json[CredentialKeys.emailAddress.value],
        firstName: json[CredentialKeys.firstName.value],
        fullName: json[CredentialKeys.fullName.value],
        gender: json[CredentialKeys.gender.value],
        lastName: json[CredentialKeys.lastName.value],
        middleName: json[CredentialKeys.middleName.value],
        mobileNumber: json[CredentialKeys.mobileNumber.value],
        requestId: json[CredentialKeys.requestId.value],
        status: json[CredentialKeys.status.value],
        updated: DateTime.parse(json[CredentialKeys.updated.value]),
        username: json[CredentialKeys.username.value],
        vcIssuerId: json[CredentialKeys.vcIssuerId.value],
        verifier: json[CredentialKeys.verifier.value],
        channelIssuerId: json[CredentialKeys.channelIssuerId.value],
      );

  Map<String, dynamic> toJson() => {
        CredentialKeys.address.value: address,
        CredentialKeys.birthdate.value: birthdate.toIso8601String(),
        CredentialKeys.created.value: created.toIso8601String(),
        CredentialKeys.definitionId.value: definitionId,
        CredentialKeys.emailAddress.value: emailAddress,
        CredentialKeys.firstName.value: firstName,
        CredentialKeys.fullName.value: fullName,
        CredentialKeys.gender.value: gender,
        CredentialKeys.lastName.value: lastName,
        CredentialKeys.middleName.value: middleName,
        CredentialKeys.mobileNumber.value: mobileNumber,
        CredentialKeys.requestId.value: requestId,
        CredentialKeys.status.value: status,
        CredentialKeys.updated.value: updated.toIso8601String(),
        CredentialKeys.username.value: username,
        CredentialKeys.vcIssuerId.value: vcIssuerId,
        CredentialKeys.verifier.value: verifier,
        CredentialKeys.channelIssuerId.value: channelIssuerId,
      };
}

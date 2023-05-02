// To parse this JSON data, do
//
//     final credentialDetail = credentialDetailFromJson(jsonString);

import 'dart:convert';

CredentialDetail credentialDetailFromJson(String str) =>
    CredentialDetail.fromJson(json.decode(str));

String credentialDetailToJson(CredentialDetail data) =>
    json.encode(data.toJson());

class CredentialDetail {
  DateTime created;
  DateTime updated;
  String requestId;
  String username;
  String fullName;
  String firstName;
  String middleName;
  String lastName;
  DateTime birthdate;
  String gender;
  String address;
  String emailAddress;
  String mobileNumber;
  String status;
  String vcIssuerId;
  String definitionId;
  String verifier;
  CredentialRequestDetails credentialRequestDetails;
  String channelIssuerId;
  dynamic reason;

  CredentialDetail({
    required this.created,
    required this.updated,
    required this.requestId,
    required this.username,
    required this.fullName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthdate,
    required this.gender,
    required this.address,
    required this.emailAddress,
    required this.mobileNumber,
    required this.status,
    required this.vcIssuerId,
    required this.definitionId,
    required this.verifier,
    required this.credentialRequestDetails,
    required this.channelIssuerId,
    this.reason,
  });

  factory CredentialDetail.fromJson(Map<String, dynamic> json) =>
      CredentialDetail(
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        requestId: json["requestId"],
        username: json["username"],
        fullName: json["fullName"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        birthdate: DateTime.parse(json["birthdate"]),
        gender: json["gender"],
        address: json["address"],
        emailAddress: json["email_address"],
        mobileNumber: json["mobile_number"],
        status: json["status"],
        vcIssuerId: json["vc_issuer_id"],
        definitionId: json["definition_id"],
        verifier: json["verifier"],
        credentialRequestDetails: CredentialRequestDetails.fromJson(
            json["credential_request_details"]),
        channelIssuerId: json["channel_issuer_id"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "requestId": requestId,
        "username": username,
        "fullName": fullName,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "birthdate": birthdate.toIso8601String(),
        "gender": gender,
        "address": address,
        "email_address": emailAddress,
        "mobile_number": mobileNumber,
        "status": status,
        "vc_issuer_id": vcIssuerId,
        "definition_id": definitionId,
        "verifier": verifier,
        "credential_request_details": credentialRequestDetails.toJson(),
        "channel_issuer_id": channelIssuerId,
        "reason": reason,
      };
}

class CredentialRequestDetails {
  List<Form> form;
  List<SupportingDocument> supportingDocuments;

  CredentialRequestDetails({
    required this.form,
    required this.supportingDocuments,
  });

  factory CredentialRequestDetails.fromJson(Map<String, dynamic> json) =>
      CredentialRequestDetails(
        form: List<Form>.from(json["form"].map((x) => Form.fromJson(x))),
        supportingDocuments: List<SupportingDocument>.from(
            json["supporting_documents"]
                .map((x) => SupportingDocument.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "form": List<dynamic>.from(form.map((x) => x.toJson())),
        "supporting_documents":
            List<dynamic>.from(supportingDocuments.map((x) => x.toJson())),
      };
}

class Form {
  String fieldName;
  String fieldValue;

  Form({
    required this.fieldName,
    required this.fieldValue,
  });

  factory Form.fromJson(Map<String, dynamic> json) => Form(
        fieldName: json["field_name"],
        fieldValue: json["field_value"],
      );

  Map<String, dynamic> toJson() => {
        "field_name": fieldName,
        "field_value": fieldValue,
      };
}

class SupportingDocument {
  String documentId;
  String documentName;
  DateTime created;
  DateTime updated;
  String filename;
  String thumbnail;
  String status;

  SupportingDocument({
    required this.documentId,
    required this.documentName,
    required this.created,
    required this.updated,
    required this.filename,
    required this.thumbnail,
    required this.status,
  });

  factory SupportingDocument.fromJson(Map<String, dynamic> json) =>
      SupportingDocument(
        documentId: json["document_id"],
        documentName: json["document_name"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        filename: json["filename"],
        thumbnail: json["thumbnail"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "document_id": documentId,
        "document_name": documentName,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "filename": filename,
        "thumbnail": thumbnail,
        "status": status,
      };
}

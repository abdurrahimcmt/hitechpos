
import 'dart:convert';

KitchenNotes kitchenNotesFromJson(String str) => KitchenNotes.fromJson(json.decode(str));

String kitchenNotesToJson(KitchenNotes data) => json.encode(data.toJson());

class KitchenNotes {
    String messageId;
    String message;
    List<NoteList> noteList;

    KitchenNotes({
        required this.messageId,
        required this.message,
        required this.noteList,
    });

    factory KitchenNotes.fromJson(Map<String, dynamic> json) => KitchenNotes(
        messageId: json["messageId"],
        message: json["message"],
        noteList: List<NoteList>.from(json["noteList"].map((x) => NoteList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "noteList": List<dynamic>.from(noteList.map((x) => x.toJson())),
    };
}

class NoteList {
    String vBranchId;
    String vNoteId;
    String vNoteType;
    String vNoteDetails;
    int iActive;
    String vCreatedBy;
    DateTime dCreatedDate;
    String vModifiedBy;
    DateTime dModifiedDate;

    NoteList({
        required this.vBranchId,
        required this.vNoteId,
        required this.vNoteType,
        required this.vNoteDetails,
        required this.iActive,
        required this.vCreatedBy,
        required this.dCreatedDate,
        required this.vModifiedBy,
        required this.dModifiedDate,
    });

    factory NoteList.fromJson(Map<String, dynamic> json) => NoteList(
        vBranchId: json["vBranchId"]!,
        vNoteId: json["vNoteId"],
        vNoteType: json["vNoteType"]!,
        vNoteDetails: json["vNoteDetails"],
        iActive: json["iActive"],
        vCreatedBy: json["vCreatedBy"]!,
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"]!,
        dModifiedDate: DateTime.parse(json["dModifiedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "vBranchId": vBranchId,
        "vNoteId": vNoteId,
        "vNoteType": vNoteType,
        "vNoteDetails": vNoteDetails,
        "iActive": iActive,
        "vCreatedBy": vCreatedBy,
        "dCreatedDate": dCreatedDate.toIso8601String(),
        "vModifiedBy": vModifiedBy,
        "dModifiedDate": dModifiedDate.toIso8601String(),
    };
}





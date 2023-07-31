import 'dart:convert';

InvoiceNotes invoiceNotesFromJson(String str) => InvoiceNotes.fromJson(json.decode(str));

String invoiceNotesToJson(InvoiceNotes data) => json.encode(data.toJson());

class InvoiceNotes {
    String messageId;
    String message;
    List<NoteList> noteList;

    InvoiceNotes({
        required this.messageId,
        required this.message,
        required this.noteList,
    });

    factory InvoiceNotes.fromJson(Map<String, dynamic> json) => InvoiceNotes(
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
        vBranchId: json["vBranchId"],
        vNoteId: json["vNoteId"],
        vNoteType: json["vNoteType"],
        vNoteDetails: json["vNoteDetails"],
        iActive: json["iActive"],
        vCreatedBy: json["vCreatedBy"],
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"],
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

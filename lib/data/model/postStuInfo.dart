class PostStuInfo {
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  PostStuInfo({this.statusCode, this.status, this.message, this.data});

  PostStuInfo.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status     = json['status'];
    message    = json['message'];
    data       = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode']              = this.statusCode;
    data['status']                  = this.status;
    data['message']                 = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
  PostStuInfo? copyWith({
    Data? data,
  }) {
    return PostStuInfo(
      data: data ?? this.data,
    );
  }
}

class Data {
  String? id;
  String? name;
  String? dOB;
  String? examDate;
  String? fatherName;
  String? motherName;

  Data({
      this.id,
      this.name,
      this.dOB,
      this.examDate,
      this.fatherName,
      this.motherName});

  Data.fromJson(Map<String, dynamic> json) {
    id         = json['Id'];
    name       = json['name'];
    dOB        = json['DOB'];
    examDate   = json['examDate'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id']         = this.id;
    data['name']       = this.name;
    data['DOB']        = this.dOB;
    data['examDate']   = this.examDate;
    data['fatherName'] = this.fatherName;
    data['motherName'] = this.motherName;
    return data;
  }
  Data copyWith({String? name, String? fatherName, String? motherName, String? DOB, String? examDate}) {
    return Data(name: name, fatherName: fatherName, motherName: motherName, dOB: DOB, examDate: examDate);
  }
}

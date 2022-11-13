class Emergencies {
  int? userId;
  String? description;
  String? datetime;
  String? location;
  int? emergencyType;

  Emergencies(
      {this.userId,
      this.description,
      this.datetime,
      this.location,
      this.emergencyType});

  Emergencies.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    description = json['description'];
    datetime = json['datetime'];
    location = json['location'];
    emergencyType = json['emergency_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['datetime'] = this.datetime;
    data['location'] = this.location;
    data['emergency_type'] = this.emergencyType;
    return data;
  }
}

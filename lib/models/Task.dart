class Task {
  String? id;
  String? title;
  String? desc;
  DateTime? dateTime;
  bool? isdone;
  Task(
      {required this.dateTime,
      required this.title,
      required this.desc,
      this.id = "",
      this.isdone = false});
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
          title: data["title"],
          desc: data["desc"],
          id: data["id"],
    isdone: data["isDone"]

        );
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "dateTime": dateTime?.millisecondsSinceEpoch,
      "isDone": isdone
    };
  }
}

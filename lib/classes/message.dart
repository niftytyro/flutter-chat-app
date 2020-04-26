enum Sender { me, you }

class Message {
  Sender sender;
  String data;
  DateTime time;
  Message({this.data, this.sender, this.time});
}

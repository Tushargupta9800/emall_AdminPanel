class OrderModel{

  bool OrderCompleted;
  bool venderPayment;
  String cancel;
  String ID;
  String VenderId;
  String customerId;
  String productId;
  String mobile;
  String address;
  String totalAmount;
  double ProductPrice;
  double DeliveryCharges;
  double Tax;
  double Total;
  bool isit;
  String state;
  String country;
  String quantity;
  String TransactionId;
  String color;
  String size;
  String date;

  void getAmounts(){
    ProductPrice = double.parse(totalAmount.split(":")[1].split(",")[0]);
    DeliveryCharges = double.parse(totalAmount.split(":")[2].split(",")[0]);
    Tax = double.parse(totalAmount.split(":")[3].split(",")[0]);
    Total = double.parse(totalAmount.split(":")[4].split(",")[0]);
    isit = (totalAmount.split(":")[5].split(",")[0].trim() == "Yes")?true:false;
    print(isit);
  }

  OrderModel(
      {this.OrderCompleted,
        this.venderPayment,
        this.cancel,
        this.ID,
        this.VenderId,
        this.customerId,
        this.productId,
        this.mobile,
        this.address,
        this.totalAmount,
        this.state,
        this.country,
        this.quantity,
        this.TransactionId,
        this.color,
        this.size,
        this.date,
        });

  OrderModel.fromJson(Map<String, dynamic> json) {
    OrderCompleted = json['User_payment'];
    venderPayment = json['vender_payment'];
    cancel = json['cancel'];
    ID = json['_id'];
    VenderId = json['User_id'];
    customerId = json['Customer_id'];
    productId = json['Product_id'];
    mobile = json['Mobile'];
    address = json['Address'];
    totalAmount = json['Total_amount'];
    state = json['State'];
    country = json['Country'];
    quantity = json['Quantity'];
    TransactionId = json['Payment_type'];
    color = json['color'];
    size = json['size'];
    date = json['Date'];
  }

}
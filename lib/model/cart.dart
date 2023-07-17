class Cart {
  String? itemId;
  String? itemName;
  String? cartQty;
  String? cartPrice;
  String? userId;
  String? barterId;
  String? cartDate;

  Cart({
    this.itemId,
    this.itemName, 
    this.cartQty, 
    this.cartPrice, 
    this.userId, 
    this.barterId,
    this.cartDate
    });

  Cart.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    cartQty = json['cart_qty'];
    cartPrice = json['cart_price'];
    userId = json['user_id'];
    barterId = json['barter_id'];
    cartDate = json['cart_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['cart_qty'] = cartQty;
    data['cart_price'] = cartPrice;
    data['user_id'] = userId;
    data['barter_id'] = barterId;
    data['cart_date'] = cartDate;
    return data;
  }
}

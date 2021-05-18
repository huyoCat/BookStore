package helper;

//∂©µ•¿‡
public class Order {
	private int OrderID;
	private String BookList;
	private String UserName;
	private float TotalPrice;
	private String OrderDay;
	private String Address;
	private String Phone;
	private int Orderstate;
	private int CancelOrder;
	
	public int getOrderID() {
		return OrderID;
	}
	public void setOrderID(int orderID) {
		OrderID = orderID;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getBookList() {
		return BookList;
	}
	public void setBookList(String bookList) {
		BookList = bookList;
	}
	public float getTotalPrice() {
		return TotalPrice;
	}
	public void setTotalPrice(float totalPrice) {
		TotalPrice = totalPrice;
	}
	public String getOrderDay() {
		return OrderDay;
	}
	public void setOrderDay(String orderDay) {
		OrderDay = orderDay;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	public int getOrderstate() {
		return Orderstate;
	}
	public void setOrderstate(int orderstate) {
		Orderstate = orderstate;
	}
	public int getCancelOrder() {
		return CancelOrder;
	}
	public void setCancelOrder(int cancelOrder) {
		CancelOrder = cancelOrder;
	}
}

package helper;


public class Book {
	private int BookID;
	private String BookName;
	private String BookISBN;
	private String BookWriter;
	private String BookIntro;
	private String BookPublisher;
	private String BookType;
	private String BookPic;
	private float BookCost;
	private float BookSell;
	private String OrderID;
	private String BookInDay;
	private String BookOutDay;
	private int BookCount;
	private int IsSell;
	
	public int getBookID() {
		return BookID;
	}
	public void setBookID(int bookID) {
		BookID = bookID;
	}
	public String getBookName() {
		return BookName;
	}
	public void setBookName(String bookName) {
		BookName = bookName;
	}
	public int getBookCount() {
		return BookCount;
	}
	public void setBookCount(int bookCount) {
		BookCount = bookCount;
	}
	public String getBookOutDay() {
		return BookOutDay;
	}
	public void setBookOutDay(String bookOutDay) {
		BookOutDay = bookOutDay;
	}
	public String getBookInDay() {
		return BookInDay;
	}
	public void setBookInDay(String bookInDay) {
		BookInDay = bookInDay;
	}
	public String getOrderID() {
		return OrderID;
	}
	public void setOrderID(String orderID) {
		OrderID = orderID;
	}
	public float getBookSell() {
		return BookSell;
	}
	public void setBookSell(float bookSell) {
		BookSell = bookSell;
	}
	public float getBookCost() {
		return BookCost;
	}
	public void setBookCost(float bookCost) {
		BookCost = bookCost;
	}
	public String getBookPic() {
		return BookPic;
	}
	public void setBookPic(String bookPic) {
		BookPic = bookPic;
	}
	public String getBookType() {
		return BookType;
	}
	public void setBookType(String bookType) {
		BookType = bookType;
	}
	public String getBookPublisher() {
		return BookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		BookPublisher = bookPublisher;
	}
	public String getBookIntro() {
		return BookIntro;
	}
	public void setBookIntro(String bookIntro) {
		BookIntro = bookIntro;
	}
	public String getBookWriter() {
		return BookWriter;
	}
	public void setBookWriter(String bookWriter) {
		BookWriter = bookWriter;
	}
	public String getBookISBN() {
		return BookISBN;
	}
	public void setBookISBN(String bookISBN) {
		BookISBN = bookISBN;
	}
	public int getIsSell() {
		return IsSell;
	}
	public void setIsSell(int isSell) {
		IsSell = isSell;
	}
}

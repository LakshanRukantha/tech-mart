package techmart;

public class Product {
    public int productId;
    public String productName;
    public String description;
    public String imageUrl;
    public String price;
    public int quantity;

    public Product(int productId, String productName, String description, String imageUrl, String price, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
        this.quantity = quantity;
    }
}
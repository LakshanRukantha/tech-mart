package techmart;

public class Product {
    public String productName;
    public String description;
    public String imageUrl;
    public String price;

    public Product(String productName, String description, String imageUrl, String price) {
        this.productName = productName;
        this.description = description;
        this.imageUrl = imageUrl;
        this.price = price;
    }
}
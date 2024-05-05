<%@page import="techmart.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="techmart.utils.DBConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <jsp:include page="./components/headers.jsp" />
        <title>TechMart</title>
    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />
        <div class="container pt-7">
            <div
                id="carouselExampleAutoplaying"
                class="carousel slide mb-4 w-100 mt-3"
                data-bs-ride="carousel"
                style="max-height: 250px !important; overflow: hidden"
                >
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="images/e1.jpg" class="d-block w-100" alt="..." />
                    </div>
                    <div class="carousel-item">
                        <img src="images/e2.jpg" class="d-block w-100" alt="..." />
                    </div>
                    <div class="carousel-item">
                        <img src="images/e3.jpg" class="d-block w-100" alt="..." />
                    </div>
                </div>
                <button
                    class="carousel-control-prev"
                    type="button"
                    data-bs-target="#carouselExampleAutoplaying"
                    data-bs-slide="prev"
                    >
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button
                    class="carousel-control-next"
                    type="button"
                    data-bs-target="#carouselExampleAutoplaying"
                    data-bs-slide="next"
                    >
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>

            <div class="mt-2" id="searchMessage">
            </div>
            <form id="searchField" role="search" method="post" action="SearchServlet">
                <div class="row text-center">
                    <div class="col-12 col-lg-6 mb-2 mb-lg-0">
                        <input
                            class="form-control w-full"
                            type="search"
                            name="search"
                            required
                            id="searchInput"
                            placeholder="Search"
                            aria-label="Search"
                            />
                    </div>
                    <div class="col-6 col-lg-4">
                        <select class="form-select w-full" id="categorySelect" name="category">
                            <option selected value="0">Select Category</option>
                            <%
                                String GET_CATEGORIES_STATEMENT = "SELECT * FROM categories";
                                try {
                                    Connection conn;
                                    ResultSet rs = null;
                                    conn = DBConnection.initializeDatabase();
                                    PreparedStatement getCategories = conn.prepareStatement(GET_CATEGORIES_STATEMENT);
                                    rs = getCategories.executeQuery();
                                    while (rs.next()) {
                                        String categoryId = rs.getString("category_id");
                                        String categoryName = rs.getString("name");
                            %>
                            <option value="<%= categoryId%>"><%= categoryName%></option>
                            <%
                                    }
                                    conn.close();
                                } catch (SQLException | NumberFormatException ex) {
                                    out.println(ex.getMessage());
                                    ex.printStackTrace();
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-6 col-lg-2">
                        <button
                            class="btn btn btn-outline-primary rounded w-100"
                            type="submit"
                            >
                            Search
                        </button>
                    </div>
                </div>
            </form>
            <%
                List<Product> itemList = (List<Product>) request.getAttribute("productList");
            %>
            <% if (itemList != null && !itemList.isEmpty()) { %>
            <h3 class="mt-2 mt-lg-4">Search Results</h3>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-2 g-lg-4">
                <% for (Product product : itemList) {%>
                <div class="col w-full">
                    <div class="block mx-auto card product-card p-2">
                        <div class="modal fade" id="exampleModal<%= product.getProductId()%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel"><%= product.getProductName()%></h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col w-full">
                                            <div class="block mx-auto p-2">
                                                <div class="card-image-wrapper">
                                                    <img src="<%= product.getImageUrl()%>" class="card-img-top rounded img-fluid h-100" alt="...">
                                                </div>
                                                <div class="pt-2 d-flex flex-column gap-1 bg-body">
                                                    <h4 class="mt-1 d-inline-block text-truncate"><%= product.getProductName()%></h4>
                                                    <p class="mt-1 d-inline-block text-truncate"><%= product.getDescription()%></p>
                                                    <span>Price <%= product.getPrice()%></span>
                                                    <span>
                                                        <% if (product.getQuantity() == 0) { %>
                                                        Out Of Stock
                                                        <% } else {%>
                                                        <%= product.getQuantity()%> Items Left
                                                        <% }%>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer d-flex flex-row flex-wrap">
                                        <a class="btn btn-warning flex-grow-1 fw-semibold <%= (product.getQuantity() == 0) ? "disabled" : ""%>" href="<%= (product.getQuantity() != 0) ? "BuyNowServlet?product_id=" + product.getProductId() : "#"%>" <% if (product.getQuantity() == 0) { %> style="pointer-events: none;" <% }%>>Buy Now</a>
                                        <a class="btn btn-outline-warning flex-grow-1" href="AddToCartServlet?product_id=<%= product.getProductId()%>">Add To Cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-image-wrapper" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal<%= product.getProductId()%>">
                            <img src="<%= product.getImageUrl()%>" class="card-img-top rounded img-fluid h-100" alt="<%= product.getProductName()%>">
                        </div>
                        <div class="pt-2 d-flex flex-column gap-1 bg-body">
                            <h4 class="mt-1 d-inline-block text-truncate"><%= product.getProductName()%></h4>
                            <span>Price <%= product.getPrice()%></span>
                            <span><%=  product.getQuantity()%> Items Left</span>
                            <div class="d-flex flex-row align-items-center pt-1 gap-2 w-100">
                                <a class="btn btn-warning flex-grow-1 fw-semibold <%= (product.getQuantity() == 0) ? "disabled" : ""%>" href="<%= (product.getQuantity() != 0) ? "BuyNowServlet?product_id=" + product.getProductId() : "#"%>" <% if (product.getQuantity() == 0) { %> style="pointer-events: none;" <% }%>>Buy Now</a>
                                <a class="btn btn-outline-warning flex-grow-1" href="AddToCartServlet?product_id=<%= product.getProductId()%>">Add To Cart</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else if (request.getParameter("search") != null) { %>
            <h3 class="mt-2 mt-lg-4">No results found</h3>
            <% }%>
            <h3 class="mt-2 mt-lg-4">Featured Products</h3>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-2 g-lg-4">
                <%
                    String GET_FEATURED_PRODUCTS_STATEMENT = "SELECT * FROM products ORDER BY product_id DESC LIMIT 12";
                    try {
                        Connection conn;
                        ResultSet rs = null;
                        conn = DBConnection.initializeDatabase();

                        PreparedStatement getfeaturedProducts = conn.prepareStatement(GET_FEATURED_PRODUCTS_STATEMENT);

                        rs = getfeaturedProducts.executeQuery();

                        while (rs.next()) {
                            String productId = rs.getString("product_id");
                            String name = rs.getString("name");
                            String imageUrl = rs.getString("image_url");
                            String description = rs.getString("description");
                            double price = rs.getDouble("price");
                            int quantity = rs.getInt("quantity");

                %>

                <div class="col w-full">
                    <div class="block mx-auto card product-card p-2">
                        <div class="modal fade" id="featuredProductModal<%= productId%>" tabindex="-1" aria-labelledby="featuredProductModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="featuredProductModalLabel"><%= name%></h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col w-full">
                                            <div class="block mx-auto p-2">
                                                <div class="card-image-wrapper">
                                                    <img src="<%= imageUrl%>" class="card-img-top rounded img-fluid h-100" alt="...">
                                                </div>
                                                <div class="pt-2 d-flex flex-column gap-1 bg-body">
                                                    <h4 class="mt-1 d-inline-block text-truncate"><%= name%></h4>
                                                    <p class="mt-1 d-inline-block text-truncate"><%= description%></p>
                                                    <span>Price <%= price%></span>
                                                    <span>
                                                        <% if (quantity == 0) { %>
                                                        Out Of Stock
                                                        <% } else {%>
                                                        <%= quantity%> Items Left
                                                        <% }%>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer d-flex flex-row flex-wrap">
                                        <a class="btn btn-warning flex-grow-1 fw-semibold <%= (quantity == 0) ? "disabled" : ""%>" href="<%= (quantity != 0) ? "BuyNowServlet?product_id=" + productId : "#"%>" <% if (quantity == 0) { %> style="pointer-events: none;" <% }%>>Buy Now</a>
                                        <a class="btn btn-outline-warning flex-grow-1" href="AddToCartServlet?product_id=<%= productId%>">Add To Cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-image-wrapper" type="button" data-bs-toggle="modal" data-bs-target="#featuredProductModal<%= productId%>">
                            <img src="<%= imageUrl%>" class="card-img-top rounded img-fluid h-100" alt="<%= name%>">
                        </div>
                        <div class="pt-2 d-flex flex-column gap-1 bg-body">
                            <h4 class="mt-1 d-inline-block text-truncate"><%= name%></h4>
                            <span>Price <%= price%></span>
                            <span>
                                <% if (quantity == 0) { %>
                                Out Of Stock
                                <% } else {%>
                                <%= quantity%> Items Left
                                <% }%>
                            </span>
                            <div class="d-flex flex-row align-items-center pt-1 gap-2 w-100">
                                <a class="btn btn-warning flex-grow-1 fw-semibold <%= (quantity == 0) ? "disabled" : ""%>" href="<%= (quantity != 0) ? "BuyNowServlet?product_id=" + productId : "#"%>" <% if (quantity == 0) { %> style="pointer-events: none;" <% }%>>Buy Now</a>
                                <a class="btn btn-outline-warning flex-grow-1" href="AddToCartServlet?product_id=<%= productId%>">Add To Cart</a>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                        conn.close();
                    } catch (SQLException | NumberFormatException ex) {
                        out.println(ex.getMessage());
                        ex.printStackTrace();
                    }
                %>
            </div>
        </div>
        <jsp:include page="./components/footer.jsp" />
    </body>
</html>

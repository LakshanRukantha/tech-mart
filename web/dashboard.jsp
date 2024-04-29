<%@page import="techmart.utils.AdminAuth"%>
<%@page import="techmart.utils.UserUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="techmart.utils.DBConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <jsp:include page="./components/headers.jsp" />
        <title>Dashboard | TechMart</title>
    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />
        <div class="container pt-7">
            <%
                HttpSession userSession = request.getSession();
                String userEmail = UserUtil.getUserEmail(userSession);
                String userName = null;

                if (userEmail == null || !AdminAuth.isAdminUser(userSession)) {
                    response.sendRedirect("register.jsp");
                } else {
                    userName = UserUtil.getUserName(userEmail);
                }
            %>
            <div class="mt-2" id="messageBox"></div>
            <h2 class="alert alert-secondary d-flex flex-wrap align-items-center justify-content-between">Dashboard <span class="fs-3"><span class="">Welcome, </span><%= userName%></span></h2>
            <div class="row">
                <div class="col-12 col-lg-8 mb-4">
                    <h1>Product Stock</h1>
                    <div class="table-responsive">
                        <table
                            class="table table-bordered border-primary-subtle table-hover table-condensed"
                            >
                            <thead>
                                <tr>
                                    <th scope="col">Product ID</th>
                                    <th scope="col">Product Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <%
                                    String GET_PRODUCTS_STATEMENT = "SELECT * FROM products";
                                    try {
                                        Connection conn;
                                        ResultSet rs = null;
                                        conn = DBConnection.initializeDatabase();
                                        PreparedStatement getCategories = conn.prepareStatement(GET_PRODUCTS_STATEMENT);
                                        rs = getCategories.executeQuery();
                                        while (rs.next()) {
                                            String productId = rs.getString("product_id");
                                            String name = rs.getString("name");
                                            String description = rs.getString("description");
                                            String price = rs.getString("price");
                                            String quantity = rs.getString("quantity");
                                %>
                                <tr>
                                    <td><%= productId%></td>
                                    <td><%= name%></td>
                                    <td>LKR: <%= price%></td>
                                    <td><%= quantity%></td>
                                    <td class="d-flex flex-row align-items-center gap-2">
                                        <button
                                            type="button"
                                            class="btn btn-primary"
                                            data-bs-toggle="modal"
                                            data-bs-target="#staticBackdrop<%= productId%>"
                                            >
                                            <i class="fa-regular fa-pen-to-square"></i>
                                        </button>

                                        <!-- Modal -->
                                        <div
                                            class="modal fade"
                                            id="staticBackdrop<%= productId%>"
                                            data-bs-backdrop="static"
                                            data-bs-keyboard="false"
                                            tabindex="-1"
                                            aria-labelledby="staticBackdropLabel<%= productId%>"
                                            aria-hidden="true"
                                            >
                                            <div class="modal-dialog">
                                                <form action="UpdateProductServlet" method="POST">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1
                                                                class="modal-title fs-5 text-capitalize"
                                                                id="staticBackdropLabel<%= productId%>"
                                                                >
                                                                <%= name%>
                                                            </h1>
                                                            <button
                                                                type="button"
                                                                class="btn-close"
                                                                data-bs-dismiss="modal"
                                                                aria-label="Close"
                                                                ></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3">
                                                                <label for="productId" class="form-label"
                                                                       >Product ID</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    name="productId"
                                                                    value="<%= productId%>"
                                                                    disabled
                                                                    />
                                                                <input
                                                                    type="number"
                                                                    id="productId"
                                                                    name="productId"
                                                                    value="<%= productId%>"
                                                                    hidden
                                                                    />
                                                                <div id="productIdHelpText" class="form-text">
                                                                    You can't change the product id here.
                                                                </div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="productName" class="form-label"
                                                                       >Product Name</label
                                                                >
                                                                <input
                                                                    type="text"
                                                                    class="form-control"
                                                                    id="productName"
                                                                    name="productName"
                                                                    value="<%= name%>"
                                                                    placeholder="Iphone 15 Pro Max"
                                                                    />
                                                            </div>
                                                            <div class="mb-3">
                                                                <label
                                                                    for="productDescription"
                                                                    class="form-label"
                                                                    >Description</label
                                                                >
                                                                <textarea
                                                                    class="form-control"
                                                                    id="productDescription"
                                                                    name="productDescription"
                                                                    rows="3"
                                                                    placeholder="Enter Product Description..."
                                                                    ><%= description%></textarea>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="productPrice" class="form-label"
                                                                       >Price (LKR)</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    id="productPrice"
                                                                    name="productPrice"
                                                                    value="<%= price%>"
                                                                    placeholder="420,000"
                                                                    />
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="productQuantity" class="form-label"
                                                                       >Quantity</label
                                                                >
                                                                <input
                                                                    type="number"
                                                                    class="form-control"
                                                                    id="productQuantity"
                                                                    value="<%= quantity%>"
                                                                    name="productQuantity"
                                                                    placeholder="25"
                                                                    />
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button
                                                                type="button"
                                                                class="btn btn-secondary"
                                                                data-bs-dismiss="modal"
                                                                >
                                                                Close
                                                            </button>
                                                            <button type="submit" class="btn btn-primary">
                                                                Update
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <a href="#" class="btn btn-danger"
                                           ><i class="fa-regular fa-trash-can"></i
                                            ></a>
                                    </td>
                                </tr>
                                <% }
                                        conn.close();
                                    } catch (SQLException | NumberFormatException ex) {
                                        out.println(ex.getMessage());
                                        ex.printStackTrace();
                                    } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-12 col-lg-4 mb-4">
                    <h1>Create Product</h1>
                    <form
                        id="createProductForm"
                        method="POST"
                        enctype="multipart/form-data"
                        >
                        <div class="mb-3">
                            <label for="product-name" class="form-label fw-semibold"
                                   >Product Name</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                id="productName"
                                name="productName"
                                placeholder="Enter Product Name..."
                                />
                        </div>
                        <div class="mb-3">
                            <label for="product-description" class="form-label fw-semibold"
                                   >Product Description</label
                            >
                            <textarea
                                class="form-control"
                                id="productDescription"
                                name="productDescription"
                                rows="3"
                                placeholder="Enter Product Description..."
                                ></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="product-logo" class="form-label fw-semibold"
                                   >Product Image</label
                            >
                            <input
                                type="file"
                                class="form-control"
                                name="productImage"
                                id="productImage"
                                accept="image/*"
                                />
                        </div>
                        <div class="mb-3">
                            <label for="product-category" class="form-label fw-semibold"
                                   >Product Category</label>
                            <select class="form-select" id="productCategory" name="productCategory">
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
                        <div class="mb-3">
                            <label for="price" class="form-label fw-semibold">Price</label>
                            <input
                                type="number"
                                class="form-control"
                                id="price"
                                name="price"
                                placeholder="Enter Price..."
                                />
                        </div>
                        <div class="mb-3">
                            <label for="quantity" class="form-label fw-semibold"
                                   >Quantity</label
                            >
                            <input
                                type="number"
                                class="form-control"
                                id="quantity"
                                name="quantity"
                                placeholder="Enter Quantity..."
                                />
                        </div>
                        <button
                            type="submit"
                            class="btn btn-primary w-100 d-flex flex-row align-items-center justify-content-center gap-1"
                            >
                            <i class="fa-solid fa-plus"></i>Add Product
                        </button>
                    </form>
                </div>
            </div>
            <div class="row">
                <!--                <div class="col-12 col-lg-6 mb-4">
                                            <h1>Active Orders</h1>
                                            <div class="table-responsive">


                                            </div>
                                        </div>-->
                <div class="col-12 mb-4">
                    <h1>Active Orders</h1>
                    <div class="table-responsive">
                        <table
                            class="table table-bordered border-primary-subtle table-hover table-condensed"
                            >
                            <thead>
                                <tr>
                                    <th scope="col">Order ID</th>
                                    <th scope="col">Product Image</th>
                                    <th scope="col">Product Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Buyer Name</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <%
                                    String GET_ACTIVE_ORDERS_STATEMENT = "SELECT * FROM orders where is_shipped=false";
                                    try {
                                        Connection conn;
                                        ResultSet rs = null;
                                        conn = DBConnection.initializeDatabase();
                                        PreparedStatement getCategories = conn.prepareStatement(GET_ACTIVE_ORDERS_STATEMENT);
                                        rs = getCategories.executeQuery();
                                        while (rs.next()) {
                                            String orderId = rs.getString("order_id");
                                            String productId = rs.getString("product_id");
                                            String name = rs.getString("name");
                                            double price = rs.getDouble("price");
                                            String address = rs.getString("address");
                                            int quantity = rs.getInt("quantity");
                                            String productName = "";
                                            String productImage = "";

                                            // Retrieve product name from the products table
                                            String GET_PRODUCT_NAME_STATEMENT = "SELECT * FROM products WHERE product_id = ?";
                                            PreparedStatement getProductName = conn.prepareStatement(GET_PRODUCT_NAME_STATEMENT);
                                            getProductName.setString(1, productId);
                                            ResultSet productResultSet = getProductName.executeQuery();
                                            if (productResultSet.next()) {
                                                productName = productResultSet.getString("name");
                                                productImage = productResultSet.getString("image_url");
                                            }
                                %>
                                <tr>
                                    <td><%= orderId%></td>
                                    <td class="d-flex justify-content-center align-items-center" style="max-height: 80px;">
                                        <div>
                                            <img class="img-fluid" style="max-height: 80px;" src=<%= productImage%> alt="Product_Image"/>
                                        </div>
                                    </td>
                                    <td><%= productName%></td>
                                    <td><%= price%></td>
                                    <td><%= name%></td>
                                    <td><%= address%></td>
                                    <td><%= quantity%></td>
                                    <td class="d-flex justify-content-center align-items-center" style="min-height: 100px">
                                        <div class="d-flex justify-content-evenly gap-2 flex-row">
                                            <a
                                                href="#"
                                                class="btn btn-primary d-flex flex-row flex-grow-1 align-items-center justify-content-center gap-1"
                                                ><i class="fa-solid fa-truck-arrow-right"></i>Ship</a
                                            >
                                            <a
                                                href="#"
                                                class="btn btn-danger d-flex flex-row flex-grow-1 align-items-center justify-content-center gap-1"
                                                ><i class="fa-solid fa-trash-can"></i>Cancel</a
                                            >
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                        conn.close();
                                    } catch (SQLException | NumberFormatException ex) {
                                        out.println(ex.getMessage());
                                        ex.printStackTrace();
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-12 mb-4">
                    <h1>Current Users</h1>
                    <div class="table-responsive">
                        <table
                            class="table table-bordered border-primary-subtle table-hover table-condensed"
                            >
                            <thead>
                                <tr>
                                    <th scope="col">User ID</th>
                                    <th scope="col">User Email</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Role</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider">
                                <%
                                    String GET_USERS_STATEMENT = "SELECT * FROM users ORDER BY user_id ASC";
                                    try {
                                        Connection conn;
                                        ResultSet rs = null;
                                        conn = DBConnection.initializeDatabase();
                                        PreparedStatement getCategories = conn.prepareStatement(GET_USERS_STATEMENT);
                                        rs = getCategories.executeQuery();
                                        while (rs.next()) {
                                            String userId = rs.getString("user_id");
                                            String email = rs.getString("email");
                                            String name = rs.getString("name");
                                            String role = rs.getString("role");

                                %>
                                <tr>
                                    <td><%= userId%></td>
                                    <td><%= email%></td>
                                    <td><%= name%></td>
                                    <td><%= role%></td>
                                    <td>
                                        <a href="DeleteUser?user_id=<%= userId%>" class="btn btn-danger"
                                           onclick="return confirm('Are you sure you want to delete this user?');">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </a>

                                    </td>
                                </tr>
                                <%                                        }
                                        conn.close();
                                    } catch (SQLException | NumberFormatException ex) {
                                        out.println(ex.getMessage());
                                        ex.printStackTrace();
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

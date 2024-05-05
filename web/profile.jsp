<%@page import="techmart.utils.AdminAuth"%>
<%@page import="techmart.utils.UserUtil"%>
<%@page import="java.sql.*"%>
<%@page import="techmart.utils.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="./components/headers.jsp" />
        <title>Profile | TechMart</title>
    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />
        <div class="container pt-7">
            <%
                HttpSession userSession = request.getSession();
                String userEmail = (String) userSession.getAttribute("email");
                String userName = UserUtil.getUserName(userEmail);
                String roleName = AdminAuth.isAdminUser(userSession) ? "Admin User" : "Standard User";
                String userId = "";

                try {
                    Connection conn = DBConnection.initializeDatabase();
                    String GET_USER_INFO = "SELECT user_id FROM users WHERE email = ?";
                    PreparedStatement getUserInfoStmt = conn.prepareStatement(GET_USER_INFO);
                    getUserInfoStmt.setString(1, userEmail);
                    ResultSet rs = getUserInfoStmt.executeQuery();

                    if (rs.next()) {
                        userId = rs.getString("user_id");
                    }
                    conn.close();
                } catch (SQLException | ClassNotFoundException ex) {
                    ex.printStackTrace();
                }
            %>

            <h3 class="alert alert-secondary">Welcome, <%= userName%></h3>
            <div class="row">
                <div class="col-12 col-lg-6 p-2">
                    <h3>My Profile</h3>
                    <hr/>
                    <div class="card p-2 d-flex flex-column gap-2">
                        <div class="d-flex flex-column bg-light px-2">
                            <span class="fs-4 fw-semibold">User ID</span>
                            <span class="fs-6 fw-bold text-secondary">#<%= userId%></span>
                        </div>
                        <div class="d-flex flex-column bg-light px-2">
                            <span class="fs-4 fw-semibold">Full Name</span>
                            <span class="fs-6 fw-bold text-secondary"><%= userName%></span>
                        </div>
                        <div class="d-flex flex-column bg-light px-2">
                            <span class="fs-4 fw-semibold">Email Address</span>
                            <span class="fs-6 fw-bold text-secondary"><%= userEmail%></span>
                        </div>
                        <div class="d-flex flex-column bg-light px-2">
                            <span class="fs-4 fw-semibold">Role</span>
                            <span class="fs-6 fw-bold text-secondary"><%= roleName%></span>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-6 p-2">
                    <h3>Active Orders</h3>
                    <hr/>
                    <div class="card p-2 d-flex flex-column gap-2">
                        <%
                            try {
                                Connection conn = DBConnection.initializeDatabase();
                                String GET_ORDERS_QUERY = "SELECT * FROM orders WHERE user_email = ?";
                                PreparedStatement getOrdersStmt = conn.prepareStatement(GET_ORDERS_QUERY);
                                getOrdersStmt.setString(1, userEmail);
                                ResultSet ordersResultSet = getOrdersStmt.executeQuery();

                                while (ordersResultSet.next()) {
                                    boolean isShipped = ordersResultSet.getBoolean("is_shipped");
                                    if (!isShipped) {
                                        int orderId = ordersResultSet.getInt("order_id");
                                        int productId = ordersResultSet.getInt("product_id");
                                        int quantity = ordersResultSet.getInt("quantity");
                                        double price = ordersResultSet.getDouble("price");

                                        String GET_PRODUCT_NAME_QUERY = "SELECT name FROM products WHERE product_id = ?";
                                        PreparedStatement getProductNameStmt = conn.prepareStatement(GET_PRODUCT_NAME_QUERY);
                                        getProductNameStmt.setInt(1, productId);
                                        ResultSet productNameResultSet = getProductNameStmt.executeQuery();
                                        String productName = "";
                                        if (productNameResultSet.next()) {
                                            productName = productNameResultSet.getString("name");
                                        }
                        %>
                        <span class="fs-5 fw-semibold">Order <span class="text-info">#TM2024<%= orderId%></span></span>
                        <div class="d-flex flex-column justify-content-evenly p-2 border border-info bg-light rounded">
                            <div class="d-flex border-bottom border-info pb-1 flex-column">
                                <span class="fs-5 fw-semibold">Product</span>
                                <span class="fs-6 fw-bold text-secondary"><%= productName%></span>
                            </div>
                            <div class="d-flex border-bottom border-info pb-1 flex-column">
                                <span class="fs-5 fw-semibold">Quantity</span>
                                <span class="fs-6 fw-bold text-secondary"><%= quantity%></span>
                            </div>
                            <div class="d-flex flex-column">
                                <span class="fs-5 fw-semibold">Price</span>
                                <span class="fs-6 fw-bold text-secondary">LKR <%=price%></span>
                            </div>
                        </div>
                        <%
                                    }
                                }
                                conn.close();
                            } catch (SQLException | ClassNotFoundException ex) {
                                ex.printStackTrace();
                            }
                        %>
                    </div>
                    <h3 class="mt-4">Shipped Orders</h3>
                    <hr/>
                    <div class="card p-2 d-flex flex-column gap-2">
                        <%
                            try {
                                Connection conn = DBConnection.initializeDatabase();
                                String GET_ORDERS_QUERY = "SELECT * FROM orders WHERE user_email = ?";
                                PreparedStatement getOrdersStmt = conn.prepareStatement(GET_ORDERS_QUERY);
                                getOrdersStmt.setString(1, userEmail);
                                ResultSet ordersResultSet = getOrdersStmt.executeQuery();

                                while (ordersResultSet.next()) {
                                    boolean isShipped = ordersResultSet.getBoolean("is_shipped");
                                    if (isShipped) {
                                        int orderId = ordersResultSet.getInt("order_id");
                                        int productId = ordersResultSet.getInt("product_id");
                                        int quantity = ordersResultSet.getInt("quantity");
                                        double price = ordersResultSet.getDouble("price");

                                        String GET_PRODUCT_NAME_QUERY = "SELECT name FROM products WHERE product_id = ?";
                                        PreparedStatement getProductNameStmt = conn.prepareStatement(GET_PRODUCT_NAME_QUERY);
                                        getProductNameStmt.setInt(1, productId);
                                        ResultSet productNameResultSet = getProductNameStmt.executeQuery();
                                        String productName = "";
                                        if (productNameResultSet.next()) {
                                            productName = productNameResultSet.getString("name");
                                        }
                        %>
                        <span class="fs-5 fw-semibold">Order <span class="text-info">#TM2024<%= orderId%></span></span>
                        <div class="d-flex flex-column justify-content-evenly p-2 border border-info bg-light rounded">
                            <div class="d-flex border-bottom border-info pb-1 flex-grow-1 flex-column">
                                <span class="fs-5 fw-semibold">Product</span>
                                <span class="fs-6 fw-bold text-secondary"><%= productName%></span>
                            </div>
                            <div class="d-flex border-bottom border-info pb-1 flex-grow-1 flex-column">
                                <span class="fs-5 fw-semibold">Quantity</span>
                                <span class="fs-6 fw-bold text-secondary"><%= quantity%></span>
                            </div>
                            <div class="d-flex flex-grow-1 flex-column">
                                <span class="fs-5 fw-semibold">Price</span>
                                <span class="fs-6 fw-bold text-secondary">LKR <%=price%></span>
                            </div>
                        </div>
                        <%
                                    }
                                }
                                conn.close();
                            } catch (SQLException | ClassNotFoundException ex) {
                                ex.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="./components/footer.jsp" />
    </body>
</html>

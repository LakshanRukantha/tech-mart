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
        <title>Cart</title>
    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />
        <div class="container pt-7">
            <h2 class="mt-2 mt-lg-3">Your Cart</h2>
            <div class="row g-2 mt-1 mt-lg-2">
                <%
                    HttpSession userSession = request.getSession();
                    String userEmail = UserUtil.getUserEmail(userSession);

                    String GET_PRODUCT_IDS = "SELECT product_id FROM cart WHERE user_email=?";
                    String GET_PRODUCT_INFO = "SELECT name, description, price, image_url FROM products WHERE product_id=?";

                    try {
                        Connection conn;
                        ResultSet rsProductIds = null;
                        ResultSet rsProductInfo = null;
                        conn = DBConnection.initializeDatabase();

                        PreparedStatement getProductIds = conn.prepareStatement(GET_PRODUCT_IDS);
                        getProductIds.setString(1, userEmail);
                        rsProductIds = getProductIds.executeQuery();

                        while (rsProductIds.next()) {
                            int productId = rsProductIds.getInt("product_id");

                            PreparedStatement getProductInfo = conn.prepareStatement(GET_PRODUCT_INFO);
                            getProductInfo.setInt(1, productId);
                            rsProductInfo = getProductInfo.executeQuery();

                            if (rsProductInfo.next()) {
                                String productName = rsProductInfo.getString("name");
                                double price = rsProductInfo.getDouble("price");
                                String imageUrl = rsProductInfo.getString("image_url");
                %>
                <div class="col-12 col-lg-6 p-2">
                    <div class="card p-2 p-lg-3 d-flex gap-2 flex-row overflow-hidden">
                        <div class="h-full"><img class="cart-image img-fluid rounded" src="<%= imageUrl%>" alt="<%= productName%>"/></div>
                        <div class="d-flex flex-column flex-grow-1 flex-md-row align-items-center">
                            <div class="d-flex w-100 flex-column">
                                <span class="fs-4 fw-semibold text-truncate"><%= productName%></span>
                                <span class="fs-5">Price <%= price%></span>
                            </div>
                            <div class="d-flex flex-md-column w-100 flex-row gap-2">
                                <a class="btn text-nowrap flex-grow-1 btn-warning fw-semibold" href="BuyNowServlet?product_id=<%= productId%>" >Buy Now</a>
                                <a class="btn btn-danger flex-grow-1 fw-semibold" href="DeleteFromCartServlet?product_id=<%= productId%>" >Remove</a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                            }
                        }
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
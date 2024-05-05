<%@page import="techmart.utils.AdminAuth"%>
<%@page import="techmart.utils.UserUtil"%>
<%@page import="techmart.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="./components/headers.jsp" />
        <title>Checkout</title>
    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />
        <div class="container pt-7">
            <div class="row mt-2 mt-lg-4">
                <%
                    HttpSession userSession = request.getSession();
                    String userEmail = UserUtil.getUserEmail(userSession);

                    if (userEmail == null) {
                        response.sendRedirect("register.jsp");
                    } else {

                        Product product = (Product) request.getAttribute("product");

                        if (product != null) {
                %>
                <div class="col-12 col-md-6 p-2">
                    <h2>Product Details</h2>
                    <div class="card d-flex flex-column rounded p-2">
                        <div>
                            <span class="fw-semibold fs-3">Product</span>
                            <p class="fs-4 text-capitalize"><%= product.getProductName()%></p>
                            <hr>
                        </div>
                        <div>
                            <span class="fw-semibold fs-3">Description</span>
                            <p><%= product.getDescription()%></p>
                            <hr>
                        </div>
                        <div>
                            <span class="fw-semibold fs-3">Price</span>
                            <p><%= product.getPrice()%></p>
                            <hr>
                        </div>
                        <div>
                            <span class="fw-semibold fs-3">Stocks In Store</span>
                            <p><%= product.getQuantity()%></p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6 p-2">
                    <h2>Order Details</h2>
                    <div class="mt-2" id="messageBox"></div>
                    <form
                        id="orderPlaceForm"
                        method="POST"
                        class="card p-2"
                        >
                        <div class="mb-3">
                            <label for="fullName" class="form-label fw-semibold"
                                   >Full Name</label
                            >
                            <input
                                type="text"
                                class="form-control"
                                id="fullName"
                                name="fullName"
                                placeholder="Enter your full name..."
                                />
                        </div>
                        <div class="mb-3">
                            <label for="orderEmail" class="form-label fw-semibold"
                                   >Email</label
                            >
                            <input
                                type="email"
                                class="form-control"
                                id="orderEmail"
                                name="orderEmail"
                                placeholder="Enter your email address..."
                                />
                        </div>
                        <div class="mb-3">
                            <label for="orderAddress" class="form-label fw-semibold"
                                   >Address</label
                            >
                            <textarea
                                class="form-control"
                                id="orderAddress"
                                name="orderAddress"
                                rows="3"
                                placeholder="Enter ordering address..."
                                ></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="quantity" class="form-label fw-semibold">Quantity</label>
                            <input
                                type="number"
                                class="form-control"
                                id="quantity"
                                name="quantity"
                                placeholder="Enter order quantity..."
                                />
                        </div>
                        <input type="number" name="productId" value="<%= product.getProductId()%>" hidden />
                        <input type="number" name="productPrice" value="<%= product.getPrice()%>" hidden />
                        <button
                            type="submit"
                            class="btn btn-primary w-100 d-flex flex-row align-items-center justify-content-center gap-1"
                            >
                            <i class="fa-solid fa-truck-fast"></i>Place Order
                        </button>
                    </form>
                    <div class="card p-2 mt-2 mt-lg-4">
                        <span class="fs-5 fw-semibold text-secondary">Your order will be delivered in less than 3 working days. Payment can be made upon receipt of your order.</span>
                    </div>
                </div>
                <% } else { %>
                <div class="alert alert-danger" role="alert">
                    No product found!
                </div>
                <% }
                    }
                %>
            </div>
        </div>
        <jsp:include page="./components/footer.jsp" />
    </body>
</html>

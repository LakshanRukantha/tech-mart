<%@page import="techmart.Product"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

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
                        <select
                            class="form-select w-full" id="categorySelect"
                            name="category"
                            required
                            aria-label="Default select example"
                            >
                            <option>Select Category</option>
                            <option value="1">Mobile Phones</option>
                            <option value="2">Laptops</option>
                            <option value="3">Chargers & Cables</option>
                            <option value="4">Wearables</option>
                            <option value="5">Cameras</option>
                            <option value="6">Sounds</option>
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
                        <div class="card-image-wrapper">
                            <img src="<%= product.imageUrl%>" class="card-img-top rounded img-fluid h-100" alt="<%= product.productName%>">
                        </div>
                        <div class="pt-2 d-flex flex-column gap-1 bg-body">
                            <h4 class="mt-1 d-inline-block text-truncate"><%= product.productName%></h4>
                            <span>Price <%= product.price%></span>
                            <div class="d-flex flex-row align-items-center pt-1 gap-2 w-100">
                                <button class="btn btn-warning flex-grow-1 fw-semibold">Buy Now</button>
                                <button class="btn btn-outline-warning flex-grow-1">Add To Cart</button>
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
                <div class="col w-full">
                    <div class="block mx-auto card product-card p-2">
                        <div class="card-image-wrapper">
                            <img src="./images/iphone.jpg" class="card-img-top rounded img-fluid h-100" alt="...">
                        </div>
                        <div class="pt-2 d-flex flex-column gap-1 bg-body">
                            <h4 class="mt-1 d-inline-block text-truncate">Iphone 14 Pro Max</h4>
                            <span>Price 350000.00</span>
                            <div class="d-flex flex-row align-items-center pt-1 gap-2 w-100">
                                <button class="btn btn-warning flex-grow-1 fw-semibold">Buy Now</button>
                                <button class="btn btn-outline-warning flex-grow-1">Add To Cart</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

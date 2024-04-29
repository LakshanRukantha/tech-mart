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
      <!--Home Page Content-->

      <!-- carousel-->

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

      <!-- search bar-->

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
    if(itemList != null) { 
        if(!itemList.isEmpty()) {
%>
<div class="card-header mb-0 mt-4">
    <h3>Search Results</h3>
</div>
<div class="container">
    <div class="row">
        <% 
            int count = 0; 
            for (Product product : itemList) { 
                if (count % 4 == 0) { 
        %>
        </div> <!-- Close previous row -->
        <div class="row"> <!-- Start new row -->
        <% 
            } 
        %>
        <div class="col-md-3 my-3">
            <div class="card rounded-0 border-0 w-100" style="width: 18rem; background-color: #f5f5f5">
                <img class="card-img-top rounded-0" src="<%= product.imageUrl %>" alt="Product Image" />
                <div class="card-body">
                    <h5 class="card-title" style="text-align: center"><%= product.productName %></h5>
                    <p class="card-text"><%= product.description %> .</p>
                    <h6 class="price">Rs.<%= product.price %></h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <a href="#" class="btn btn-outline-primary btn-sm">Add to cart</a>
                        <a href="#" class="btn btn-outline-primary btn-sm">Buy Now</a>
                    </div>
                </div>
            </div>
        </div>
        <% 
            count++; 
            } 
        %>
    </div> <!-- Close last row -->
</div>
<% 
        } else {
%>
<div class="card-header mb-0 mt-4">
    <h3> Search No Result</h3>
</div>
<% 
        }
    }
%>

<div class="card-header mb-0 mt-4"><h3>Just For You</h3></div>
      <div class="row">
          <% for(int j=0; j<12; j++) { %>
        <div class="col-md-3 my-3">
          <div
            class="card w-100 rounded-0 border-0"
            style="width: 18rem; background-color: #f5f5f5"
          >
            <img
              src="images/smoking-e-cigarette.jpg"
              class="card-img-top rounded-0"
              alt="..."
            />
            <div class="card-body">
              <h5 class="card-title" style="text-align: center">Card title</h5>
              <h6 class="price">Price: $30</h6>
              <div class="mt-3 d-flex justify-content-between">
                <a href="#" class="btn btn-outline-primary btn-sm"
                  >Add to cart</a
                >
                <a href="#" class="btn btn-outline-primary btn-sm">Buy Now</a>
              </div>
            </div>
          </div>
        </div>
          <% } %>
      </div>

      <!-- cards-->

      
    </div>
  </body>
</html>

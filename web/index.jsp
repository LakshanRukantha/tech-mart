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
            <img src="product-image/e1.jpg" class="d-block w-100" alt="..." />
          </div>
          <div class="carousel-item">
            <img src="product-image/e2.jpg" class="d-block w-100" alt="..." />
          </div>
          <div class="carousel-item">
            <img src="product-image/e3.jpg" class="d-block w-100" alt="..." />
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

      <!-- search bar-->

      <form role="search" method="get" action="">
        <div class="row text-center">
          <div class="col-12 col-lg-6 mb-2 mb-lg-0">
            <input
              class="form-control w-full"
              type="search"
              placeholder="Search"
              aria-label="Search"
            />
          </div>

          <div class="col-6 col-lg-4">
            <select
              class="form-select w-full"
              aria-label="Default select example"
            >
              <option selected>Open this select menu</option>
              <option value="1">One</option>
              <option value="2">Two</option>
              <option value="3">Three</option>
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

      <!-- cards-->

      <div class="card-header mb-0 mt-4"><h3>Just For You</h3></div>
      <div class="row">
        <% for(int i = 0; i<24; i++) { %>

        <div class="col-md-3 my-3">
          <div
            class="card w-100 rounded-0 border-0"
            style="width: 18rem; background-color: #f5f5f5"
          >
            <img
              src="product-image/smoking-e-cigarette.jpg"
              class="card-img-top rounded-0"
              alt="..."
            />
            <div class="card-body">
              <h5 class="card-title">Card title</h5>
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
    </div>
  </body>
</html>

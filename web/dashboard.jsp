<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
      <div class="row">
        <div class="col-12 col-lg-8">
          <h1>Active Orders</h1>
          <div class="table-responsive">
            <table
              class="table table-bordered border-primary-subtle table-hover table-condensed"
            >
              <thead>
                <tr>
                  <th scope="col">Order ID</th>
                  <th scope="col">Product</th>
                  <th scope="col">Price</th>
                  <th scope="col">Name</th>
                  <th scope="col">Address</th>
                  <th scope="col">Action</th>
                </tr>
              </thead>
              <tbody class="table-group-divider">
                <tr>
                  <td>1234</td>
                  <td>Iphone 15 Pro Max</td>
                  <td>LKR 402500.00</td>
                  <td>Kasun Sampath</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
                <tr>
                  <td>1234</td>
                  <td>Asus Vivobook 15</td>
                  <td>LKR 221500.00</td>
                  <td>Lakshan Rukantha</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
                <tr>
                  <td>1234</td>
                  <td>Asus Vivobook 15</td>
                  <td>LKR 221500.00</td>
                  <td>Lakshan Rukantha</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
                <tr>
                  <td>1234</td>
                  <td>Asus Vivobook 15</td>
                  <td>LKR 221500.00</td>
                  <td>Lakshan Rukantha</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
                <tr>
                  <td>1234</td>
                  <td>Asus Vivobook 15</td>
                  <td>LKR 221500.00</td>
                  <td>Lakshan Rukantha</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
                <tr>
                  <td>1234</td>
                  <td>Asus Vivobook 15</td>
                  <td>LKR 221500.00</td>
                  <td>Lakshan Rukantha</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
                <tr>
                  <td>1234</td>
                  <td>Asus Vivobook 15</td>
                  <td>LKR 221500.00</td>
                  <td>Lakshan Rukantha</td>
                  <td>Colombo, Sri Lanka</td>
                  <td><a href="#" class="btn btn-primary">Ship Order</a></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-12 col-lg-4">
          <h1>Create Product</h1>
          <form>
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
                required
              />
            </div>
            <div class="mb-3">
              <label for="product-category" class="form-label fw-semibold"
                >Product Category</label
              >
              <select
                class="form-select"
                id="productCategory"
                name="productCategory"
              >
                <option selected>Select Category</option>
                <option value="1"></option>
                <option value="2"></option>
                <option value="3"></option>
                <option value="4"></option>
                <option value="5"></option>
                <option value="6"></option>
                <option value="7"></option>
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
            <button type="submit" class="btn btn-primary w-100">
              Add Product
            </button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>

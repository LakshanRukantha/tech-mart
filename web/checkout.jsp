<%-- 
    Document   : checkout
    Created on : Apr 28, 2024, 1:09:03 PM
    Author     : Sharmila
--%>
<div style="background-color: transparent;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2); 
            padding: 20px; 
            width: 500px;  
            margin: 0 auto" >

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="./components/headers.jsp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form
              class="form mt-3"
              id="jobPostForm"
              method="post"
              action="checkoutservlet">

              <div class="mb-3">
                  <label for="First-name" class="form-label">Full Name:</label><br>
                <input
                  type="text"
                  class="form-control"
                  id="FName"
                  name="FName"
                  placeholder="Enter your Full Name"
                  />
              </div>
              <!--<div class="mb-3">
                <label for="Last-name" class="form-label">Last Name:</label><br>
                <input
                  type="text"
                  class="form-control"
                  id="LName"
                  name="LName"
                  placeholder="Enter your Last Name"
                />
              </div>  !-->
              <div class="mb-3">
                <label for="Email" class="form-label">Email:</label><br>
                <input
                  type="email"
                  class="form-control"
                  id="Email"
                  name="Email"
                  placeholder="you@example.com"
                />
              </div>
              <div class="mb-3">
                <label for="Address" class="form-label">Address (optional):</label><br>
                <input
                  type="Address"
                  class="form-control"
                  id="Address"
                  name="Address"
                  placeholder="1234; Main Street"
                />
              </div>
          <!--  <div class="mb-3">
                <label for="Address" class="form-label">Address 2 (optional):</label><br>
                <input
                  type="Address2"
                  class="form-control"
                  id="Address2"
                  name="Address2"
                  placeholder="Apartment or suite"
                />
              </div> !-->
              <div class="mb-3">
                  <label for="Quantity" class="form-label">Quantity:</label><br>
                <input
                  type="number"
                  class="Quantity"
                  id="Quantity"
                  name="Quantity"
                  min="1"
                  value="1"
                  required>
                
              </div>
              <div class="d-grid gap-2">
                <button class="btn btn-primary" type="submit">Checkout</button>
                
              </div>
            </form>

    </body>
</html>
</div>
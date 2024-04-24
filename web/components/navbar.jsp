<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav
  class="navbar navbar-expand-lg fixed-top w-full shadow-sm bg-body-tertiary"
>
  <div class="container">
    <a class="navbar-brand" href="index.jsp">TechMart</a>
    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div
      class="collapse md:d-flex col navbar-collapse"
      id="navbarSupportedContent"
    >
      <ul class="navbar-nav flex-grow-1 mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="./index.jsp"
            >Home</a
          >
        </li>
        <li class="nav-item">
          <a class="nav-link" href="./about.jsp">About Us</a>
        </li>
      </ul>
      <div class="d-flex gap-2 align-items-center">
        <a href="#" class="btn btn-primary">Sign In</a>
        <a href="./register.jsp" class="btn btn-primary">Register</a>
      </div>
    </div>
  </div>
</nav>

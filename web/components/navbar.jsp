<%@page import="techmart.utils.AdminAuth"%>
<%@page import="techmart.utils.UserUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav
    class="navbar navbar-expand-lg fixed-top w-full shadow-sm bg-body-tertiary"
    >
    <%
        HttpSession userSession = request.getSession();
        String userEmail = UserUtil.getUserEmail(userSession);
        String userName = UserUtil.getUserName(userEmail);
        boolean isAdmin = (userSession != null) && AdminAuth.isAdminUser(userSession);

        String currentPage = request.getRequestURI();
        String pageNameWithoutExtension = currentPage.substring(currentPage.lastIndexOf("/") + 1).replace(".jsp", "").toLowerCase().trim();
    %>
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
            <div
                class="d-flex flex-lg-row flex-column gap-2 align-items-lg-center align-items-start"
                style="padding-left: 0"
                >
                <%-- Admin & Logged In --%>
                <% if (isAdmin && userEmail != null && !pageNameWithoutExtension.equalsIgnoreCase("dashboard")) { %>
                <a href="./dashboard.jsp" class="btn btn-primary">Dashboard</a>
                <% } %>

                <%-- Normal logged in --%>
                <% if (!isAdmin && userEmail != null) { %>
                <a href="./cart.jsp" class="btn btn-outline-warning text-brand-color d-flex align-items-center gap-2">
                    <i class="fa-solid fa-cart-plus fs-4"></i>Cart
                </a>
                <% } %>

                <%-- Not logged in --%>
                <% if (userEmail == null) { %>
                <a href="./signin.jsp" class="btn btn-primary">Sign In</a>
                <a href="./register.jsp" class="btn btn-primary">Register</a>
                <% } else {%>

                <!--All Logged In-->
                <a href="./profile.jsp" class="btn btn-primary d-flex flex-row align-items-center gap-2"><i class="fa-regular fa-circle-user"></i><span><%= userName%></span></a>
                <a href="SignOutServlet" class="btn btn-outline-secondary">Sign Out</a>
                <% }%>
            </div>
        </div>
    </div>
</nav>

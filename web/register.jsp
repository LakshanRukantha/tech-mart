<%@page import="techmart.utils.UserUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="techmart.utils.DBConnection"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="./components/headers.jsp" />
        <title>Register | TechMart</title>
        <script type="text/javascript">
            // JavaScript function to display an alert box with the error message
            function displayErrorMessage(message) {
                const registerAlertMessageArea = document.getElementById("registerAlertMessageArea");
                if (message.trim() !== '') {
                    registerAlertMessageArea.classList.add("alert", "alert-danger", "mt-4", "mb-0");
                    registerAlertMessageArea.innerText = message;
                } else {
                    registerAlertMessageArea.innerText = ''; // Clear the message if it's empty
                    registerAlertMessageArea.classList.remove("alert", "alert-danger", "mt-4", "mb-0"); // Remove the classes
                }
            }
        </script>


    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />
        <div class="container pt-7">
            <%
                // Check if the user is already logged in
                HttpSession userSession = request.getSession();
                String userEmail = UserUtil.getUserEmail(userSession);

                if (userEmail != null) {
                    // User is already logged in, redirect to index.jsp
                    response.sendRedirect("index.jsp");
                }
            %>
            <div class="d-flex flex-column w-100 align-items-center justify-content-center px-1 py-0 mt-3">
                <form id="registerform"class="sign-in-form form bg-body-light rounded-2 shadow px-3 py-4 d-flex align-self-center flex-column justify-content-center w-100 mx-auto my-auto login-form"  action="RegisterServlet" method="Post">
                    <h2 class="text-center mb-2 h1">Register</h2>
                    <div class="mb-3">
                        <label for="Fullname" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter Full Name...">
                    </div>
                    <div class="mb-3">
                        <label for="Email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter Email...">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password...">
                    </div>
                    <div class="mb-3">
                        <label for="confirmpassword" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmpassword" name="confirmpassword" placeholder="Confirm Password...">
                        <span class="mt-2 float-end  fw-light fst-italic">Already have an account?<a class="fst-normal fw-medium" href="signin.jsp"> Sign in</a></span>
                    </div>
                    <div class="d-flex gap-3">
                        <a class="btn btn-outline-secondary w-50" href="index.jsp">Cancel</a>
                        <button class="btn btn-primary w-50" type="submit">Register</button>
                    </div>
                    <span class="text-center mx-3 my-3">- Or -</span>
                    <button class="btn btn-secondary w-100 icon-button" type="button">
                        <i class="fab fa-google"></i>
                        <span>Continue with Google</span>
                    </button>
                    <div id="registerAlertMessageArea" class=""   role="alert"> <%-- Check if error message exists and display it --%>
                        <c:if test="${not empty errorMessage}">
                            <script>
                    displayErrorMessage("${errorMessage}");
                            </script>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="./components/footer.jsp" />
    </body>
</html>

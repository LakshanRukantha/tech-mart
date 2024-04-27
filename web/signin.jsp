<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
       <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="./components/headers.jsp" />
        <title>Admin Sign In</title>
    </head>
    <body>
        <jsp:include page="./components/navbar.jsp" />

        <div class="container pt-7">
            <div class="d-flex flex-column w-100 align-items-center justify-content-center px-1 py-0 mt-3 ">
            <form id=signInForm class="sign-in-form form bg-body-light rounded-2 shadow px-3 py-4 d-flex align-self-center flex-column justify-content-center w-100 mx-auto my-auto login-form" id="loginAsAdminForm" action="./admin_login_handler.jsp" method="post">
            <h2 class="text-center mb-2 h1">Sign <span>in</span></h2>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter Email...">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password...">
                <span class="mt-2 float-end  fw-light fst-italic">Don't have an account? <a class="fst-normal fw-medium" href="register.jsp">Register</a></span>
            </div>
            <div class="d-flex gap-3">
                <a class="btn btn-outline-secondary w-50" href="index.jsp">Cancel</a>
                <button class="btn btn-primary w-50" type="submit">Sign In</button>
            </div>
            <span class="text-center mx-3 my-3">- Or -</span>
            <button class="btn btn-secondary w-100 icon-button" type="button">
                <i class="fab fa-google"></i>
                <span>Sign In with Google</span>
            </button>
            <div id="signInAlertMessageArea" class="" role="alert"></div>
            </form>
        </div>
        </div>
          
            
        
        
</body>
</html>

          
            
        
        
</body>
</html>

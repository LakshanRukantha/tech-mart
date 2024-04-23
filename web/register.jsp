<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="./components/headers.jsp" />
        <title>Register | TechMart</title>
    </head>
    <body>
       <form method="POST" action="RegisterServlet">
            <label>Name</label>
            <input type="text" name="name"/>
            <label>Email</label>
            <input type="email" name="email"/>
            <label>Password</label>
            <input type="password" name="password"/>
            <input type="submit" value="Register"/>
        </form>
    </body>
</html>

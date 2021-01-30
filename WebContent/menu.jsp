<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Menu</title>
</head>
<body>
  <%@ page import="javax.servlet.*" %>
  <%
  	HttpSession s = request.getSession();
  	String uname = s.getAttribute("username").toString();
  %>
  <h1>This is user <%=uname %></h1>
</body>
</html>
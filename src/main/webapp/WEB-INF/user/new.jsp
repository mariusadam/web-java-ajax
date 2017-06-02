<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>JCG Gradle War Project</title>
</head>
<body>
<h2>Add a new user</h2>
<jsp:useBean id="user" scope="request" type="ubb.web.bean.User"/>
<h3>Hello: ${user.name}</h3>
</html>
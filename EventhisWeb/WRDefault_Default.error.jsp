<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.webratio.struts.exceptions.ErrorInterpreter" %>
<html>
<head>
<%
ErrorInterpreter interpreter = new ErrorInterpreter(request);
%>
<title>Error</title>
<style type="text/css">
body {
  font-family: sans-serif;
  color: black;
  background: white;
}
h2 {
  color: #C80028;
}
h3 {
  color: #6A2E2B
}
a img { color: white; }
</style>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
</head>
<body>
<h2>An error occurred</h2>
<h3><%=interpreter.getMessage(ErrorInterpreter.XML_FORMAT)%></h3>
<% if (interpreter.hasOccurred()) { %>
<h4>Occurred on:</h4>
<ul>
<li><%=interpreter.getOccurred()%></li>
</ul>
<% } %>
<% if (interpreter.hasDetails()) { %>
<h4>Details:</h4>
<ul>
<% for (java.util.Iterator it = interpreter.getDetails(ErrorInterpreter.XML_FORMAT).iterator(); it.hasNext(); ) { %>
<li><%=it.next()%></li>
<% } %>
</ul>
<% } %>
<% if (interpreter.hasFixes()) { %>
<h4>Suggestions:</h4>
<ul>
<% for (java.util.Iterator it = interpreter.getFixes(ErrorInterpreter.XML_FORMAT).iterator(); it.hasNext(); ) { %>
<li><%=it.next()%></li>
<% } %>
</ul>
<% } %>
<!--
<%=interpreter.getExceptionStackTrace(ErrorInterpreter.TEXT_FORMAT)%>
-->
</body>
</html>

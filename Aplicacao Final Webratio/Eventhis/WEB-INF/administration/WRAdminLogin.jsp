<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20"%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="../../WRGenericError.jsp"%>
<webratio:Page page="AdminLoginPage" />
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Web Application Administration - Login</title>
<base href="${wrAdminBaseURI}" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<style type="text/css">
  body { font-family: sans-serif; color: black; background: white }
  h2 { color: #C80028 }
  a img { color: white}
</style>
</head>
<body>
<html:form enctype="multipart/form-data">
<table>
    <tr>
	 <td><a href="http://www.webratio.com/"><img src="WRResources/WRLogo50.png" alt="WebRatio" width="50" style="border: 0px"/></a></td>
	 <td style="width:100%;vertical-align: middle;padding-left: 40px"><h2>Web Application Administration - Login</h2></td>
	</tr>
</table>
<hr/>
<table>
  <tr>
    <td>Username</td>
    <td><html:text property="userName" style="width:150px"/></td>
  </tr>
  <tr>
    <td>Password</td>
    <td><html:password property="password" style="width:150px"/></td>
  </tr>
  <tr>
    <td colspan="2" style="color: red"><html:errors property="login.failed"/></td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" value="Enter"/></td>
  </tr>
</table>
<hr/>
<address><a href="http://www.webratio.com/">WebRatio</a></address>
</html:form>
</body>
</html>
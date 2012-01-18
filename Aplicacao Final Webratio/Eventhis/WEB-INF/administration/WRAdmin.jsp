<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20"%>
<%@ page contentType="text/html; charset=UTF-8" errorPage="../../WRGenericError.jsp"%>
<webratio:Page page="AdminPage" />
<html>
<head>
<title>Web Application Administration</title>
<base href="${wrAdminBaseURI}" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style>
  body { font-family: sans-serif; color: black; background: white; }
  h2 { color: #C80028; }
  a img { color: white; }
  .text {padding-left:5px; padding-right:5px}
</style>
</head>
<body>
<html:form enctype="multipart/form-data">
	<table width="100%">
		<tr>
		  <td>
        <table>
          <tr>
		    <td><a href="http://www.webratio.com/"><img src="WRResources/WRLogo50.png" alt="WebRatio" width="50" style="border: 0px"/></a></td>
		    <td style="width:100%;vertical-align: middle;padding-left: 40px"><h2>Web Application Administration</h2></td>
		    <td valign="bottom" align="right"><address><a href="<c:out value="${adminPath}"/>">refresh</a></address></td>
		    <td valign="bottom" align="right"><input type="submit" value="Logout" name="button:logout" /></td>
		  </tr>
        </table>
      </td>
		</tr>
		<tr>
		  <td><hr/></td>
		</tr>
		<tr>
		  <td><c:import url="ApplicationSection.jsp" /></td>
		</tr>
		<tr>
		  <td><c:import url="ModulesSection.jsp" /></td>
		</tr>
		<c:if test="${enableBundleSection}">
		<tr>
		  <td><c:import url="BundleSection.jsp" /></td>
		</tr>
		</c:if>
	</table>
</html:form>
<hr/>
<address><a href="http://www.webratio.com/">WebRatio</a></address>
</body>
</html>

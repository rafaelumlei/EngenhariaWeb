<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20"%>
<%@ page import="org.apache.commons.lang.exception.ExceptionUtils" %> 
<%@ page contentType="text/html; charset=UTF-8"%>

<table cellspacing="0" cellpadding="0" width="100%"
	style="border:1px solid #cccccc; background: #f0f0e7">
	<tr>
		<td style="padding-left:16px;font-weight:bold; height: 20px"
			rowspan="1" colspan="1">Application Deployment Status</td>
	</tr>
</table>
<br />
<table>
	<tr>
	    <c:choose>
		<c:when test="${showAppSection}">
		<td>
		<table>
			<tr>
				<td class="text">IP Address: <b><c:out value="${appbean.ip}" /></b></td>
			</tr>
			<tr>
				<td class="text">Port Number: <b><c:out value="${appbean.port}" /></b></td>
			</tr>
			<tr>
				<td class="text">Application Path: <b><c:out value="${appbean.path}" /></b></td>
			</tr>
			<tr>
				<td class="text">Units: <b><c:out value="${appbean.units}" /></b></td>
			</tr>
			<tr>
				<td class="text">Pages: <b><c:out value="${appbean.pages}" /></b></td>
			</tr>
			<tr>
				<td class="text">Users: <b><c:out value="${appbean.users}" /></b></td>
			</tr>
		</table>
		</td>
		<c:if test="${showActivationLink}">
		<td valign="top" style="padding-left:100px">
		  To activate the application <a href="WRAdmin/activation-request.webratio" target="blank" class="menu">download</a> the 
		  Activation Request File&nbsp;<img src="WRResources/activation.png" border="0" />
		</td>
	    </c:if>
	    </c:when>
		<c:otherwise>
		  <td valign="top" class="text">
		    <b>Unable to compute application status</b>
		    <br>
		    <% Throwable exc = (Throwable) request.getAttribute("appException");%>
            <pre><%=ExceptionUtils.getFullStackTrace(exc)%></pre>
		  </td>
		</c:otherwise>
		</c:choose>
	</tr>
</table>
<br/>

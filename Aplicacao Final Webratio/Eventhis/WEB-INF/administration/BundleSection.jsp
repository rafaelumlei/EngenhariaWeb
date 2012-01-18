<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20"%>
<%@ page import="org.apache.commons.lang.exception.ExceptionUtils" %> 
<%@ page contentType="text/html; charset=UTF-8"%>

<table cellspacing="0" cellpadding="0" width="100%" style="border:1px solid #cccccc; background: #f0f0e7">
 <tr>
    <td style="padding-left:16px;font-weight:bold; height: 20px" rowspan="1" colspan="1">Database Bundle Data</td>
 </tr>
</table>
<br/>
<table>
    <c:if test="${not(empty(bundleException))}">
	    <tr>
	      <td valign="top" class="text">
		    <b>Unable to update database stored bundle data</b>
		    <br/>
		    <% Throwable exc = (Throwable) request.getAttribute("bundleException");%>
            <pre><%=ExceptionUtils.getFullStackTrace(exc)%></pre>
		  </td>
	    </tr>
	</c:if>
	<c:choose>
      <c:when test="${showUpdateBundleButton}">
	    <tr>
		  <td align="left" colspan="2" class="text">
		      The database bundle data is not aligned with the model:
		      <ul>
		        <c:if test="${not(empty(missingBundleKeys))}">
		          <li>${missingBundleKeys}</li>
		        </c:if>
		        <c:if test="${not(empty(invalidBundleKeys))}">
		          <li>${invalidBundleKeys}</li>
		        </c:if>
		      </ul>
		      <br/>
		      <input type="submit" value="Update Bundle Data" name="button:updateBundle"/></td>
		</tr>
	  </c:when> 
	  <c:otherwise>
	    <tr>
		  <td align="left" colspan="2" class="text">The database bundle data is aligned with the model</td>
		</tr>    
	  </c:otherwise>
	</c:choose>
</table>


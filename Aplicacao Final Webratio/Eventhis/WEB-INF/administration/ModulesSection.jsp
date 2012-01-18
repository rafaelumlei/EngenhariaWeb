<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html"%>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20"%>
<%@ page import="org.apache.commons.lang.exception.ExceptionUtils" %> 
<%@ page contentType="text/html; charset=UTF-8"%>

<table cellspacing="0" cellpadding="0" width="100%" style="border:1px solid #cccccc; background: #f0f0e7">
 <tr>
    <td style="padding-left:16px;font-weight:bold; height: 20px" rowspan="1" colspan="1">Protected Modules Configuration</td>
 </tr>
</table>
<br/>
<table>
	<tr>
		
		<c:choose>
		<c:when test="${showModulesSection}">
		<td valign="top">
		<table>
			<tr style="background: #cae2fa" title="Protected modules defined in the current application but not yet added to the database.">
				<td align="left" colspan="2" class="text">Modules to Add</td>
			</tr>
			<c:choose>
			<c:when test="${not(empty missingModules)}">
             <c:forEach var="module" varStatus="status" items="${missingModules}">
				<c:set var="index" value="${status.index}" />
				<tr>
				  <td align="center">
					<html:multibox property="addedModules">
						<c:out value="${module.id}" />
					</html:multibox></td>
					<td align="left" class="text"><c:out value="${module.name}" /> <span style="color: gray; ">[<c:out value="${module.id}" />]</span></td>
				</tr>
			 </c:forEach>
			 </c:when>
			  <c:otherwise><tr><td class="text">No protected modules to insert found</td></tr></c:otherwise>
			 </c:choose>
		</table>
		</td>
		<td valign="top" style="padding-left:20px">
		<table border="0">
			<tr style="background: #cae2fa" title="Unused modules not defined in the current application. Please note that they could belong to different applications sharing the same database.">
				<td align="left" colspan="2" class="text">Unused Modules</td>
			</tr>
			<c:choose>
			<c:when test="${not(empty wrongModules)}">
			 <c:forEach var="module" varStatus="status" items="${wrongModules}">
				<c:set var="index" value="${status.index}" />
				<tr>
				  <td align="center" style="padding-left: 1px;padding-right: 1px;">
					<html:multibox property="deletedModules">
						<c:out value="${module.id}" />
					</html:multibox></td>
					<td align="left" class="text"><c:out value="${module.name}" />  <span style="color: gray; ">[<c:out value="${module.id}" />]</span></td>
				</tr>
			 </c:forEach>
			</c:when>
			 <c:otherwise><tr><td class="text">No protected modules to delete found</td></tr></c:otherwise>
			</c:choose>
		</table>
		</td>
		</c:when>
		<c:otherwise>
		  <td valign="top" class="text">
		    <b>Unable to compute protected modules</b>
		    <br>
		    <% Throwable exc = (Throwable) request.getAttribute("modulesException");%>
            <pre><%=ExceptionUtils.getFullStackTrace(exc)%></pre>
		  </td>
		</c:otherwise>
		</c:choose>
	</tr>
	<c:if test="${showModulesSection}">
	<tr>
		<td colspan="2" align="left" style="padding-top:15px">
			<script type="text/javascript">
				function checkUpdateModules(button) {
					var added = button.form["addedModules"];
					if (added.length) {
						for (var i = 0; i < added.length; i++) {
							if (added[i].checked) { return true; }
						}
					} else {
						if (added.checked) { return true; }
					}
					var deleted = button.form["deletedModules"];
					if (deleted.length) {
						for (var i = 0; i < deleted.length; i++) {
							if (deleted[i].checked) { return true; }
						}
					} else {
						if (deleted.checked) { return true; }
					}
					alert("No modules selected.\n\nPlease select at least one new module to add or unused module to delete.");
					return false;
				}
			</script>
			<input type="submit" value="Update Modules" name="button:updateModules" onclick="return checkUpdateModules(this)" <c:if test="${not enableUpdateButton}">disabled</c:if> />
		</td>
	</tr>
	</c:if>
</table>
<br/>


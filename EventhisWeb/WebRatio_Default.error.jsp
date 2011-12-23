<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.webratio.struts.exceptions.ErrorInterpreter" %>
<html>
  <head>
<%
ErrorInterpreter interpreter = new ErrorInterpreter(request);
%>
    <title>Error</title>
	<script src="WRResources/calendar/calendar.js" type="text/javascript"></script>

	<script src="WRResources/calendar/calendar-setup.js" type="text/javascript"></script>
	<script src="WRResources/calendar/lang/calendar-en.js" type="text/javascript"></script>
	
	<link href="WRResources/calendar/skins/aqua/theme.css" type="text/css" rel="stylesheet"/>
		<link href="wr-css/global.css" type="text/css" rel="stylesheet"/>
		<link href="wr-css/menu.css" type="text/css" rel="stylesheet"/>
		<link href="wr-css/units.css" type="text/css" rel="stylesheet"/>
  </head>
  <body>
      <table width="100%"  cellspacing="0">
        <tr>
          <td valign="top" height="50" >
            <table cellspacing="0" valign="top">

              <tr>
                <td valign="middle">
                  <img src="wr-images/logo_big.png"/>
                </td>
                <td width="100%"></td>
              </tr>
              <tr>
                <td colspan="2" align="right" height="22" nowrap="nowrap" valign="bottom">
                  <table border="0" cellspacing="0" align="right">

                    <tr>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>

          </td>
        </tr>
        <tr>
          <td valign="top" width="100%" height="24" style=" background-color:#001860">
            <table valign="top" cellspacing="0" width="100%">
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>

          <td valign="top">
            <table valign="top" cellspacing="0">
              <tr>
                <td valign="top">
                  <table cellspacing="0">
                    <tr>
                      <td ></td>
                    </tr>
                  </table>

                </td>
                <td width="100%" valign="top" style="padding-left:5px">
                  <table cellspacing="0" width="100%">
                    <tr>
                      <td class="eyebrow" height="22">
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
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

            </table>
          </td>
        </tr>
      </table>
  </body>
</html>

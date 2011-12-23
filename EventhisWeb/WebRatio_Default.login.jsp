<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<html>
  <head>
    <title>Login Required</title>
	<script src="WRResources/calendar/calendar.js" type="text/javascript"></script>
	<script src="WRResources/calendar/calendar-setup.js" type="text/javascript"></script>
	<script src="WRResources/calendar/lang/calendar-en.js" type="text/javascript"></script>
	<link href="WRResources/calendar/skins/aqua/theme.css" type="text/css" rel="stylesheet"/>
		<link href="wr-css/global.css" type="text/css" rel="stylesheet"/>
		<link href="wr-css/menu.css" type="text/css" rel="stylesheet"/>
		<link href="wr-css/units.css" type="text/css" rel="stylesheet"/>
  </head>
  <body>

<html:form action="loginAction.do" enctype="multipart/form-data">
<html:hidden property="lastURL"/>
      <table width="100%" height="100%" cellspacing="0">
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

          <td valign="top" height="100%">
            <table valign="top" cellspacing="0" height="100%">
              <tr>
                <td valign="top" height="100%">
                  <table cellspacing="0" height="100%">
                    <tr>
                      <td height="100%"></td>
                    </tr>
                  </table>

                </td>
                <td width="100%" valign="top" style="padding-left:5px" height="100%">
                  <table cellspacing="0" width="100%" height="100%">
                    <tr>
                      <td class="eyebrow" height="22">
<span class="">
</span>
 &gt; <span>Please Login</span>

                      </td>
                    </tr>
                    <tr>
                      <td valign="top">
                        <table cellspacing="0" width="100%">
<tr>
<td valign="top">
	  <div class="plain EntryUnit ">
			<table cellspacing="0">

				<tr>
					<td colspan="3" class="error">
						
					</td>
				</tr>
				<tr>
					<th valign="middle" class="header">
						Username
					</th>
					<td valign="middle" nowrap="nowrap" class="value">
					  <html:text styleClass="field" property="userName"/>
					</td>
					<td class="error">

					</td>
				 </tr>
				<tr>
					<th valign="middle" class="header">
						Password
					</th>

					<td valign="middle" nowrap="nowrap" class="value">
		              <html:password styleClass="field" property="password"/>
					</td>
					<td class="error">

					</td>
				 </tr>
			<tr>
				<td colspan="3">

			<table cellspacing="0">
		      <tr>
				<td>
		          <input class="button" type="submit" value="Enter">
				</td>
			  </tr>
		    </table>
		   </td>
		</tr>

	  </table>
	</div>
</td>
</tr>
</table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>

            </table>
          </td>
        </tr>
      </table>
</html:form>
  </body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page2"/>
<html>
  <head>
    <title>P&aacute;gina de Edi&ccedil;&atilde;o Registo</title>
  <script src="WRResources/calendar/calendar.js" type="text/javascript"></script>
  <script src="WRResources/calendar/calendar-setup.js" type="text/javascript"></script>
  <script src="WRResources/calendar/lang/calendar-en.js" type="text/javascript"></script>
<% {
    javax.servlet.http.HttpSession httpSession = request.getSession(false);
	java.util.Locale locale = (httpSession != null) ? ((java.util.Locale) httpSession.getAttribute(org.apache.struts.Globals.LOCALE_KEY)) : null;
	if(locale != null && !"en".equals(locale.getLanguage())){
	  %><script src="WRResources/calendar/lang/calendar-<%=locale.getLanguage()%>.js" type="text/javascript"></script><%
	} 
} %>
  <link href="WRResources/calendar/skins/aqua/theme.css" type="text/css" rel="stylesheet">
  <script src="WRResources/CKEditor/ckeditor.js" type="text/javascript"></script>
  <script src="WRResources/ajax/prototype/prototype.js" type="text/javascript"></script>	
  <script src="WRResources/script.js" type="text/javascript"></script>
  <style type="text/css">
    #_wr_page    { display: none   }
    ._wr_wrapper { display: inline }
    ._wr_banner  {
      display: block !important; width: 100%;
      position: fixed; top: 0; left: 0; z-index: 100;
      padding: 0 10px; border: 0; border-bottom: 1px solid #A0A0A0; margin: 0;
      line-height: 26px; font-family: sans-serif; font-size: 10pt;
      background-color: #FFFFE1; cursor: pointer;
    }
  </style>
<link href="wr-css/global.css" type="text/css" rel="stylesheet"><link href="wr-css/menu.css" type="text/css" rel="stylesheet"><link href="wr-css/units.css" type="text/css" rel="stylesheet">
  </head>
  <body>
	<div id="_wr_page" title="Eventhis;sv4#page2"></div>
<html:form action="form_page2.do" styleId="page2FormBean" enctype="multipart/form-data">
  <div id="page2HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln13" value="<webratio:Link link="ln13" />">
  </div>
      <table width="100%" height="100%" cellspacing="0">
        <tr>
          <td valign="top" height="50" >
            <table cellspacing="0" valign="top">
              <tr>
                <td valign="middle">
                  <a href="page9.do" title="Home"><img src="wr-images/logo_big.png" alt="WebRatio"/></a>
                </td>
                <td width="100%"></td>
              </tr>
              <tr>
                <td colspan="2" align="right" height="22" nowrap="nowrap" valign="bottom">
                  <table border="0" cellspacing="0" align="right">
                    <tr>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln69', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln69"/>">
   Voltar
</a>
			</c:if>
                        </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td valign="top" width="100%" style=" background-color:#001860">
            <table valign="top" cellspacing="0" width="100%">
              <tr>
                <td>
                  <ul id="navmenu">
                        <li>
                           <c:if test="${webratio:isTargetAccessible('page17.link', pageContext)}">	
 <a class="" href="<webratio:Link link="page17.link"/>">
   Favoritos
</a>
			</c:if>
                           <ul>
		                   </ul>
                        </li>
                        <li>
                           <c:if test="${webratio:isTargetAccessible('page3.link', pageContext)}">	
 <a class="" href="<webratio:Link link="page3.link"/>">
   Pesquisar Eventos
</a>
			</c:if>
                           <ul>
		                   </ul>
                        </li>
                  </ul>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
		   <td class="eyebrow" height="22" align="left">
		     <span class="">
</span>
 &gt;
		     <span>P&aacute;gina de Edi&ccedil;&atilde;o Registo</span> 
		     <div style="color: rgb(102, 102, 102); font-family: Arial; font-size: 125%; text-decoration: none; float: right;">
				<span>|</span>
				<span>generated by</span>
				<a target="_blank" title="WebRatio | Business Agility and IT Standards for building your custom enterprise applications" href="http://www.webratio.com" style="color: rgb(102, 102, 102);font-family: Arial;font-size: 125%;text-decoration: none;"><span style="color: rgb(0, 24, 96); padding: 0px; margin: 0px;">Web</span><img style="width: 8px; height: 8px; border: 0px; padding: 0px; margin: 0px;" alt="Generated by WebRatio" src="WRResources/WRLogo8.png" /><span style="color: rgb(224, 30, 0); padding: 0px; margin: 0px;">Ratio</span></a><sup style="font-size: 80%;">&reg;</sup>
				<span>|</span>
			</div>                 
		   </td>		   
		</tr>
        <tr>
          <td valign="top" height="100%">
            <table valign="top" cellspacing="0" height="100%">
              <tr>
                <td width="100%" valign="top" height="100%">
                  <table cellspacing="0" width="100%" height="100%">
                    <tr>
                      <td valign="top">
<table    >
<tr>
<td  valign="top" align="left" >
<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      EditarUtilizador
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu2" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Nome
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}"  size="25" styleId="fld3" styleClass=" field" property="fld3" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld3"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Email
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}"  size="25" styleId="fld2" styleClass=" field" property="fld2" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld2"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Fotografia
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:hidden property="fld4_preload"/>
			<html:file onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}" styleId="fld4" styleClass=" field" property="fld4" disabled="false" size="25"/>
		<c:if test="${not(empty page2FormBean.map.fld4_preload)}">
		  <html:checkbox onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}" styleClass=" field" property="fld4_clear" disabled="false"/> clear <a target="blank" href="<webratio:BLOB value="${page2FormBean.map.fld4_preload}"/>">preview</a>
		</c:if>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld4"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Latitude Menor
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}"  size="25" styleId="fld5_locale" styleClass=" field" property="fld5_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld5_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude Menor
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}"  size="25" styleId="fld12_locale" styleClass=" field" property="fld12_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld12_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Latitude Maior
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}"  size="25" styleId="fld13_locale" styleClass=" field" property="fld13_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld13_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude Maior
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}"  size="25" styleId="fld14_locale" styleClass=" field" property="fld14_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld14_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Password
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:password onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}" styleId="fld1" size="25" styleClass=" field" property="fld1" readonly="false" redisplay="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld1"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Reintroduza a Password
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:password onkeypress="if(event.keyCode==13){clickButton('ln13'); return false;}" styleId="fld27" size="25" styleClass=" field" property="fld27" readonly="false" redisplay="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld27"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln13', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln13', pageContext)}">
			<input title="Guardar" onclick="$('page2FormBean').target='_self'" class=" button"  id="button:ln13" name="button:ln13" type="submit" value="Guardar">
	</c:if>
 </td>
			</c:if>
					</tr>
				    </table>
				   </td>
			   </tr>
		  </table>
		</div>
	</div>
    </td>
  </tr>
</table>
   </td>
</tr>
<tr>
<td  valign="top" align="left" >   </td>
</tr>
<tr>
<td  valign="top" align="left" >   </td>
</tr>
</table>
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="100%" valign="top" align="right" height="100%" style="padding-left:30px">
                  <table cellspacing="0" height="100%">
                    <tr>
                      <td height="22"></td>
                    </tr>
                    <tr>
                      <td valign="top" align="right" style="padding-top:3px;">
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
<script type="text/javascript">
	$("page2FormBean").observe("wr:pageFocus", function(e) {
	    var focusField = window.WREventUtils ? WREventUtils.getLastFocusedField(this) : null;
	    if (!focusField) {
		    var firstField = this.findFirstModifiableElement(this);
		    if (firstField){if(firstField.type != 'submit'){focusField = firstField;}}
        }
        if (focusField) {
            (function(){try{focusField.focus();}catch(e){}}).defer();
        }
        e.stop();
    });
</script>
  </body>
</html>

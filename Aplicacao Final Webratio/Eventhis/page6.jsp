<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page6"/>
<html>
  <head>
    <title>Enviar Newsletter</title>
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
	<div id="_wr_page" title="Eventhis;sv1#page6"></div>
<html:form action="form_page6.do" styleId="page6FormBean" enctype="multipart/form-data">
  <div id="page6HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln21" value="<webratio:Link link="ln21" />">
  </div>
      <table width="100%" height="100%" cellspacing="0">
        <tr>
          <td valign="top" height="50" >
            <table cellspacing="0" valign="top">
              <tr>
                <td valign="middle">
                  <a href="page6.do" title="Home"><img src="wr-images/logo_big.png" alt="WebRatio"/></a>
                </td>
                <td width="100%"></td>
              </tr>
              <tr>
                <td colspan="2" align="right" height="22" nowrap="nowrap" valign="bottom">
                  <table border="0" cellspacing="0" align="right">
                    <tr>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln64', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln64"/>">
   Log Out
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
		     <span>Enviar Newsletter</span> 
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
<c:if test="${not(empty mssu1) and (mssu1.dataSize gt 0)}">
	<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Mensagem
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain MultiMessageUnit">
				<table>
					<c:forEach var="current" varStatus="status" items="${mssu1.data}">
						<c:set var="index" value="${status.index}"/>
						<tr>
							<td class="value">
								<c:out value="${current}"/>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
    </td>
  </tr>
</table>
</c:if>
   </td>
</tr>
<tr>
<td  valign="top" align="left" >
<c:if test="${not(empty inu1) and (inu1.dataSize gt 0)}">
	<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Eventos da Newsletter
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain IndexUnit">
				<table border="0" cellspacing="1" cellpadding="2" id="inu1_1_sortable">
					<tr>
						<th class=" header"></th>
						<th nowrap="nowrap" class=" header">descricao</th>
						<th nowrap="nowrap" class=" header">dtfim</th>
						<th nowrap="nowrap" class=" header">dtinicio</th>
						<th nowrap="nowrap" class=" header">lat</th>
						<th nowrap="nowrap" class=" header">lon</th>
						<th nowrap="nowrap" class=" header">titulo</th>
					</tr>
				<c:forEach var="current" varStatus="status" items="${inu1.data}">
					<c:set var="index" value="${status.index}"/>	
						<tr class="row<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>">	
								<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>">
									<img src="WRResources/spacer.gif" class="bullet<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>" border="0" alt=""/>
								</td>
									<!-- not linked attribute -->
									<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> string">				
										<c:out value="${current.descricao}"/>
									</td>
									<!-- not linked attribute -->
									<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> timestamp">				
										<fmt:formatDate value="${current.dtfim}" pattern="${timestampPattern}"/>
									</td>
									<!-- not linked attribute -->
									<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> timestamp">				
										<fmt:formatDate value="${current.dtinicio}" pattern="${timestampPattern}"/>
									</td>
									<!-- not linked attribute -->
									<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> float">				
										<fmt:formatNumber value="${current.lat}" pattern="${floatPattern}"/>
									</td>
									<!-- not linked attribute -->
									<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> float">				
										<fmt:formatNumber value="${current.lon}" pattern="${floatPattern}"/>
									</td>
									<!-- not linked attribute -->
									<td class=" value<c:if test="${inu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> string">				
										<c:out value="${current.titulo}"/>
									</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
    </td>
  </tr>
</table>
</c:if>
   </td>
</tr>
<tr>
<td  valign="top" align="left" >
<c:if test="${webratio:evaluateCondition('cexpr5', null, pageContext)}">
<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Enviar Newsletter
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu7" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								T&iacute;tulo
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln21'); return false;}"  size="25" styleId="fld37" styleClass=" field" property="fld37" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld37"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln21', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln21', pageContext)}">
			<input title="Enviar Email" onclick="$('page6FormBean').target='_self'" class=" button"  id="button:ln21" name="button:ln21" type="submit" value="Enviar Email">
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
</c:if>
   </td>
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
	$("page6FormBean").observe("wr:pageFocus", function(e) {
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

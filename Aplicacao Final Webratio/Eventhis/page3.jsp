<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page3"/>
<html>
  <head>
    <title>Pesquisar Eventos</title>
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
	<div id="_wr_page" title="Eventhis;sv4#page3"></div>
<html:form action="form_page3.do" styleId="page3FormBean" enctype="multipart/form-data">
  <div id="page3HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln1" value="<webratio:Link link="ln1" />">
  </div>
      <table width="100%" height="100%" cellspacing="0">
        <tr>
          <td valign="top" height="50" >
            <table cellspacing="0" valign="top">
              <tr>
                <td valign="middle">
                  <a href="page16.do" title="Home"><img src="wr-images/logo_big.png" alt="WebRatio"/></a>
                </td>
                <td width="100%"></td>
              </tr>
              <tr>
                <td colspan="2" align="right" height="22" nowrap="nowrap" valign="bottom">
                  <table border="0" cellspacing="0" align="right">
                    <tr>
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
                      	<li class="current">
                  		   <c:if test="${webratio:isTargetAccessible('page3.link', pageContext)}">	
 <a class="" href="<webratio:Link link="page3.link"/>">
   Pesquisar Eventos
</a>
			</c:if>
                  		   <ul>
		                   </ul>
			             </li>
                        <li>
                           <c:if test="${webratio:isTargetAccessible('', pageContext)}">	
 <a class="" href="<webratio:Link link=""/>">
   Edi&ccedil;&atilde;o de Registo
</a>
			</c:if>
                           <ul>
		                   </ul>
                        </li>
                        <li>
                           <c:if test="${webratio:isTargetAccessible('', pageContext)}">	
 <a class="" href="<webratio:Link link=""/>">
   Visualiza&ccedil;&atilde;o de Eventos
</a>
			</c:if>
                           <ul>
		                   </ul>
                        </li>
                        <li>
                           <c:if test="${webratio:isTargetAccessible('', pageContext)}">	
 <a class="" href="<webratio:Link link=""/>">
   Gest&atilde;o de Eventos
</a>
			</c:if>
                           <ul>
		                   </ul>
                        </li>
                        <li>
                           <c:if test="${webratio:isTargetAccessible('page1.link', pageContext)}">	
 <a class="" href="<webratio:Link link="page1.link"/>">
   Favoritos
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
		     <span>Pesquisar Eventos</span> 
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
      Pesquisar Eventos
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu3" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Evento
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln1'); return false;}"  size="25" styleId="fld26" styleClass=" field" property="fld26" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld26"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								TipoEvento
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:select onkeypress="if(event.keyCode==13){clickButton('ln1'); return false;}" styleId="sfld2" styleClass=" selectionfield" property="sfld2" disabled="false">
			  		<html:option value=""><bean:message key="selectionfield.noselection"/></html:option>
			  <html:options property="sfld2List" labelProperty="sfld2LabelList"/>
			</html:select>
						</td>
								<td class="error">
<span class=" error"><html:errors property="sfld2"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln1', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln1', pageContext)}">
			<input title="Pesquisar" onclick="$('page3FormBean').target='_self'" class=" button"  id="button:ln1" name="button:ln1" type="submit" value="Pesquisar">
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
<td  valign="top" align="left" >
<c:if test="${not(empty pwu1) and (pwu1.dataSize gt 0)}">
	<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Resultados
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain PowerIndexUnit">
				<table border="0" cellspacing="1" cellpadding="2">
						<!-- begin header -->
						<tr>
							<th class=" header"></th>
					        <th nowrap="nowrap" class=" header">
						            T&iacute;tulo
					        </th>
					        <th nowrap="nowrap" class=" header">
						            Descri&ccedil;&atilde;o
					        </th>
					        <th nowrap="nowrap" class=" header">
		<c:if test="${webratio:isTargetAccessible('pwu1att21', pageContext)}">
		 			<a title="Ínicio" id="pwu1att21" class=" sort" href="<webratio:Link link="pwu1att21" position="index"/>">
					Ínicio</a>
	</c:if>
					        </th>
					        <th nowrap="nowrap" class=" header">
						            Fim
					        </th>
					        <th nowrap="nowrap" class=" header">
						            Latitude
					        </th>
					        <th nowrap="nowrap" class=" header">
						            Longitude
					        </th>
			<c:if test="${webratio:isTargetAccessible('ln97', pageContext)}">
<th class=" header"></th> 
			</c:if>
						</tr>
						<!-- end header -->
				<!-- instances -->
				<c:forEach var="current" varStatus="status" items="${pwu1.data}">
					<c:set var="index" value="${status.index}"/>	
						<tr class="row<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>">	
								<td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>">
									<img src="WRResources/spacer.gif" class="bullet<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>" border="0" alt="Ver Evento Detalhado"/>
								</td>
								   <td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> string">				
										<c:out value="${current.titulo}"/>
								   </td>
								   <td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> string">				
										<c:out value="${current.descricao}"/>
								   </td>
								   <td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> timestamp">				
										<fmt:formatDate value="${current.dtinicio}" pattern="${timestampPattern}"/>
								   </td>
								   <td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> timestamp">				
										<fmt:formatDate value="${current.dtfim}" pattern="${timestampPattern}"/>
								   </td>
								   <td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> float">				
										<fmt:formatNumber value="${current.lat}" pattern="${floatPattern}"/>
								   </td>
								   <td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if> float">				
										<fmt:formatNumber value="${current.lon}" pattern="${floatPattern}"/>
								   </td>
			<c:if test="${webratio:isTargetAccessible('ln97', pageContext)}">
									<td class=" value<c:if test="${pwu1.currentIndex eq index}">Current</c:if><c:if test="${index mod 2 eq 0}">Alternate</c:if>">
										<c:choose>
							   				<c:when test="${pwu1.currentIndex eq index}">
							   						<c:choose>
							   							<c:when test="${index mod 2 eq 0}">
		<c:if test="${webratio:isTargetAccessible('ln97', pageContext)}">
		 			<a title="Ver Evento Detalhado" id="ln97" class=" linkCurrentAlternate" href="<webratio:Link link="ln97" position="index"/>">
					Ver Evento Detalhado</a>
	</c:if>
														</c:when>
														<c:otherwise>
		<c:if test="${webratio:isTargetAccessible('ln97', pageContext)}">
		 			<a title="Ver Evento Detalhado" id="ln97" class=" linkCurrent" href="<webratio:Link link="ln97" position="index"/>">
					Ver Evento Detalhado</a>
	</c:if>
														</c:otherwise>
							   						</c:choose>
							   				</c:when>
							   				<c:otherwise>
							   						<c:choose>
							   							<c:when test="${index mod 2 eq 0}">
		<c:if test="${webratio:isTargetAccessible('ln97', pageContext)}">
		 			<a title="Ver Evento Detalhado" id="ln97" class=" linkAlternate" href="<webratio:Link link="ln97" position="index"/>">
					Ver Evento Detalhado</a>
	</c:if>
														</c:when>
														<c:otherwise>
		<c:if test="${webratio:isTargetAccessible('ln97', pageContext)}">
		 			<a title="Ver Evento Detalhado" id="ln97" class=" link" href="<webratio:Link link="ln97" position="index"/>">
					Ver Evento Detalhado</a>
	</c:if>
														</c:otherwise>
							   						</c:choose>
							   				</c:otherwise>
							   			</c:choose>
						   			</td>
			</c:if>
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
	$("page3FormBean").observe("wr:pageFocus", function(e) {
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

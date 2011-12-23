<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page1"/>
<html>
  <head>
    <title>P&aacute;gina Edi&ccedil;&atilde;o de Evento</title>
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
  <script type="text/javascript"
    src="http://maps.googleapis.com/maps/api/js?sensor=true">
    // sensor é para dizer se o aparelho que está a usar esta aplicação tem GPS ou não
  </script>  
  <script type="text/javascript">
  // para brincar pela consola com o mapa
  var map; 
  var marker;
  
  function posicaoMarcaAlterada()
  {
	var centro = marker.getPosition();
	document.getElementById("fld24_locale").value = centro.lat();
    document.getElementById("fld25_locale").value = centro.lng();
  }

  function initialize() {
  	// cria uma posição (Latitude,longitude)
	// tem que se pôr aqui a receber  os valores que estão no formulário
    var latlng = new google.maps.LatLng(document.getElementById("fld24_locale").value,
										document.getElementById("fld25_locale").value);
    // informação incial
    //document.getElementById("posicao").innerHTML = latlng.toString();
    // estipula as opções do Mapa
    var myOptions = {
      // zoom
      zoom: 8,
      // centro
      center: latlng,
      // tipo de mapa
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    // cria e iniciapliza o mapa, passando a div onde o mesmo vai 
    // estar e as opções imediatamente acima inicializadas
    map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);
		
	var myLatlng = map.getCenter();
	marker = new google.maps.Marker({
		position: myLatlng, 
      	map: map,
      	title: "Local",
      	icon: "./imagens/mappin.png" 
  	});
  	marker.setDraggable(true);	
    // set events listeners MVC    
	google.maps.event.addListener(marker,'dragend',posicaoMarcaAlterada);
  }

</script>  
<link href="wr-css/global.css" type="text/css" rel="stylesheet"><link href="wr-css/menu.css" type="text/css" rel="stylesheet"><link href="wr-css/units.css" type="text/css" rel="stylesheet">
  </head>
  <body onload="initialize()">
	<div id="_wr_page" title="Eventhis;sv4#page1"></div>
<html:form action="form_page1.do" styleId="page1FormBean" enctype="multipart/form-data">
  <div id="page1HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln18" value="<webratio:Link link="ln18" />">
    <input type="hidden" name="ln24" value="<webratio:Link link="ln24" />">
    <input type="hidden" name="ln39" value="<webratio:Link link="ln39" />">
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
		     <span>P&aacute;gina Edi&ccedil;&atilde;o de Evento</span> 
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
      EditarEvento
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu1" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								T&iacute;tulo
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln18|ln24|ln39'); return false;}"  size="25" styleId="fld15" styleClass=" field" property="fld15" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld15"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Descri&ccedil;&atilde;o
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:textarea styleId="fld16" styleClass=" field" cols="35" rows="8" property="fld16" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld16"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Tipo do Evento
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:select onkeypress="if(event.keyCode==13){clickButton('ln18|ln24|ln39'); return false;}" styleId="sfld1" styleClass=" selectionfield" property="sfld1" disabled="false">
			  		<html:option value=""><bean:message key="selectionfield.noselection"/></html:option>
			  <html:options property="sfld1List" labelProperty="sfld1LabelList"/>
			</html:select>
						</td>
								<td class="error">
<span class=" error"><html:errors property="sfld1"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								&Iacute;nicio
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln18|ln24|ln39'); return false;}"  size="25" styleId="fld18_locale" styleClass=" field" property="fld18_locale" readonly="false"/>
			<c:choose><c:when test="false">
				<img src="WRResources/calendar/calendar_disabled.gif" />
			</c:when><c:otherwise>
				<img src="WRResources/calendar/calendar.gif" id="fld18_locale_calendar" style="cursor: pointer"/>
				<script type="text/javascript">				
				  Calendar.setup(
				    {
				      inputField  : "fld18_locale",
				      ifFormat    : "<bean:message key="timestampCalendarPattern"/>",
				      firstDay    : <%= java.util.Calendar.getInstance((java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY)).getFirstDayOfWeek() - 1 %>,
				      button      : "fld18_locale_calendar",
				      onClose     : forceFieldBlur,
				      showsTime : "true"
				    }
				  );
				</script>
			</c:otherwise></c:choose>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld18_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Fim
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln18|ln24|ln39'); return false;}"  size="25" styleId="fld17_locale" styleClass=" field" property="fld17_locale" readonly="false"/>
			<c:choose><c:when test="false">
				<img src="WRResources/calendar/calendar_disabled.gif" />
			</c:when><c:otherwise>
				<img src="WRResources/calendar/calendar.gif" id="fld17_locale_calendar" style="cursor: pointer"/>
				<script type="text/javascript">				
				  Calendar.setup(
				    {
				      inputField  : "fld17_locale",
				      ifFormat    : "<bean:message key="timestampCalendarPattern"/>",
				      firstDay    : <%= java.util.Calendar.getInstance((java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY)).getFirstDayOfWeek() - 1 %>,
				      button      : "fld17_locale_calendar",
				      onClose     : forceFieldBlur,
				      showsTime : "true"
				    }
				  );
				</script>
			</c:otherwise></c:choose>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld17_locale"/></span>
</td>
					 	</tr>
						
					<!---- Inicio ---> 
					<tr class="row">
							<th valign="middle" class=" header">
								Insira as coordenadas gps ou seleccione um ponto no mapa.
							</th>
							<tr>
							<div id="map_canvas" style="width:300px; height:420px; text-align: center; float: left;"></div>
							<tr>
					 	</tr>						
						<!---- Fim ---> 
						
					<tr class="row">
							<th valign="middle" class=" header">
								Latitude
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln18|ln24|ln39'); return false;}"  size="25" styleId="fld24_locale" styleClass=" field" property="fld24_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld24_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln18|ln24|ln39'); return false;}"  size="25" styleId="fld25_locale" styleClass=" field" property="fld25_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld25_locale"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln18', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln18', pageContext)}">
			<input title="Remover Evento" onclick="$('page1FormBean').target='_self'" class=" button"  id="button:ln18" name="button:ln18" type="submit" value="Remover Evento">
	</c:if>
 </td>
			</c:if>
			<c:if test="${webratio:isTargetAccessible('ln24', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln24', pageContext)}">
			<input title="Guardar" onclick="$('page1FormBean').target='_self'" class=" button"  id="button:ln24" name="button:ln24" type="submit" value="Guardar">
	</c:if>
 </td>
			</c:if>
			<c:if test="${webratio:isTargetAccessible('ln39', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln39', pageContext)}">
			<input title="Página do Evento" onclick="$('page1FormBean').target='_self'" class=" button"  id="button:ln39" name="button:ln39" type="submit" value="Página do Evento">
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
<td  valign="top" align="left" >   </td>
<td  valign="top" align="left" >   </td>
</tr>
<tr>
<td  valign="top" align="left" >   </td>
<td  valign="top" align="left" >   </td>
<td  valign="top" align="left" >   </td>
</tr>
<tr>
<td  valign="top" align="left" >   </td>
<td  valign="top" align="left" >   </td>
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
	$("page1FormBean").observe("wr:pageFocus", function(e) {
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

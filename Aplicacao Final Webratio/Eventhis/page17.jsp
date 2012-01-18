<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page17"/>
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
<link href="wr-css/global.css" type="text/css" rel="stylesheet"><link href="wr-css/menu.css" type="text/css" rel="stylesheet"><link href="wr-css/units.css" type="text/css" rel="stylesheet">
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
	document.getElementById("fld58_locale").value = centro.lat();
    document.getElementById("fld59_locale").value = centro.lng();
  }

  function initialize() {
  	// cria uma posição (Latitude,longitude)
	// tem que se pôr aqui a receber  os valores que estão no formulário
    var latlng = new google.maps.LatLng(document.getElementById("fld58_locale").value,
										document.getElementById("fld59_locale").value);
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
  </head>
  <body onload="initialize()">
	<div id="_wr_page" title="Eventhis;sv4#area3#page17"></div>
<html:form action="form_page17.do" styleId="page17FormBean" enctype="multipart/form-data">
  <div id="page17HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln98" value="<webratio:Link link="ln98" />">
    <input type="hidden" name="ln99" value="<webratio:Link link="ln99" />">
    <input type="hidden" name="ln100" value="<webratio:Link link="ln100" />">
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
                        <li>
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
                      	<li class="current">
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
 &gt; </span><a class="small" href="<webratio:Link link=""/>">Gest&atilde;o de Eventos
</a><span class="">
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
							<html:errors property="enu10" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								T&iacute;tulo
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln98|ln99|ln100'); return false;}"  size="25" styleId="fld54" styleClass=" field" property="fld54" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld54"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Descri&ccedil;&atilde;o
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:textarea styleId="fld55" styleClass=" field" cols="35" rows="8" property="fld55" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld55"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Tipo do Evento
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:select onkeypress="if(event.keyCode==13){clickButton('ln98|ln99|ln100'); return false;}" styleId="sfld5" styleClass=" selectionfield" property="sfld5" disabled="false">
			  		<html:option value=""><bean:message key="selectionfield.noselection"/></html:option>
			  <html:options property="sfld5List" labelProperty="sfld5LabelList"/>
			</html:select>
						</td>
								<td class="error">
<span class=" error"><html:errors property="sfld5"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								&Iacute;nicio
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln98|ln99|ln100'); return false;}"  size="25" styleId="fld57_locale" styleClass=" field" property="fld57_locale" readonly="false"/>
			<c:choose><c:when test="false">
				<img src="WRResources/calendar/calendar_disabled.gif" />
			</c:when><c:otherwise>
				<img src="WRResources/calendar/calendar.gif" id="fld57_locale_calendar" style="cursor: pointer"/>
				<script type="text/javascript">				
				  Calendar.setup(
				    {
				      inputField  : "fld57_locale",
				      ifFormat    : "<bean:message key="timestampCalendarPattern"/>",
				      firstDay    : <%= java.util.Calendar.getInstance((java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY)).getFirstDayOfWeek() - 1 %>,
				      button      : "fld57_locale_calendar",
				      onClose     : forceFieldBlur,
				      showsTime : "true"
				    }
				  );
				</script>
			</c:otherwise></c:choose>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld57_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Fim
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln98|ln99|ln100'); return false;}"  size="25" styleId="fld56_locale" styleClass=" field" property="fld56_locale" readonly="false"/>
			<c:choose><c:when test="false">
				<img src="WRResources/calendar/calendar_disabled.gif" />
			</c:when><c:otherwise>
				<img src="WRResources/calendar/calendar.gif" id="fld56_locale_calendar" style="cursor: pointer"/>
				<script type="text/javascript">				
				  Calendar.setup(
				    {
				      inputField  : "fld56_locale",
				      ifFormat    : "<bean:message key="timestampCalendarPattern"/>",
				      firstDay    : <%= java.util.Calendar.getInstance((java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY)).getFirstDayOfWeek() - 1 %>,
				      button      : "fld56_locale_calendar",
				      onClose     : forceFieldBlur,
				      showsTime : "true"
				    }
				  );
				</script>
			</c:otherwise></c:choose>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld56_locale"/></span>
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
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln98|ln99|ln100'); return false;}"  size="25" styleId="fld58_locale" styleClass=" field" property="fld58_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld58_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln98|ln99|ln100'); return false;}"  size="25" styleId="fld59_locale" styleClass=" field" property="fld59_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld59_locale"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln98', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln98', pageContext)}">
			<input title="Remover Evento" onclick="$('page17FormBean').target='_self'" class=" button"  id="button:ln98" name="button:ln98" type="submit" value="Remover Evento">
	</c:if>
 </td>
			</c:if>
			<c:if test="${webratio:isTargetAccessible('ln99', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln99', pageContext)}">
			<input title="Guardar" onclick="$('page17FormBean').target='_self'" class=" button"  id="button:ln99" name="button:ln99" type="submit" value="Guardar">
	</c:if>
 </td>
			</c:if>
			<c:if test="${webratio:isTargetAccessible('ln100', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln100', pageContext)}">
			<input title="Página do Evento" onclick="$('page17FormBean').target='_self'" class=" button"  id="button:ln100" name="button:ln100" type="submit" value="Página do Evento">
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
	$("page17FormBean").observe("wr:pageFocus", function(e) {
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

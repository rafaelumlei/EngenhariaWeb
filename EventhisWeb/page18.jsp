<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page18"/>
<html>
  <head>
    <title>Criar Evento</title>
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
	document.getElementById("fld45_locale").value = centro.lat();
    document.getElementById("fld46_locale").value = centro.lng();
  }

  function initialize() {
  	// cria uma posição (Latitude,longitude)
	// tem que se pôr aqui a receber  os valores que estão no formulário
    var latlng = new google.maps.LatLng( 
										  41.0055195721879,
										 -7.980285644531229
									   );
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
	<div id="_wr_page" title="Eventhis;sv4#page18"></div>
<html:form action="form_page18.do" styleId="page18FormBean" enctype="multipart/form-data">
  <div id="page18HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln50" value="<webratio:Link link="ln50" />">
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
                          <c:if test="${webratio:isTargetAccessible('ln52', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln52"/>">
   Voltar
</a>
			</c:if>
                        </td>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln54', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln54"/>">
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
		     <span>Criar Evento</span> 
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
      Novo Evento
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu16" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								T&iacute;tulo
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}"  size="25" styleId="fld41" styleClass=" field" property="fld41" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld41"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Descri&ccedil;&atilde;o
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:textarea styleId="fld42" styleClass=" field" cols="35" rows="8" property="fld42" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld42"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Tipo do Evento
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:select onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}" styleId="sfld4" styleClass=" selectionfield" property="sfld4" disabled="false">
			  		<html:option value=""><bean:message key="selectionfield.noselection"/></html:option>
			  <html:options property="sfld4List" labelProperty="sfld4LabelList"/>
			</html:select>
						</td>
								<td class="error">
<span class=" error"><html:errors property="sfld4"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								&Iacute;nicio
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}"  size="25" styleId="fld44_locale" styleClass=" field" property="fld44_locale" readonly="false"/>
			<c:choose><c:when test="false">
				<img src="WRResources/calendar/calendar_disabled.gif" />
			</c:when><c:otherwise>
				<img src="WRResources/calendar/calendar.gif" id="fld44_locale_calendar" style="cursor: pointer"/>
				<script type="text/javascript">				
				  Calendar.setup(
				    {
				      inputField  : "fld44_locale",
				      ifFormat    : "<bean:message key="timestampCalendarPattern"/>",
				      firstDay    : <%= java.util.Calendar.getInstance((java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY)).getFirstDayOfWeek() - 1 %>,
				      button      : "fld44_locale_calendar",
				      onClose     : forceFieldBlur,
				      showsTime : "true"
				    }
				  );
				</script>
			</c:otherwise></c:choose>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld44_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Fim
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}"  size="25" styleId="fld43_locale" styleClass=" field" property="fld43_locale" readonly="false"/>
			<c:choose><c:when test="false">
				<img src="WRResources/calendar/calendar_disabled.gif" />
			</c:when><c:otherwise>
				<img src="WRResources/calendar/calendar.gif" id="fld43_locale_calendar" style="cursor: pointer"/>
				<script type="text/javascript">				
				  Calendar.setup(
				    {
				      inputField  : "fld43_locale",
				      ifFormat    : "<bean:message key="timestampCalendarPattern"/>",
				      firstDay    : <%= java.util.Calendar.getInstance((java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY)).getFirstDayOfWeek() - 1 %>,
				      button      : "fld43_locale_calendar",
				      onClose     : forceFieldBlur,
				      showsTime : "true"
				    }
				  );
				</script>
			</c:otherwise></c:choose>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld43_locale"/></span>
</td>
					 	</tr>
						
																		<!---- Inicio ---> 
					<tr class="row">
							<th valign="middle" class=" header">
								Insira as coordenadas gps ou seleccione um ponto no mapa.
							</th>
							<tr>
							<div id="map_canvas" style="width:300px; height:450px; text-align: center; float: left;"></div>
							<tr>
					 	</tr>						
						<!---- Fim ---> 
						
					<tr class="row">
							<th valign="middle" class=" header">
								Latitude
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}"  size="25" styleId="fld45_locale" styleClass=" field" property="fld45_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld45_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}"  size="25" styleId="fld46_locale" styleClass=" field" property="fld46_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld46_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								ProximaNewsltter
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:radio onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}" styleClass=" field" property="fld36_locale" value="true" disabled="false"/>
				<bean:message key="boolean.yes"/>
				<html:radio onkeypress="if(event.keyCode==13){clickButton('ln50'); return false;}" styleClass=" field" property="fld36_locale" value="false" disabled="false"/>
				<bean:message key="boolean.no"/>
		<c:if test="false">
			<html:hidden property="fld36_locale"/>
		</c:if>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld36_locale"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln50', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln50', pageContext)}">
			<input title="Criar" onclick="$('page18FormBean').target='_self'" class=" button"  id="button:ln50" name="button:ln50" type="submit" value="Criar">
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
	$("page18FormBean").observe("wr:pageFocus", function(e) {
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

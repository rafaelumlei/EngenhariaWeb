<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page21"/>
<html>
  <head>
    <title>P&aacute;gina de Registo</title>
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
    // sensor � para dizer se o aparelho que est� a usar esta aplica��o tem GPS ou n�o
  </script>    
  
  <script type="text/javascript">
  // para brincar pela consola com o mapa
  var map; 
  
  function areaAlterada()
  {
 
	var ne = map.getBounds().getNorthEast();
	var sw = map.getBounds().getSouthWest()
	document.getElementById("fld75_locale").value = sw.lat();
    document.getElementById("fld76_locale").value = sw.lng();
	document.getElementById("fld77_locale").value = ne.lat();
    document.getElementById("fld78_locale").value = ne.lng();	
  }

  function initialize() {
  	// cria uma posi��o (Latitude,longitude)
	// tem que se p�r aqui a receber  os valores que est�o no formul�rio
    var latlng = new google.maps.LatLng(41.0055195721879,
										-7.980285644531229);
    // informa��o incial
    //document.getElementById("posicao").innerHTML = latlng.toString();
    // estipula as op��es do Mapa
    var myOptions = {
      // zoom
      zoom: 5,
      // centro
      center: latlng,
      // tipo de mapa
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    // cria e iniciapliza o mapa, passando a div onde o mesmo vai 
    // estar e as op��es imediatamente acima inicializadas
    map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);
		
    // set events listeners MVC    
	google.maps.event.addListener(map,'bounds_changed',areaAlterada);
  }
</script>  

  </head>
  <body onload="initialize()">
	<div id="_wr_page" title="Eventhis;sv2#area5#page21"></div>
<html:form action="form_page21.do" styleId="page21FormBean" enctype="multipart/form-data">
  <div id="page21HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln117" value="<webratio:Link link="ln117" />">
  </div>
      <table width="100%" height="100%" cellspacing="0">
        <tr>
          <td valign="top" height="50" >
            <table cellspacing="0" valign="top">
              <tr>
                <td valign="middle">
                  <a href="page20.do" title="Home"><img src="wr-images/logo_big.png" alt="WebRatio"/></a>
                </td>
                <td width="100%"></td>
              </tr>
              <tr>
                <td colspan="2" align="right" height="22" nowrap="nowrap" valign="bottom">
                  <table border="0" cellspacing="0" align="right">
                    <tr>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
 <a class="shortcuts" href="<webratio:Link link="ln118"/>">
   Voltar
</a>
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
 <a class="" href="<webratio:Link link="page4.link"/>">
   Pesquisar Eventos
</a>
                           <ul>
		                   </ul>
                        </li>
                        <li>
 <a class="" href="<webratio:Link link="page5.link"/>">
   Autentica&ccedil;&atilde;o
</a>
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
		     <span>P&aacute;gina de Registo</span> 
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
      Novo Utilizador
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu14" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Nome
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld74" styleClass=" field" property="fld74" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld74"/></span>
</td>
<tr>
						<div id="map_canvas" style="width:350px; height:400px; text-align: center; float: right;"></div>
						</tr>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Username 
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld71" styleClass=" field" property="fld71" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld71"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Email
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld73" styleClass=" field" property="fld73" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld73"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Password
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:password onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}" styleId="fld72" size="25" styleClass=" field" property="fld72" readonly="false" redisplay="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld72"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Reintroduza a Password
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:password onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}" styleId="fld79" size="25" styleClass=" field" property="fld79" readonly="false" redisplay="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld79"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
							Localize zona de interesse no Mapa <br /><br /><br />
								Latitude Menor
							</th>
						<td valign="middle" nowrap="nowrap" class=" value"> <br /><br /><br /><br />
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld75_locale" styleClass=" field" property="fld75_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld75_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude Menor
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld76_locale" styleClass=" field" property="fld76_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld76_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Latitude Maior
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld77_locale" styleClass=" field" property="fld77_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld77_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Longitude Maior
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}"  size="25" styleId="fld78_locale" styleClass=" field" property="fld78_locale" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld78_locale"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Fotografia
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:hidden property="fld80_preload"/>
			<html:file onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}" styleId="fld80" styleClass=" field" property="fld80" disabled="false" size="25"/>
		<c:if test="${not(empty page21FormBean.map.fld80_preload)}">
		  <html:checkbox onkeypress="if(event.keyCode==13){clickButton('ln117'); return false;}" styleClass=" field" property="fld80_clear" disabled="false"/> clear <a target="blank" href="<webratio:BLOB value="${page21FormBean.map.fld80_preload}"/>">preview</a>
		</c:if>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld80"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
					  <td> 
			<input title="Sign Up" onclick="$('page21FormBean').target='_self'" class=" button"  id="button:ln117" name="button:ln117" type="submit" value="Sign Up">
 </td>
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
	$("page21FormBean").observe("wr:pageFocus", function(e) {
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

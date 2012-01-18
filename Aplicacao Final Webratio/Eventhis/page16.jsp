<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page16"/>
<html>
  <head>
    <title>P&aacute;gina Principal Registados</title>
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
<script type="text/javascript" src="http://www.terracoder.com/scripts/saXMLUtils.js"></script>
<script type="text/javascript">
  // para brincar pela consola com o mapa
	var map; 
	var marker;
	var marcas = {};
  
	function getCenter()
	{
		var la1 = document.getElementsByTagName("td")[18].innerHTML;
		var lo1 = document.getElementsByTagName("td")[20].innerHTML;
		var la2 = document.getElementsByTagName("td")[19].innerHTML;
		var lo2 = document.getElementsByTagName("td")[21].innerHTML;
		return new google.maps.LatLng(((la1*1.0)+(la2*1.0))/2.0,((lo1*1.0)+(lo2*1.0))/2.0);
	}    
  
    function getImagemTipo(tipo)
		{
		switch(tipo)
		{
			case "1": return "./imagens/mappin.png"; break;
			case "2": return "./imagens/ball.gif"; break;
			case "3": return "./imagens/igreja.gif"; break;
			case "4": return "./imagens/festas.png"; break;
			case "5": return "./imagens/sol.gif"; break;
			case "6": return "./imagens/politics.gif"; break;
			case "7": return "./imagens/arte.jpg"; break;
			case "8": return "./imagens/comercio.gif"; break;
		}  	
	}

    function initialize() {
		document.getElementById("dadosinit").style.visibility='hidden'
		// cria uma posição (Latitude,longitude)
		//var latlng = new google.maps.LatLng(-34.397, 150.644);
		// informação incial
		// document.getElementById("posicao").innerHTML = latlng.toString();
		// estipula as opções do Mapa
		var myOptions = {
			// zoom
			zoom: 4,
			// centro
			center: getCenter(),
			// tipo de mapa
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		// cria e iniciapliza o mapa, passando a div onde o mesmo vai 
		// estar e as opções imediatamente acima inicializadas
		map = new google.maps.Map(document.getElementById("map_canvas"),
								  myOptions);
		// set events listeners MVC    
		google.maps.event.addListener(map,'bounds_changed',novosEventos);
    }
  
	function inserirNoMapa(json)
	{
		
		for(var i = 0 ; i < json.Entity[0].Instance.length ; i++ ){ 
			var idEvento = json.Entity[0].Instance[i].Attribute[0].Text;
			if(!marcas[idEvento]){
				var id = "i"+idEvento;
				var pos = new google.maps.LatLng(json.Entity[0].Instance[i].Attribute[2].Text,
												 json.Entity[0].Instance[i].Attribute[1].Text);
				var titulo = json.Entity[0].Instance[i].Attribute[3].Text;
				var tipo = json.Entity[0].Instance[i].Attribute[4].Text;
				var foto = getImagemTipo(tipo);
				marcas[id] = new google.maps.Marker({
					position: pos, 
					map: map,
					title: titulo,
					icon: foto,
					conteudo:titulo+'<br /><a href="page14.do?kcond24.att19='
								+idEvento+'">aqui</a>'
				});
				marcas[id].setDraggable(false);
				marcas[id].setClickable(true);
				marcas[id].info = new google.maps.InfoWindow();
				marcas[id].idev = id;
				google.maps.event.addListener(marcas[id],"click",function(mouse){
					marcas[id].info.setContent(this.conteudo);
					marcas[id].info.open(map,this);
				}); 
			}
		} 
	}
	
	function novosEventos()
	{
		var xmlhttp;
		var ne = map.getBounds().getNorthEast();
		var sw = map.getBounds().getSouthWest()
		var pedido = "EventosService/mostraeventos/Area.do?LatMenor="
					 + sw.lat() + "&LatMaior=" + ne.lat() + "&LonMenor=" + sw.lng() + "&LonMaior=" + 
					 ne.lng();
		console.log(pedido);
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4  && xmlhttp.status==200)
			{
				var resp = xmlhttp.responseText;
				var json = XMLObjectifier.xmlToJSON(XMLObjectifier.textToXML(resp));
				inserirNoMapa(json);
			}
		}
		xmlhttp.open("GET",pedido,true);
		xmlhttp.send();
	}
</script>    

  </head>
  <body onload="initialize()">
	<div id="_wr_page" title="Eventhis;sv4#area2#page16"></div>
<html:form action="form_page16.do" styleId="page16FormBean" enctype="multipart/form-data">
  <div id="page16HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
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
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln89', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln89"/>">
   Log Out
</a>
			</c:if>
                        </td>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln92', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln92"/>">
   Alterar Informa&ccedil;&atilde;o de Registo
</a>
			</c:if>
                        </td>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln108', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln108"/>">
   Criar Evento
</a>
			</c:if>
                        </td>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln9', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln9"/>">
   Ver Favoritos
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
                      	<li class="current">
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
 &gt; </span><a class="small" href="<webratio:Link link=""/>">Visualiza&ccedil;&atilde;o de Eventos
</a><span class="">
</span>
 &gt;
		     <span>P&aacute;gina Principal Registados</span> 
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
<c:if test="${not(empty mciu3) and (mciu3.dataSize gt 0)}">
	<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      MostrarEventos
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain MultiChoiceIndexUnit">
				<table>
					<tr>
						<td colspan="2" class="error"><html:errors property="mciu3Checked" /></td>
					</tr>
					<tr>
						<td>
							<table border="0" cellspacing="1" cellpadding="2">
								<tr>
									<th class=" header"/>
                                          <th nowrap="nowrap" class=" header">T&iacute;tulo</th>
                                          <th nowrap="nowrap" class=" header">Descri&ccedil;&atilde;o</th>
                                          <th nowrap="nowrap" class=" header">&Iacute;nicio</th>
                                          <th nowrap="nowrap" class=" header">Fim</th>
                                          <th nowrap="nowrap" class=" header">Latitude</th>
                                          <th nowrap="nowrap" class=" header">Longitude</th>
			<c:if test="${webratio:isTargetAccessible('ln86', pageContext)}">
<th class=" header" /> 
			</c:if>
								</tr>
							<c:forEach var="current" varStatus="status" items="${mciu3.data}">
								<c:set var="index" value="${status.index}" />
									<tr class="row<c:if test="${index mod 2 eq 0}">Alternate</c:if>">	
										<td>
											<html:multibox styleId="mciu3_17839067_${index}" property="mciu3Checked" styleClass="checkBox"><c:out value="${mciu3.key[index]}"/></html:multibox>
										</td>
										  <td class=" value<c:if test="${index mod 2 eq 0}">Alternate</c:if> string"><c:out value="${current.titulo}"/></td>
										  <td class=" value<c:if test="${index mod 2 eq 0}">Alternate</c:if> string"><c:out value="${current.descricao}"/></td>
										  <td class=" value<c:if test="${index mod 2 eq 0}">Alternate</c:if> timestamp"><fmt:formatDate value="${current.dtinicio}" pattern="${timestampPattern}"/></td>
										  <td class=" value<c:if test="${index mod 2 eq 0}">Alternate</c:if> timestamp"><fmt:formatDate value="${current.dtfim}" pattern="${timestampPattern}"/></td>
										  <td class=" value<c:if test="${index mod 2 eq 0}">Alternate</c:if> float"><fmt:formatNumber value="${current.lat}" pattern="${floatPattern}"/></td>
										  <td class=" value<c:if test="${index mod 2 eq 0}">Alternate</c:if> float"><fmt:formatNumber value="${current.lon}" pattern="${floatPattern}"/></td>
			<c:if test="${webratio:isTargetAccessible('ln86', pageContext)}">
                                          <td> 
                                              <c:choose>
                                                <c:when test="${index mod 2 eq 0}">
		<c:if test="${webratio:isTargetAccessible('ln86', pageContext)}">
		 			<a title="Ver Evento Detalhado" id="ln86" class=" linkAlternate" href="<webratio:Link link="ln86" position="index"/>">
					Ver Evento Detalhado</a>
	</c:if>
                                                </c:when>
                                                <c:otherwise>
		<c:if test="${webratio:isTargetAccessible('ln86', pageContext)}">
		 			<a title="Ver Evento Detalhado" id="ln86" class=" link" href="<webratio:Link link="ln86" position="index"/>">
					Ver Evento Detalhado</a>
	</c:if>
                                                </c:otherwise>
                                              </c:choose>
										  </td>
			</c:if>
								</tr>
							</c:forEach>
							</table>
								<table>
									<tr>
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
<td  valign="top" align="left" >
<c:if test="${not(empty dau2) and (dau2.dataSize gt 0)}">
<div id="map_canvas" style="width:800px; height:450px; text-align: center; float: left;"></div>
	<table id="dadosinit" cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Dados Iniciais
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain DataUnit">
			    <table>
							<tr class="row">
			        		  	<th class=" header">Latitude Menor</th>
			        		  	<td class=" value float"><fmt:formatNumber value="${dau2.data.lat1}" pattern="${floatPattern}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Latitude Maior</th>
			        		  	<td class=" value float"><fmt:formatNumber value="${dau2.data.lat2}" pattern="${floatPattern}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Longitude Menor</th>
			        		  	<td class=" value float"><fmt:formatNumber value="${dau2.data.lon1}" pattern="${floatPattern}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Longitude Maior</th>
			        		  	<td class=" value float"><fmt:formatNumber value="${dau2.data.lon2}" pattern="${floatPattern}"/></td>
			        		</tr>
				  <tr>
				  <td colspan="8">
			           <table>
			               <tr>
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
	$("page16FormBean").observe("wr:pageFocus", function(e) {
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

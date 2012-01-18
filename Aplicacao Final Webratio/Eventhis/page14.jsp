<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="bean" uri="http://struts.apache.org/tags-bean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="html" uri="http://struts.apache.org/tags-html" %>
<%@ taglib prefix="webratio" uri="http://www.webratio.com/2006/TagLib/JSP20" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<webratio:Page page="page14"/>
<html>
  <head>
    <title>P&aacute;gina do Evento</title>
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
  
  function initialize() {
  	// cria uma posição (Latitude,longitude)
	// tem que se pôr aqui a receber  os valores que estão no formulário
    var latlng = new google.maps.LatLng(document.getElementsByTagName("td")[20].innerHTML,
										document.getElementsByTagName("td")[21].innerHTML);
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
  	marker.setDraggable(false);	
  }
</script>  
  
  </head>
  <body onload="initialize()">
	<div id="_wr_page" title="Eventhis;sv4#area2#page14"></div>
<html:form action="form_page14.do" styleId="page14FormBean" enctype="multipart/form-data">
  <div id="page14HiddenFields" >
    <html:hidden property="lastURL"/>
    <input type="hidden" name="conditions" value="${conditions}" id="conditions">
    <input type="hidden" name="ln78" value="<webratio:Link link="ln78" />">
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
                          <c:if test="${webratio:isTargetAccessible('ln84', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln84"/>">
   Voltar
</a>
			</c:if>
                        </td>
                        <td nowrap="nowrap" valign="bottom" style="padding-left:5px">
                          <c:if test="${webratio:isTargetAccessible('ln85', pageContext)}">	
 <a class="shortcuts" href="<webratio:Link link="ln85"/>">
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
		     <span>P&aacute;gina do Evento</span> 
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
<c:if test="${not(empty dau1) and (dau1.dataSize gt 0)}">
	<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Evento
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain DataUnit">
			    <table>
							<tr class="row">
			        		  	<th class=" header">T&iacute;tulo</th>
			        		  	<td class=" value string"><c:out value="${dau1.data.titulo}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Descri&ccedil;&atilde;o</th>
			        		  	<td class=" value string"><c:out value="${dau1.data.descricao}"/></td>
			        		</tr>
							<tr>
									<div id="map_canvas" style="width:300px; height:300px; text-align: center; float: right;"></div>
								</tr>
							<tr class="row">
			        		  	<th class=" header">Tipo do Evento</th>
			        		  	<td class=" value string"><c:out value="${dau1.data.eventoToTipo_nome}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">&Iacute;nicio</th>
			        		  	<td class=" value timestamp"><fmt:formatDate value="${dau1.data.dtinicio}" pattern="${timestampPattern}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Fim</th>
			        		  	<td class=" value timestamp"><fmt:formatDate value="${dau1.data.dtfim}" pattern="${timestampPattern}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Latitude</th>
			        		  	<td class=" value float"><fmt:formatNumber value="${dau1.data.lat}" pattern="${floatPattern}"/></td>
			        		</tr>
							<tr class="row">
			        		  	<th class=" header">Longitude</th>
			        		  	<td class=" value float"><fmt:formatNumber value="${dau1.data.lon}" pattern="${floatPattern}"/></td>
			        		</tr>
				  <tr>
				  <td colspan="14">
			           <table>
			               <tr>
			<c:if test="${webratio:isTargetAccessible('ln74', pageContext)}">
<c:if test="${not(webratio:evaluateCondition('cexpr7', null, pageContext))}">
			                 <td> 
		<c:if test="${webratio:isTargetAccessible('ln74', pageContext)}">
		 			<a title="Desmarcar Favorito" id="ln74" class=" link" href="<webratio:Link link="ln74" position="index"/>">
					Desmarcar Favorito</a>
	</c:if>
 </td>
</c:if>
			</c:if>
			<c:if test="${webratio:isTargetAccessible('ln75', pageContext)}">
<c:if test="${webratio:evaluateCondition('cexpr7', null, pageContext)}">
			                 <td> 
		<c:if test="${webratio:isTargetAccessible('ln75', pageContext)}">
		 			<a title="Marcar Como Favorito" id="ln75" class=" link" href="<webratio:Link link="ln75" position="index"/>">
					Marcar Como Favorito</a>
	</c:if>
 </td>
</c:if>
			</c:if>
			<c:if test="${webratio:isTargetAccessible('ln109', pageContext)}">
<c:if test="${webratio:evaluateCondition('cexpr8', null, pageContext)}">
			                 <td> 
		<c:if test="${webratio:isTargetAccessible('ln109', pageContext)}">
		 			<a title="Editar ou Remover Evento" id="ln109" class=" link" href="<webratio:Link link="ln109" position="index"/>">
					Editar ou Remover Evento</a>
	</c:if>
 </td>
</c:if>
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
<tr>
<td  valign="top" align="left" >
<c:if test="${not(empty pwu3) and (pwu3.dataSize gt 0)}">
	<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Comentários
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
		<div class="plain ">
			<div class="plain PowerIndexUnit">
				<table  cellspacing="1" cellpadding="2">
				<!-- instances -->
				<c:forEach var="current" varStatus="status" items="${pwu3.data}">
					<c:set var="index" value="${status.index}"/>	
							<tr>
										<td rowspan="3" class=" value<c:if test="${pwu3.currentIndex eq index}">Current</c:if> blob">				
													<c:if test="${not (empty current.comentarioToUtilizador_teste)}">
		<img border="0" width="50" height="50" class=" " src="<webratio:BLOB value="${current.comentarioToUtilizador_teste}"/>" alt="<c:out value="${current.comentarioToUtilizador_teste.name}"/>" title="<c:out value="${current.comentarioToUtilizador_teste.name}"/>"/> 
  </c:if>
											   </td>
								</tr>
							<tr>
										<td style="background:#F1F1F1" class=" value<c:if test="${pwu3.currentIndex eq index}">Current</c:if> string">				
													<c:out value="${current.titulo}"/>
											   </td>
								</tr>
							<tr>
										<td style="background:#F1F1F1" class=" value<c:if test="${pwu3.currentIndex eq index}">Current</c:if> text">				
													<c:out value="${current.texto}"/>
											   </td>
								</tr>
					</c:forEach>
					<!--  Fim dos comentários --->
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
<table cellspacing="0" width="100%" style="border:1px solid #cccccc">
  <tr title="" >
    <td class="headerOpened">
      Novo Comentario
    </td>
  </tr>
  <tr>
    <td rowspan="1" colspan="1">
	 <div class="plain ">
		<div class="plain EntryUnit">
				<table>
					<tr>
						<td colspan="3" class="error">
							<html:errors property="enu9" />
						</td>
					</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								T&iacute;tulo
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:text onkeypress="if(event.keyCode==13){clickButton('ln78'); return false;}"  size="25" styleId="fld52" styleClass=" field" property="fld52" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld52"/></span>
</td>
					 	</tr>
					<tr class="row">
							<th valign="middle" class=" header">
								Corpo
							</th>
						<td valign="middle" nowrap="nowrap" class=" value">
								<html:textarea styleId="fld53" styleClass=" field" cols="35" rows="8" property="fld53" readonly="false"/>
						</td>
								<td class="error">
<span class=" error"><html:errors property="fld53"/></span>
</td>
					 	</tr>
					<tr>
						<td colspan="3">
					<table>
				      <tr>
			<c:if test="${webratio:isTargetAccessible('ln78', pageContext)}">
					  <td> 
		<c:if test="${webratio:isTargetAccessible('ln78', pageContext)}">
			<input title="Comentar" onclick="$('page14FormBean').target='_self'" class=" button"  id="button:ln78" name="button:ln78" type="submit" value="Comentar">
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
	$("page14FormBean").observe("wr:pageFocus", function(e) {
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

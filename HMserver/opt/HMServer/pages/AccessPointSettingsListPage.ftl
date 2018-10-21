<html>
<head>


<script type="text/javascript">
  setPath("<span onclick='WebUI.enter(SystemConfigPage);'>"+translateKey('menuSettingsPage')+"</span> &gt; "+ translateKey('submenuAccessPointSettings'));
   	
   	ShowAddableAccessPoint = function()
	{  
		var url = '/pages/jpages/hmip/AccessPointSettings/showAddableList?sid='+SessionId;
		var opt =
		{
			onComplete: function(t)
			{
      	jQuery("#messageBoxWaitSearch").remove();
				var response = JSON.parse(t.responseText);
				if(!response.isSuccessful) {
					if(response.errorCode == "42") {
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey(response.content));
					}
				} else {
					jQuery("#content").html(response.content);
				}
			}
		}
		new Ajax.Request(url,opt);
	};
	
	SearchNewAccessPoint = function()
	{  
		var url = '/pages/jpages/hmip/AccessPointSettings/startSearchAddable?sid='+SessionId;
		var opt =
		{
			onComplete: function(t)
			{
				var response = JSON.parse(t.responseText);
				if(!response.isSuccessful) {
					if(response.errorCode == "42") {
						jQuery("#content").html(response.content);
					} else {
						alert(translateKey(response.content));
					}
				} else {
					//TODO make messagebox instead of alert (Wait ) siehe Power point Seite 2
					MessageBox.show(translateKey(response.content), '<br/><br/><img id="messageBoxWaitSearchGraph" src="/ise/img/anim_bargraph.gif"><br/>','','320','75', 'messageBoxWaitSearch', 'messageBoxWaitSearchGraph');
					setTimeout(ShowAddableAccessPoint, 15000);	
				}
			}
		}
		new Ajax.Request(url,opt);
	};
  
 (function () {	  
	  var s = "";
	  s += "<table cellspacing='8'>";
	  s += "<tr>";
	  s += "<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.goBack();'>"+ translateKey('footerBtnPageBack') +"</div></td>";
	  s += "<td align='center' valign='middle'><div class='FooterButton' onclick='SearchNewAccessPoint();'>"+ translateKey('footerBtnNew') +"</div></td>";
	   
	  s += "</tr>";
	  s += "</table>";

	  setFooter(s);
	  translateButtons("btnEdit");
	  translateButtons("btnRemove");
	  translatePage("#${TableId}");
	  jQuery("#${TableId}").show();
	})();
</script>

</head>
<body>
<table id="${TableId}" class="tTable"  border="0" cellpadding="0" cellspacing="0">
  <thead>
    <tr>
      <td class="thCell CLASS04900" >${"$"}{thAccessPointName}</td>
      <td class="thCell CLASS04900" >${"$"}{thPicture}</td>
      <td class="thCell CLASS04900" >${"$"}{thAccessPoint}</td>
      <td class="thCell CLASS04900" >${"$"}{thAccessPointVersion}</td>
      <td class="thCell CLASS04900" >${"$"}{thAccessPointIP}</td>
      <td class="thCell CLASS04900" >${"$"}{thAccessPointState}</td>
      <td class="thCell CLASS04900" >${"$"}{thAction}</td>
    </tr>
  </thead>
  <tbody>
  
    <#list objectList as accessPoint>
      <tr class="CLASS04901">
        <td class="tBodyCellCenter">${accessPoint.name}</td>

        <td class="tBodyCellCenter">
          <div id="pic_${accessPoint.id}"></div>
        </td>

        <td class="tBodyCellCenter">
          <table cellpadding="0" cellspacing="0" border="0" align="center">
            <tr>
              <td class="_CLASS04903">
                ${accessPoint.id}
              </td>
            </tr>
            <tr>
              <td class="_CLASS04903">
                ${accessPoint.type}
              </td>
            </tr>
          </table>
        </td>
        <td name="tdVersion" class="tBodyCellCenter">${accessPoint.version} / ${accessPoint.versionCoprocessor}</td>
        <td name="tdVersion" class="tBodyCellCenter">${accessPoint.ip}</td>
        <td class="tBodyCell">
          <table cellpadding="0" cellspacing="0" border="0" align="center">
            <tr>
              <td class="CLASS04903">
                ${accessPoint.active?string('${"$"}{active}', '${"$"}{inactive}')}
              </td>
            </tr>
            <tr>
              <td>
              </td>
            </tr>
            <tr>
              <td class="_CLASS04903">
                ${accessPoint.primary?string('${"$"}{primary}', '')}
              </td>
            </tr>
          </table>
        </td>
        <!-- Start action column -->
        <td class="tBodyCell CLASS04902" >
          <table cellpadding="0" cellspacing="0" border="0" align="center">
            <tr>
              <td class="CLASS04903">
                <input type="button" name="btnRemove" value="btnRemove" ${accessPoint.primary?string('class="DeviceListButton CLASS10902" disabled', 'class="DeviceListButton CLASS04907"')} onclick="DeleteAccessPoint('${accessPoint.id}');" />
              </td>
            </tr>
            <tr>
              <td>
              </td>
            </tr>
            <tr>
              <td class="CLASS04903">
                <input type="button" name="btnEdit" value="btnEdit" class="DeviceListButton CLASS04907" onclick="EditAccessPointSetting('${accessPoint.id}', '${accessPoint.type}');" />
              </td>
            </tr>
          </table>
        </td>
        <!-- End Action Column -->
      </tr>

      <script type="text/javascript">
        var accessPointType = '${accessPoint.type}',
          devicePic = (accessPointType == "") ? "/config/img/devices/50/CCU3_thumb.png" : "/config/img/devices/50/162_hmipw-drap_thumb.png";
          jQuery("#pic_${accessPoint.id}").html("<img style='max-width:100%; max-height:100%;' src='"+devicePic+"'>");
      </script>

    </#list>
  </tbody>
</table>

<script type="text/javascript">
  var elmTDVersion = jQuery("[name='tdVersion']"),
  lblNotAvailable = translateKey("accessPointNotAvailable");

  jQuery.each(elmTDVersion, function(index, elm) {
    jQuery(elm).text(jQuery(elm).text().replace(/[&\\#,+()$~%'":*?<>{}]/g,'').replace(/notAvailable/g,lblNotAvailable));
  });

	EditAccessPointSetting = function(id, type)
	{
		var url = '/pages/jpages/hmip/AccessPointSettings/showEdit';
		var data = "{";
		data += '"id" : "' + id + '"';
		data += ',"type" : "' + type + '"';
		data += '}';
		CreateCPPopup(url, data);
	};
	
	DeleteAccessPoint = function(id)
	{
		var url = '/pages/jpages/hmip/AccessPointSettings/showDelete';
		var data = "{";
		data += '"id" : "' + id + '"';
		data += '}';
		CreateCPPopup(url, data);
	};
</script>
</body>
</html>
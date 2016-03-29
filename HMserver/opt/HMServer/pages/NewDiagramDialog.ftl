<script>
	translatePage('#messagebox');
  dlgPopup.setWidth(600);
	dlgPopup.readaptSize();

	CreateDiagram = function()
	{
		var element = document.getElementById("DiagramType");
		var diagramType = element.options[element.selectedIndex].value;
		var url = '/pages/jpages/diagram/settings/showAdd?sid='+SessionId +'&diagramType=' + diagramType;
		var opt =
		{
			onComplete: function(t)
			{
				var response = JSON.parse(t.responseText);
				
				if(!response.isSuccessful)
				{
					if(response.errorCode == "42")
					{
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
		
    }
    
</script>
<div class="popupTitle">${"$"}{dialogNewDiagramTitle}</div>
<div class="CLASS21114 j_translate">
	<table class="popupTable" border=1 width="100%">
		<tr class="CLASS21115">
			<td class="CLASS21116">${"$"}{dialogNewDiagramSettings}</td>
			<td  align="center">
				<table>
					<tr>
            <td>
              <select id="DiagramType" size="1">
                  <option value="1">${"$"}{temperatureMeasurement}</option>
                  <option value="2">${"$"}{energyMeasurement}</option>
                  <option value="3">${"$"}{powerMeasurement}</option>
                  <option value="4">${"$"}{userSpecific}</option>
              </select>
            </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<div class="popupControls">
	<table>
		<tr>
			<td class="CLASS21103">
				<div class="CLASS21108" onClick="PopupClose()">${"$"}{footerBtnPageBack}</div>
			</td>
			<td class="CLASS21103" align=right>
				<div class="CLASS21108" onClick="CreateDiagram();PopupClose()">${"$"}{footerBtnOk}</div>
			</td>
		</tr>
	</table>
</div>

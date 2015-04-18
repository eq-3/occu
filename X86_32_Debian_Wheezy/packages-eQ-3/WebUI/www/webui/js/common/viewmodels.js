virtualDevicePrefix = "INT";

//Class to represent a device
function GroupDevice(id, serialNumber, type)
{
	var self = this;
	self.id = id;
	self.serialNumber = serialNumber;
	self.device = DeviceList.getDeviceByAddress(serialNumber);
	self.type = type;
	if(typeof self.device == "undefined")
	{
		self.name = type +" "+ serialNumber;
		
	}
	else
	{
		self.name = self.device.getName();
	}
	
	self.getConfigPending = function()
	{
		var deviceParamSet = homematic('Interface.getParamset', {"interface": "BidCos-RF", "address" : self.serialNumber+":0", "paramsetKey" : "VALUES"});
		if(deviceParamSet.CONFIG_PENDING === '1')
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	self.imagePath = ko.computed(function() {
		if(this.type == "unknown")
		{
			return "/config/img/devices/50/unknown_device_thumb.png";
		}
		else
		{
			return DEV_getImagePath(this.type, 50);
		}
        
    }, this);
	
	self.showDevicePicture = function(groupdevice, mouseoverevent)
	{
		picDivShow(jg_250, self.type, 250, -1, mouseoverevent.currentTarget);
	}
	
	self.hideDevicePicture = function()
	{
		picDivHide(jg_250);
	}
}

function Header(title, propertyName)
{
	var self = this;
	self.title = title;
	self.sortPropertyName = propertyName;
	self.colspan = 1;
	self.asc = true;
	self.isActive = ko.observable(false);
	self.headerClass = ko.computed(function(){
		return self.isActive() ? "DeviceListHead_Active" : "DeviceListHead";
	});
}

function padLeft(nr, n, str){
	return Array(n-String(nr).length+1).join(str||'0')+nr;
}

function createVirtualDeviceSerialNumber (id) {
		return virtualDevicePrefix+padLeft(id,7)
}

function retryGetDeviceAndDeviceName(group, tries) {
	function getGroupDeviceFromRega () {
		group.device = DeviceList.getDeviceByAddress(group.virtualDeviceSerialNumber);
		if(typeof group.device === "undefined")
		{
			if(tries > 0) {
				retryGetDeviceAndDeviceName(group, tries - 1);
			} else {
				group.virtualDeviceName("");
			}
		}
		else
		{
			group.virtualDeviceName(group.device.getName());
		}
	}	
	
	window.setTimeout(getGroupDeviceFromRega, 1000);
}

function VirtualGroup(id, name, groupTypeLabel, virtualDeviceType)
{
	var selfGroup = this;
	selfGroup.id = id;
	selfGroup.name = name;
	var temp = createVirtualDeviceSerialNumber(selfGroup.id);
	selfGroup.virtualDeviceSerialNumber = temp;
	selfGroup.device = DeviceList.getDeviceByAddress(temp);
	selfGroup.groupTypeLabel = groupTypeLabel;
	selfGroup.virtualDeviceName = ko.observable("");
	if(typeof selfGroup.device === "undefined")
	{
		retryGetDeviceAndDeviceName(selfGroup, 3);
	}
	else
	{
		selfGroup.virtualDeviceName(selfGroup.device.getName());
	}

	selfGroup.configureVirtualDevice = function()
	{
	ShowWaitAnim();
		jQuery.get( "/config/ic_deviceparameters.cgi?sid="+SessionId+"&iface=VirtualDevices&address="+selfGroup.virtualDeviceSerialNumber+"&redirect_url=GO_BACK",
		function( data ) {
			WebUI.previousPage        = WebUI.currentPage;
			WebUI.previousPageOptions = WebUI.currentPageOptions;
			WebUI.currentPage = DeviceListPage;
			HideWaitAnim();
			jQuery("#content").html(data);
		});
	}

	selfGroup.operateVirtualDevice = function()
	{
		var virtualDevice = new GroupDevice(selfGroup.virtualDeviceSerialNumber,selfGroup.virtualDeviceSerialNumber);
		console.log(virtualDevice);
		var url = '/pages/tabs/control/devices.htm?sid='+SessionId;
		var pb = "{}";
		var opt =
		{
			postBody: pb,
			onComplete: function(t)
			{
				WebUI.previousPage        = WebUI.currentPage;
				WebUI.previousPageOptions = WebUI.currentPageOptions;
				WebUI.currentPage = ControlDevicesPage;
				var regularExpression = new RegExp("loadChannels\\W\\s[0-9]+\\s\\W");
				var newContent = t.responseText.replace(regularExpression, "loadChannels("+virtualDevice.device.id+")");

				/*regularExpression = new RegExp("WebUI.goBack\\(\\)");
				newContent = newContent.replace(regularExpression, "WebUI.enter"+"(CreateGroupPage)");*/


				jQuery("#content").html(newContent);
			}
		}
		new Ajax.Request(url,opt);
	}
}
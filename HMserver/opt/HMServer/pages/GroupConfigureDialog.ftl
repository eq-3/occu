<script type="text/javascript">
    dlgResult = 0;
    //The Viewmodel
    function GroupConfigureViewModel()
    {
        var self = this;
        self.devicesToConfigure = ko.observableArray();
        <#list devicesList as device>self.devicesToConfigure.push(new GroupDevice("${device.getId()}", "${device.getLabel()}", "${device.getGroupMemberType().getId()}"));</#list>

        self.ignoreConfigure = function()
        {
            self.devicesToConfigure.removeAll();
            PopupClose();
            WebUI.goBack();
        };

        self.checkConfigure = function()
        {
            var tempDevicesToConfigure = new Array();
            ko.utils.arrayForEach(self.devicesToConfigure(), function(item) {
                tempDevicesToConfigure.push(item);
            });

            ko.utils.arrayForEach(tempDevicesToConfigure, function(item) {
                if(item.getConfigPending()==false)
                {
                    self.devicesToConfigure.remove(item);
                }
            });

            if(self.devicesToConfigure().length == 0) {
                PopupClose();
                WebUI.goBack();
            }
        };

        self.checkConfigure();
    }
    var viewModel = new GroupConfigureViewModel();
    // Activates knockout.js
    // This Page needs a new ViewModel
    ko.applyBindings(viewModel, document.getElementById('groupConfigureDialog'));
    translatePage('#messagebox');
    dlgPopup.readaptSize();


</script>
<div id="groupConfigureDialog"  style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 149; background-image: url('/ise/img/tr50.gif');">
    <div style="position: absolute; z-index: 159; width: 100%; top: 50%;">
        <meta content="no-cache" http-equiv="cache-control">
        <meta content="no-cache" http-equiv="pragma">
        <meta content="0" http-equiv="expires">
        <title>response of request with command: removeLink</title>
        <div style="width: 800px; height: 600px; padding: 0px; position: absolute; left: 50%; margin-left: -400px; margin-top: -150px;">
            <div class="popupTitle" style="font-weight: bold;">${"$"}{dialogCreateLinkTitle}</div>
            <div style="overflow: auto; width: 100%; height: 100%;">
                <div >
                    <table class="popupTable" border="1">
                        <thead>
                        <tr class="popupTableHeaderRow">
                            <th>${"$"}{thName}</th>
                            <th>${"$"}{thTypeDescriptorWOLineBreak}</th>
                            <th>${"$"}{thPicture}</th>
                            <th>${"$"}{thHint}</th>
                        </tr>
                        </thead>
                        <tbody data-bind="foreach: devicesToConfigure">
                        <tr class="popupTableRowGray">
                            <td data-bind="text: name"></td>
                            <td data-bind="text: type"></td>
                            <td style="background-color: white;">
                                <div style="position: relative;" data-bind="event: {mouseover: showDevicePicture, mouseout: hideDevicePicture}">
                                    <img data-bind="attr:{src: imagePath, title: name, alt: name}">
                                </div>
                            </td>
                            <td class="toTranslate" align="left" style="padding: 5px; color: red; font-weight: bold;" data-bind="attr:{rowspan: $root.devicesToConfigure().length}, visible: $root.devicesToConfigure()[0] == $data">
                                ${"$"}{dialogCreateLinkErrorContent1}
                                <ul>
                                    <li>
                                        ${"$"}{dialogCreateLinkErrorContent2}
                                        <ul>
                                            <li>${"$"}{dialogCreateLinkErrorContent3}</li>
                                            <li>${"$"}{dialogCreateLinkErrorContent4}</li>
                                        </ul>
                                    </li>
                                    <li>${"$"}{dialogCreateLinkErrorContent5}</li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="CLASS10200">
                    <span class="CLASS10101 colorGradient borderRadius2px" data-bind="click: checkConfigure">${"$"}{btnDirectDeviceLinkCheckAgain}</span>
                    <span class="CLASS10101 colorGradient borderRadius2px" data-bind="click: ignoreConfigure">${"$"}{lblIgnore}</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
dlgResult = 0;
//The Viewmodel
function ChooseGroupViewModel()
{
    var self = this;
    self.groupList = ko.observableArray();
    <#list possibleGroupsList as group>self.groupList.push(new VirtualGroup("${group.getId()}", "${group.getName()}", translateKey("${group.getGroupDefinition().getGroupType().getLabel()}"), "${group.getGroupDefinition().getGroupType().getId()}"));</#list>
    self.serialNumber = "${serialNumber}";
    self.regaID = "${regaID}";

    self.selectedGroupId = ko.observable(self.groupList()[0].id);

    self.groupListHeaders = new Array();
    self.groupListHeaders.push(new Header(translateKey('groupID'), 'id'));
    self.groupListHeaders.push(new Header(translateKey('groupGroupName'), 'name'));
    self.groupListHeaders.push(new Header(translateKey('groupTypeLabel'), 'groupTypeLabel'));
    self.groupListHeaders.push(new Header(translateKey('choice'), 'choice'));

    self.activeGroupListHeader = self.groupListHeaders[0];

    self.sortGroupList = function(header, event){
        if(self.activeGroupListHeader === header) {
            header.asc = !header.asc;
        } else {
            self.activeGroupListHeader.isActive(false);
            self.activeGroupListHeader = header;
        }
        header.isActive(true);
        var prop = header.sortPropertyName;
        var ascSort = function(a,b){ return a[prop] < b[prop] ? -1 : a[prop] > b[prop] ? 1 : a[prop] == b[prop] ? 0 : 0; };
        var descSort = function(a,b){ return ascSort(b,a); };
        var sortFunc = header.asc ? ascSort : descSort;
        self.groupList.sort(sortFunc);
    };
}
var viewModel = new ChooseGroupViewModel();

// Activates knockout.js
// This Page needs a new ViewModel
ko.applyBindings(viewModel, document.getElementById('groupChooseDialogContent'));
translatePage('#messagebox');

dlgPopup.readaptSize();

OnOK = function() {
    var data = new Object();

    data.serialNumber = viewModel.serialNumber;
    data.regaID = viewModel.regaID;
    data.groupId = viewModel.selectedGroupId();

    var url = '/pages/jpages/group/addDevice?sid='+SessionId;
    pb = JSON.stringify(data);
    var opt =
    {
        postBody: pb,
        onComplete: function(t)
        {
            var response = JSON.parse(t.responseText);
            jQuery("#content").html(response.content);
            PopupClose();
        }
    }
    new Ajax.Request(url,opt);
}

</script>
<div class="popupTitle">${"$"}{groupChooserDialogTitle}</div>

<div class="CLASS21114 j_translate" id="groupChooseDialogContent">
    <table class="popupTable" border=1 width="100%">
        <tr class="CLASS21115">
            <td class="CLASS21116">${"$"}{groupChooserDialogGroups}</td>
            <td  align=left style="width: 80%">
                <table class="tTable" style="width: 100%; margin: 0" cellspacing="0" cellpadding="0" border="0">
                    <thead>
                        <tr data-bind="foreach: groupListHeaders">
                            <td style="height: 40px" class="thCell CLASS04900 clickable" data-bind="click: $parent.sortGroupList, text: title, css: headerClass, attr: {colspan: colspan}"></td>
                        </tr>
                    </thead>
                    <tbody data-bind="foreach: groupList">
                        <tr class="CLASS04901">
                            <td data-bind="text: id" class="tBodyCell" style="width: 65px; text-align: center"></td>
                            <td data-bind="text: name" class="tBodyCell"></td>
                            <td class="tBodyCell" data-bind="text: groupTypeLabel"></td>
                            <td class="tBodyCell" style="padding: 0px">
                                <input style="width:100%; height: 40%; margin: 0px" type="radio" name="selectGroupGroup" data-bind="value: id, checked: $root.selectedGroupId" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
            <td class="CLASS21113" align="left">
                <p> ${"$"}{groupChooserDialogGroupChooseHint} </p>
            </td>
        </tr>
    </table>
</div>

<div class="popupControls">
    <table>
        <tr>
            <td class="CLASS21103">
                <div class="CLASS21108" onClick="PopupClose()">${"$"}{btnCancel}</div>
            </td>
            <td class="CLASS21103">
                <div class="CLASS21108" onClick="OnOK()">${"$"}{btnOk}</div>
            </td>
            <td class="CLASS21109">
            </td>
        </tr>
    </table>
</div>
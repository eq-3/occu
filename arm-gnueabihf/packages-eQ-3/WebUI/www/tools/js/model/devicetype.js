/**
 * devicetype.js
 **/
 
/**
 * Gerätetyp.
 **/
DeviceType = Class.create({
 
  initialize: function(id)
  {
    this.id          = id;
    this.name        = id;
    this.description = DEV_getDescription(id);
  },
  
  isDeletable: function()
  {
    return DeviceTypeList.isDeletable(this);
  },
  
  /**
   * Liefert den HTML-Code eines Thumbnails für das Gerät.
   **/
  getThumbnailHTML: function(formName)
  { 
    return DeviceTypeList.getThumbnailHTML(this.id, formName);
  },
  
  /**
   * Liefert den HTML-Code eines Bildes für das Gerät.
   **/
  getImageHTML: function(formName)
  {
    return DeviceTypeList.getImageHTML(this.id, formName);
  }
  
});
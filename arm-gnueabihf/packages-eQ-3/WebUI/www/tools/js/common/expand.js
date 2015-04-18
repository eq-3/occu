/**
 * expand.js
 * JavaScript Erweiterungen.
 **/

Singleton = {
  create: function(base, members)
  {
		var _members = "";
    if (typeof(members) != "undefined") { var _members = members; }
    var singleton = Class.create(base, _members); 
    return new singleton();
  }
};

Interface = {

  /**
   * Erstellt eine neue Schnittstelle
   **/
  create: function(members)
  {
    return members;
  },
  
  /**
   * Prüft, ob ein Objekt eine spezielle Schnittstelle implementiert
   **/
  isImplemented: function(obj, iface)
  {
    for (name in iface)
    {
      if (typeof(obj[name]) == "undefined") { return false; }
    }
    return true;
  }
  
};
 
Array.prototype.ex_joinItem = function(name, separator)
{
  var _separator = " ";
  var result = "";
  
  if (typeof(separator) != "undefined") { _separator = separator; }
  
  if (0 < this.length)
  {
    result = this[0][name];
    for (var i = 1, len = this.length; i < len; i++)
    {
      result += separator + this[i][name];
    }
  }
  
  return result;
}; 
 
/**
 * Wie join, nur dass jeweils eine Eigenschaft verkettet wird
 **/
Array.prototype.ex_joinProperty = function(name, separator)
{
  var _separator = " ";
  var result = "";
  
  if (typeof(separator) != "undefined") { _separator = separator; }
  
  if (0 < this.length)
  {
    result = this[0][name]();
    for (var i = 1, len = this.length; i < len; i++)
    {
      result += separator + this[i][name]();
    }
  }
  
  return result;
};

/**
 * Sortiert ein Array anhand eines Elements
 * name: Bezeichnung des Elements
 * sortReverse: Optional. Dreht die Sortierreihenfolge um
 **/
Array.prototype.ex_sortBy = function(name, sortReverse)
{
  this.sort(function(a,b) { return Object.ex_compare(a[name], b[name]); });
  if (sortReverse) { this.reverse(); }
  
  return this;
};

/**
 * Sortiert eine Array anhand einer Eigenschaft
 * name: Bezeichnung der Eigenschaft
 * sortReverse: Optional. Dreht die Sortierreihenfolge um
 **/
Array.prototype.ex_sortByProperty = function(name, sortReverse)
{
  this.sort(function(a, b) { return Object.ex_compare(a[name](), b[name]()); });
  if (sortReverse) { this.reverse(); }
  
  return this;
};

/**
 * Vergleicht zwei Objekte
 **/
Object.ex_compare = function(objA, objB)
{
  if (typeof(objA.ex_compareTo) != "undefined") { return objA.ex_compareTo(objB); }
  else                                         { return 0; }
};

/**
 * Vergleicht eine Zahl mit einer anderen
 **/
Number.prototype.ex_compareTo = function(other)
{
  if (typeof(other) == "number") { return (this - other); }
  else                           { return 0; }
};

/**
 * Vergleicht zwei Zeichenketten (case-insensitiv)
 **/
String.prototype.ex_compareTo = function(other)
{
  if (typeof(other) == "string")
  {
    var strA = this.toLowerCase();
    var strB = other.toLowerCase();
  
    if      (strA > strB) { return 1; }
    else if (strA < strB) { return -1; }
  }
  
  return 0;
};

/**
 * Ermittelt, ob ein Element in einem Array vorhanden ist
 **/
Array.prototype.ex_contains = function(item)
{
  return (0 <= this.indexOf(item));
};

/**
 * Fügt einem Array ein Element hinzu, falls
 * dieses noch nicht enthalten ist.
 **/
Array.prototype.ex_pushUnique = function(item)
{
  if (!this.ex_contains(item)) { this.push(item); }
  return this;
};

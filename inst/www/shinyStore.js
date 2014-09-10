shinyStore = (function(){ 
  var exports = {};
  
  var namespace;
  
  function supports_html5_storage() {
    try {
      return 'localStorage' in window && window['localStorage'] !== null;
    } catch (e) {
      return false;
    }
  }
  
  if (!supports_html5_storage){
    alert("ls not supported")
    return;
  }
  
  
  // Add callbacks which will be called with (key, val) when an update occurs.
  var callbacks = [];
  exports.addCallback = function(callback){
    callbacks.push(callback);
  }
  
  exports.onUpdate = function(key, val){
    $.each(callbacks, function(i, cb){
      cb(key, val)
    })
  }
  
  // Extract an object representing the local storage that satisfies the current
  // namespace.
  exports.extract = function(){
    var obj = {}
    for ( var i = 0; i < localStorage.length; i++ ) {
      var key = localStorage.key(i);
            
      if (key.indexOf(namespace + '\\') == 0) {
        obj[key.substring(namespace.length + 1)] = localStorage.getItem(key);
      }
    }
    return obj
  }
  
  exports.init = function(ns){
    if (namespace != null){
      throw new Error("shinyStore cannot be initialized twice!")
    }
    namespace = ns;
  }
  
  var shinyStoreInputBinding = new Shiny.InputBinding();
  $.extend(shinyStoreInputBinding, {
    find: function(scope) {
      return $(scope).find(".shiny-store");
    },
    getValue: function(el) {
      return exports.extract()
    },
    setValue: function(el, value) {
      //TODO
    },
    subscribe: function(el, callback) {
      // Register the callback internally
      exports.addCallback(function(k, v){
        callback(exports.extract());
      });
    },
    unsubscribe: function(el) {
      
    }
  });
  Shiny.inputBindings.register(shinyStoreInputBinding);
  
  Shiny.addCustomMessageHandler('shinyStore', function(data) {
    $.each(data, function(key, val){
      var newKey = namespace + '\\' + key;
    localStorage[newKey] = val;
    exports.onUpdate(newKey, val);
    });
  });
  
  handleStorage = function(event){
    exports.onUpdate(event.key, event.newValue);
  }
  
  // Thanks to http://cggallant.blogspot.com/2010/07/html-5-web-storage.html
  // Tested on modern Chrome, IE8 and IE9.
  if (window.attachEvent) {
     document.attachEvent('onstorage', handleStorage);
  } else {
      window.addEventListener('storage', handleStorage, false);
  }
  
  return exports;
})()
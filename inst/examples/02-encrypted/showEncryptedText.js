(function(){
  // We don't have events we can subscribe to for this, so just update periodically 
  // on a timer.
  var updateEncText = function(){
    var st = localStorage.getItem('shinyStore-ex1\\text');
    $('#encText').text(st); // HTML escapes
  }
  
  updateEncText() // Run immediately
  setInterval(updateEncText, 1000) // Schedule once/second
})()
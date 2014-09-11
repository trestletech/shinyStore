(function(){
  // We don't have events we can subscribe to for this, so just update periodically 
  // on a timer.
  var updateEncText = function(){
    var st = localStorage.getItem('shinyStore-ex2\\text');
    // Only update if different
    if ($('#encText').text() !== st){
      $('#encText').text(st); // HTML escapes naturally
    }
  }
  
  updateEncText() // Run immediately
  setInterval(updateEncText, 500) // Schedule twice/second
})()
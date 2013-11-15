//console.log('Loading a web page');
var page = require('webpage').create();
var system = require('system');
var url = 'http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution-control/psi/pollutant-concentrations';


function exit() {
    phantom.exit();
}

page.onConsoleMessage = function(msg) {
  system.stderr.writeLine(msg);
};


function evaluate(page, func) {
  var args = [].slice.call(arguments, 2);
  var fn = "function() { return (" + func.toString() + ").apply(this, " +     JSON.stringify(args) + ");}";
  return page.evaluate(fn);
}

page.open(url, function (status) {
    //console.log('lol');
    //page.includeJs('http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js', function () {
    page.injectJs('jquery.min.js');
    //console.log('injected js');

    page.injectJs('table.js');
   // console.log('injected j2');
    page.evaluate(function() {
        String.prototype.isNumber = function(){return /^\d+$/.test(this);}

        $('.text_psinormal thead').html('<tr><th align="center"><strong>Region</strong></th><th align="center"><strong>SO2</strong></th><th align="center"><strong>PM10</strong></th><th align="center"><strong>NO2</strong></th><th align="center"><strong>O3</strong></th><th align="center"><strong>CO</strong></th><th align="center"><strong>PM2.5</strong></th></tr>');
        var table = $('.text_psinormal').tableToJSON();
        var number;
        
        //var time = $("option[selected='selected']").first();
        var elements = document.getElementsByTagName('option');
        for(var i=0; i<elements.length; i++) {
            var input = elements[i];
            
            if (input.getAttribute('selected') == "selected") {
                if (!input.value.isNumber()) {
                    //console.log('not number!!! :(');
                    continue;
                }
                //console.log("found value");
                //console.log(input.value + " swag" + input.getAttribute('selected'));
                number = input.value;
                break;
            }
        }
        var date = new Date();
        var jsonTime = date.getDate() + ":" + date.getMonth() + ":" + number.substring(0, 2);    
        var json = {};
        json[jsonTime] = table;        
        console.log(JSON.stringify(json));


        //console.log("time " + time);
        //console.log("swag " + time.attr('value'));
      //  console.log("hello!");
        //exit();
        
    });
    phantom.exit();
});

//console.log('Loading a web page');
var page = require('webpage').create();
var system = require('system');
var url = 'http://app2.nea.gov.sg/anti-pollution-radiation-protection/air-pollution-control/psi/pollutant-concentrations';

function exit() {
    phantom.exit();
}
page.onConsoleMessage = function(msg) {
//    fs.write("/dev/stdout", msg, "w");
	system.stdout.writeLine(msg);
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
    var error = 0;
    page.injectJs('table.js');
   // console.log('injected j2');
    page.evaluate(function() {
        String.prototype.isNumber = function(){return /^\d+$/.test(this);}

        $('.text_psinormal thread').html('<tr><th align="center"><strong>Region</strong></th><th align="center"><strong>24-h Sulphur dioxide (µg/m<sup>3</sup>)</strong></th><th align="center"><strong>24-h PM10 (µg/m<sup>3</sup>)</strong></th><th align="center"><strong>1-h Nitrogen dioxide (µg/m<sup>3</sup>)<sup>a</sup></strong></th><th align="center"><strong>8-h Ozone (µg/m<sup>3</sup>)</strong></th><th align="center"><strong>8-h Carbon monoxide (mg/m<sup>3</sup>)</strong></th><th align="center"><strong>24-h PM2.5 (µg/m<sup>3</sup>)<sup>b</sup></strong></th></tr>');
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
	var currentHours = date.getHours() < 10 ? '0' + date.getHours() : date.getHours();
	//console.log(currentHours + " " + number.substring(0,2));
	if (currentHours != number.substring(0,2)) {
		error = 1;
		return;
	}
	var day = ('0' + date.getDate()).slice(-2);
	var month = ('0' + (date.getMonth() + 1)).slice(-2);
	

        var jsonTime = day + ":" + month + ":" + number.substring(0, 2);    
        var json = {};
        json[jsonTime] = table;        
        console.log(JSON.stringify(json));


        //console.log("time " + time);
      	//console.log("swag " + time.attr('value'));
        //console.log("hello!");
        //exit();
        
    });
    if (error != 0) {
   	phantom.exit(1);	
    }
    phantom.exit();
});

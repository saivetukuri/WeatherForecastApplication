$( document ).ready(function() {
    $.ajax({
    	url:'https://api.openweathermap.org/data/2.5/onecall/timemachine?lat='+sessionStorage.getItem("latitude")+"&lon="+sessionStorage.getItem("longitude")+"&dt="+Math.floor(Date.now() / 1000)+"&appid=1c84cab8666649efb96b876bea94fddf&units="+sessionStorage.getItem("units"),
    	type:"GET",
    	datatype:"jsonp",
    	success: function(data){
    		console.log(JSON.stringify(data));
    		sessionStorage.setItem('currentnow',JSON.stringify(data));
    		
    	}
    });
    $.ajax({
    	url:'https://api.waqi.info/feed/geo:'+sessionStorage.getItem("latitude")+";"+sessionStorage.getItem("longitude")+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520",
    	type:"GET",
    	datatype:"jsonp",
    	success: function(data){
    		console.log(data);
    		sessionStorage.setItem('airquality',JSON.stringify(data));
    		
    	}
    });
   
});


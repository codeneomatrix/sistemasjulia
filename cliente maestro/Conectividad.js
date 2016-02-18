var m;
var XHR = (function(){
	var _getImagen = function(){
			var xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function(){
				if (xhr.readyState==4 && xhr.status==200) {
					m = JSON.parse(xhr.responseText).http;
				}
			};
			xhr.open("GET","http://192.168.1.157:8080/camaras/ok/video");
			xhr.send();
		};
	
	return {
		"getImagen": _getImagen
	};
})();
var y = XHR.getImagen();
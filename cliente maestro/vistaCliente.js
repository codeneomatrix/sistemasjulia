var Vista = (function(){
	var _panelCamaras = function(numero){
		var section = document.querySelector("#paneCamera");
		for(var i = 0; i <= numero; i++){
			var div = document.createElement("div");
			section.appendChild(div);
		}
	};

	var _listarCamaras = function(){
		var select = document.querySelector("#setCamera");
		var arregloCamaras = [{"nombre":"camara1",
                               "usuario":"admin",
                               "contra":"Oaxaca123",
                                "ip":"192.168.1.13",
                               "http":"http://admin:@192.168.1.10/video/mjpg.cgi"}
                               ,
                               {"nombre":"camara2",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"189.135.21.22:91",
                                "http": "http://189.135.21.22:91/mjpg/video.mjpg"}
                                ,
                                {"nombre":"camara3",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"187.217.216.173",
                                 "http":"http://187.217.216.173:80/mjpg/video.mjpg"}
                                 ,
                                {"nombre":"camara4",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"187.216.15.205",
                                "http":"http://187.216.15.205:80/mjpg/video.mjpg"}
                                ,
                                {"nombre":"camara5",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"187.174.218.180",
                                "http":"http://187.174.218.180:83/mjpg/video.mjpg"}
                                ,
                                {"nombre":"camara6",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"187.174.81.78",
                                "http":"http://187.174.81.78:80/mjpg/video.mjpg"}
                                ,
                                {"nombre":"camara7",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"201.161.43.98",
                                "http":"http://201.161.43.98:83/mjpg/video.mjpg"}
                                ,
                                {"nombre":"camara8",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"200.79.225.92",
                                "http":"http://200.79.225.92:8080/mjpg/video.mjpg"}
                                ,
                                {"nombre":"camara9",
                               "usuario":"yo",
                               "contra":"nada",
                                "ip":"189.187.139.22",
                                "http":"http://189.187.139.22:8084/mjpg/video.mjpg"}]; //ÉSTO ES PARA EJEMPLIFICAR

		for(var i = 0; i < arregloCamaras.length; i++){
			var option = document.createElement("option");
			option.setAttribute("name", arregloCamaras[i]);
			option.textContent = arregloCamaras[i];
			select.appendChild(option);
		}
	};

	return {
		"listarCamaras": _listarCamaras,
		"panelCamaras": _panelCamaras
	};

})();




?COUNTER
?COUNTER
?COUNTER
?COUNTER
?COUNTER
?COUNTER
?COUNTER
?COUNTER
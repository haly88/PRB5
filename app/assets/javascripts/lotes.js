
function initialize() {
  
  var lote;
  
  var cordenadas = document.getElementById('lote_cordenadas').value;
  
  var mapOptions = {
      center: new google.maps.LatLng(-33.888103, -60.570445),
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.HYBRID,
      disableDefaultUI: true
    };

  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  
  var drawingManager = new google.maps.drawing.DrawingManager({
      drawingMode: google.maps.drawing.OverlayType.POLYGON,
      drawingControl: true,
      drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: [
          //google.maps.drawing.OverlayType.CIRCLE,
          google.maps.drawing.OverlayType.POLYGON
        ]
      },
    });
  drawingManager.setMap(map);

  google.maps.event.addDomListener(document.getElementById('delete-button'), 'click', function(){
      document.getElementById('lote_cordenadas').value = ""
      lote.setMap(null);
      drawingManager.setOptions({
        drawingControl: true,
        drawingMode: google.maps.drawing.OverlayType.POLYGON
      });
    });
  
  google.maps.event.addListener(drawingManager, 'overlaycomplete', function(e) {
      drawingManager.setDrawingMode(null);
      drawingManager.setOptions({drawingControl: false});
      lote = e.overlay;
      mostrarCordenadas(e.overlay);
  });

  var mostrarCordenadas = function(overlay){
    cordenadas = "";
    var len = overlay.getPath().getLength();
    for (var i = 0; i < len; i++) {
       cordenadas += overlay.getPath().getAt(i).toUrlValue(5) + ",";
    };
    document.getElementById('lote_cordenadas').value = cordenadas;
  };
  if (cordenadas){
    cordenadas = cordenadas.split(",");
    var loteCordenadas = [];
    for (var i = 0; i < cordenadas.length-1; i+=2){
      loteCordenadas.push(new google.maps.LatLng(cordenadas[i], cordenadas[i+1])); 
    };
    
    drawingManager.setDrawingMode(null);
    drawingManager.setOptions({drawingControl: false});
    
    lote = new google.maps.Polygon({
    paths: loteCordenadas
    });
    
    lote.setMap(map);
  }
};
google.maps.event.addDomListener(window, 'load', initialize);




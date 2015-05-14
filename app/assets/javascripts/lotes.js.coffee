
lote = undefined
geocoder = undefined
cordenadas = undefined
#boton de borrar
borrarUI = document.createElement('div')

CenterControl = (controlDiv, map) ->
  # Set CSS for the control border
  borrarUI.style.backgroundColor = '#fff'
  borrarUI.style.border = '2px solid #fff'
  borrarUI.style.borderRadius = '3px'
  borrarUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)'
  borrarUI.style.cursor = 'pointer'
  borrarUI.style.marginBottom = '22px'
  borrarUI.style.textAlign = 'center'
  borrarUI.title = 'Borrar Lote y Datos'
  controlDiv.appendChild borrarUI
  # Set CSS for the control interior
  controlText = document.createElement('div')
  controlText.style.color = 'rgb(25,25,25)'
  controlText.style.fontFamily = 'Roboto,Arial,sans-serif'
  controlText.style.fontSize = '16px'
  controlText.style.lineHeight = '38px'
  controlText.style.paddingLeft = '5px'
  controlText.style.paddingRight = '5px'
  controlText.innerHTML = 'Borrar'
  borrarUI.appendChild controlText
  return

initialize = ->
  #cordenadas
  cordenadas = document.getElementById('lote_cordenadas').value
  #cordenadas = "-33.84732,-60.62119,-33.86015,-60.62737,-33.8573,-60.60127,";
  cordenadas = cordenadas.split(',')
  loteCordenadas = []
  i = 0
  while i < cordenadas.length - 1
    loteCordenadas.push new (google.maps.LatLng)(cordenadas[i], cordenadas[i + 1])
    i += 2
  mapOptions = 
    center: new (google.maps.LatLng)(-33.888103, -60.570445)
    zoom: 12
    mapTypeId: google.maps.MapTypeId.HYBRID
    disableDefaultUI: true
  #creo mapa y boton
  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
  geocoder = new (google.maps.Geocoder)
  borrarControlDiv = document.createElement('div')
  borrarControl = new CenterControl(borrarControlDiv, map)
  borrarControlDiv.index = 1
  map.controls[google.maps.ControlPosition.BOTTOM_LEFT].push borrarControlDiv
  drawingManager = new (google.maps.drawing.DrawingManager)(
    drawingMode: google.maps.drawing.OverlayType.POLYGON
    drawingControl: true
    drawingControlOptions:
      position: google.maps.ControlPosition.TOP_CENTER
      drawingModes: [ google.maps.drawing.OverlayType.POLYGON ])
  drawingManager.setMap map
  if loteCordenadas
    lote = new (google.maps.Polygon)(paths: loteCordenadas)
    lote.setMap map
    drawingManager.setDrawingMode null
    drawingManager.setOptions drawingControl: false
  google.maps.event.addListener drawingManager, 'overlaycomplete', (e) ->
    drawingManager.setDrawingMode null
    drawingManager.setOptions drawingControl: false
    lote = e.overlay
    mostrarCordenadas e.overlay
    mostrarArea e.overlay
    mostrarLocalidad e.overlay
    return
  google.maps.event.addDomListener borrarUI, 'click', ->
    document.getElementById('lote_cordenadas').value = ''
    document.getElementById('lote_area').value = ''
    document.getElementById('lote_localidad').value = ''
    lote.setMap null
    drawingManager.setOptions
      drawingControl: true
      drawingMode: google.maps.drawing.OverlayType.POLYGON
    return
  return

google.maps.event.addDomListener window, 'load', initialize

mostrarCordenadas = (overlay) ->
  cordenadas = ''
  len = overlay.getPath().getLength()
  i = 0
  while i < len
    cordenadas += overlay.getPath().getAt(i).toUrlValue(5) + ','
    i++
  document.getElementById('lote_cordenadas').value = cordenadas
  return

mostrarArea = (overlay) ->
  area = google.maps.geometry.spherical.computeArea(overlay.getPath())
  area = area / 10000
  document.getElementById('lote_area').value = area
  return

mostrarLocalidad = (overlay) ->
  geocoder.geocode { 'latLng': overlay.getPath().getAt(1) }, (results, status) ->
    document.getElementById('lote_localidad').value = results[1].formatted_address
    return
  return

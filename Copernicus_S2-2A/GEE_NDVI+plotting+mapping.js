// get dataset & main plots and buffer
var imagecollection = ee.ImageCollection("COPERNICUS/S2_SR")
var geombuff = geometry.buffer(-50000);

Map.addLayer(geometry, {color:'green'}, 'Border');
Map.addLayer(geombuff, {color:'red'}, 'Buffer');
Map.centerObject(geometry);


// image collection 
var S2 = imagecollection
        .filterMetadata('CLOUDY_PIXEL_PERCENTAGE', 'less_than', 10)
        .filterDate('2020-01-01', '2020-12-30')
        .filterBounds(geombuff);


// vegetation and soil pixels & To imagecollection
function fieldpixel(image){   
  var scl = image.select('SCL');
  var veg = scl.eq(4);
  var soil = scl.eq(5);
  var mask = (veg.neq(1)).or(soil.neq(1));
  return image.updateMask(mask);
}
var S2 = S2.map(fieldpixel);


// function to mask clouds
function maskS2clouds(image){
  var qa = image.select('QA60');
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
       .and(qa.bitwiseAnd(cirrusBitMask).eq(0));
  return image.updateMask(mask);
}


// NDVI computation & To imagecollection
var addNDVI = function(image){
  return image.addBands(image.normalizedDifference(['B8', 'B4']));
};
var S2 = S2.map(addNDVI);
print(S2);


// NDVI time series
var evoNDVI = ui.Chart.image.seriesByRegion(
  S2,                   // ImageCollection
  geombuff,             // Region
  ee.Reducer.mean(),    // Type of reducer to apply
  'nd',                 // Band
  10);                  // Scale


// Plotting the NDVI
var plotNDVI1 = evoNDVI          // data
    .setChartType('LineChart')  // Type of plot
    .setSeriesNames(['NDVI'])
    .setOptions({
      interpolateNulls: true,
      lineWidth: 1,
      pointSize: 3,
      title: 'Before cloud filter ( only veg and soil )',
      hAxis: {title: 'Date'},
      vAxis: {title: 'NDVI'}
});
print(plotNDVI1);


// cloud masking and plotting
var S2 = S2.map(maskS2clouds);
var plotNDVI2 = ui.Chart.image.seriesByRegion(
  S2, geombuff, ee.Reducer.mean(), 'nd', 10)
  .setChartType('LineChart')
  .setSeriesNames(['NDVI'])
  .setOptions({
    interpolateNulls: true,
    lineWidth: 1,
    pointSize: 3,
    title: 'After cloud filter',
    hAxis: {title: 'Date'},
    vAxis: {title: 'NDVI'},
    series: {0:{color:'red'}}
});
print(plotNDVI2);


// draw NDVI in map
var NDVI = S2.select(['nd']);
var NDVImed = NDVI.median();
var palette = ['#d73027', '#f46d43', '#fee08b',
               '#d9ef8b', '#a6d96a'];
Map.addLayer(
  NDVImed.clip(geombuff),                 // Clip map to plot borders
  {min:0.2, max:0.6, palette: palette},   // Color palette options
  'NDVI')                                  // Layer name


// export Asset
Export.table.toDrive({
  collection: S2,
  folder:  'earthengine',
  description:'computation NDVI and Plotting, Drawing', 
  fileNamePrefix: 'GEE Learning', 
  fileFormat : 'CSV'
});

  
var table = ee.FeatureCollection("projects/ee-hyesumg0422/assets/Tower_52N_mod_B5_30");
// 어셋에서 테이블 로드
// Step through thumbnails of an image collection showing the development
// of an airstrip developed for forest monitoring.
var redd = ee.FeatureCollection(table)
.filter(ee.Filter.or(
 ee.Filter.eq('Location', 'GBK')));
// 테이블에서 'Location' 컬럼의 필드값이 'GBK'인 데이터만 필터링
// 여기서 'JJ', 'AMD' 등으로 필드값을 바꾸면 아래 코드에서 위경도 받아서 사용함
//var redd = ee.FeatureCollection(geometry2)

print(redd)
var bufferBy = function(size) {
  return function(feature) {
    return feature.buffer(size);   
  };
};
//var box = redd.map(bufferBy(1000));


// Get value with array type, after distinct
// var lon1 = redd.aggregate_first('Lon');
// var lat1 = redd.aggregate_distinct().aggregate_array('Lat');
// var lon2 = redd.reduceColumns(ee.Reducer.toList(), ['Lon']).get('list');
// var lat2 = redd.reduceColumns(ee.Reducer.toList(), ['Lat']).get('list');

// 위 table의 Lon, Lat 컬럼의 값들 리스트로 받아서, 그 중 0번 째 획득,
// 해당 위도, 경도 지점을 point로 사용
// point의 버퍼 500 거리의 Square를 box로 사용
// Automatically get longitude, latitude of column
var lon = ee.List(redd.reduceColumns(ee.Reducer.toList(), ['Lon']).get('list')).get(0);
var lat = ee.List(redd.reduceColumns(ee.Reducer.toList(), ['Lat']).get('list')).get(0);
var point = ee.Geometry.Point([lon, lat]);
var box = point.buffer(500).bounds();
// var box = Map.addLayer(point.buffer(1000).bounds());
print(point);
print(lon, lat)


// Applies scaling factors.
function applyScaleFactors(image) {
  var opticalBands = image.select('SR_B.').multiply(0.0000275).add(-0.2);
  var thermalBands = image.select('ST_B.*').multiply(0.00341802).add(149.0);
  return image.addBands(opticalBands, null, true)
              .addBands(thermalBands, null, true);
}

// Pixel information mask
function maskL8sr(image) {
  // Bits 3 and 5 are cloud shadow and cloud, respectively.
  var cloudShadowBitMask = (1 << 3);
  var cloudsBitMask = (1 << 5);
  // Get the pixel QA band.
  var qa = image.select('QA_PIXEL');
  // Both flags should be set to zero, indicating clear conditions.
  var mask = qa.bitwiseAnd(cloudShadowBitMask).eq(0)
                 .and(qa.bitwiseAnd(cloudsBitMask).eq(0));
  return image.updateMask(mask);
}



// Step through thumbnails of an image collection showing the development
// of an airstrip developed for forest monitoring.
//var box2 = ee.FeatureCollection(table)

var visParams2 = {
  bands: ['B4', 'B3', 'B2'],
  min: 0,
  max: 3000,
  gamma: 1.4
};


var images2 = ee.ImageCollection("COPERNICUS/S2_SR")
    .filterBounds(box)
    .filterDate('2022-01-01', '2022-09-30')
    .filterMetadata('CLOUDY_PIXEL_PERCENTAGE', 'less_than', 10);

Map.centerObject(point, 14);
Map.addLayer(ee.Image(images2.first()), visParams2, 'Sentinel-2');
Map.addLayer(ee.Image().paint(box, 0, 1), {palette: 'FF0000'}, 'Box Outline');
Map.addLayer(ee.Image().paint(point.buffer(30), 0, 1), {palette: 'FFFF00'}, 'Center point');

var selectedIndex2 = 0;
var collectionLength2 = 0;

// Get the total number of images asynchronously, so we know how far to step.
images2.size().evaluate(function(length2) {
  collectionLength2 = length2;
});

// Sets up next and previous buttons used to navigate through previews of the
// images in the collection.
var prevButton2 = new ui.Button('Previous', null, true, {margin: '0 auto 0 0'});
var nextButton2 = new ui.Button('Next', null, false, {margin: '0 0 0 auto'});
var buttonPanel2 = new ui.Panel(
    [prevButton2, nextButton2],
    ui.Panel.Layout.Flow('horizontal'));

// Build the thumbnail display panel
var introPanel2 = ui.Panel([
  ui.Label({
    value: 'Airstrip in Tumring with Sentinel-2',
    style: {fontWeight: 'bold', fontSize: '24px', margin: '10px 5px'}
  }),
  ui.Label('Airstrip developed for forest monitoring.')
]);

// Helper function to combine two JavaScript dictionaries.
function combine2(c, d) {
  var e = {};
  for (var key in c) e[key] = c[key];
  for (key in d) e[key] = d[key];
  return e;
}

// An empty thumbnail that gets filled in during the setImageByIndex callback.
var thumbnail2 = ui.Thumbnail({
  params: combine2(visParams2, {
    dimensions: '240x240',
    region: box
  }),
  style: {height: '240px', width: '240px'},
  onClick: function(widget) {
    // Add the whole scene to the map when the thumbnail is clicked.
    var layer2 = Map.layers().get(0);
    if (layer2.get('eeObject') != thumbnail2.getImage()) {
      layer2.set('eeObject', thumbnail2.getImage());
    }
  }
});

var imagePanel2 = ui.Panel([thumbnail2]);
var dateLabel2 = ui.Label({style: {margin: '2px 0'}});
var idLabel2 = ui.Label({style: {margin: '2px 0'}});
var mainPanel2 = ui.Panel({
  widgets: [introPanel2, buttonPanel2, imagePanel2, idLabel2, dateLabel2],
  style: {position: 'bottom-right', width: '270px'}
});
Map.add(mainPanel2);

// Displays the thumbnail of the image at a particular index in the collection.
var setImageByIndex2 = function(index2) {
  var image2 = ee.Image(images2.toList(1, index2).get(0));
  thumbnail2.setImage(image2);

  // Asynchronously update the image information.
  image2.get('system:id').evaluate(function(id2) {
    idLabel2.setValue('ID: ' + id2);
  });
  image2.date().format("YYYY-MM-dd").evaluate(function(date2) {
    dateLabel2.setValue('Date: ' + date2);
  });
};

// Gets the index of the next/previous image in the collection and sets the
// thumbnail to that image.  Disables the appropriate button when we hit an end.
var setImage2 = function(button2, increment2) {
  if (button2.getDisabled()) return;
  setImageByIndex2(selectedIndex2 += increment2);
  nextButton2.setDisabled(selectedIndex2 >= collectionLength2 - 1);
  prevButton2.setDisabled(selectedIndex2 <= 0);
};

// Set up the next and previous buttons.
prevButton2.onClick(function(button2) { setImage2(button2, -1); });
nextButton2.onClick(function(button2) { setImage2(button2, 1); });

setImageByIndex2(0);
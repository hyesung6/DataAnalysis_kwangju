// Write on Google Earth Engine Code Editor

// 평택&아산 경계의 아산호 주위 폴리곤 데이터
var studyarea = 
    /* color: #d63000 */
    /* shown: false */
    /* displayProperties: [
      {
        "type": "rectangle"
      }
    ] */
    ee.Geometry.Polygon(
        [[[126.97894748836393, 37.00929039898059],
          [126.97894748836393, 36.966509995353064],
          [127.06409153133268, 36.966509995353064],
          [127.06409153133268, 37.00929039898059]]], null, false);

Map.centerObject(studyarea, 13);

var SFCCvis = {bands: ['B8', 'B4', 'B3'], 
               max: 3000};

/// Sentinel-2 Data 2020 ///
var S2020 = ee.ImageCollection('COPERNICUS/S2_SR')
              .filterDate('2021-03-01', '2021-03-31')
              .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
              .filterBounds(studyarea);

function addNDVI(image){              
  var ndvi = image.normalizedDifference(['B8', 'B4']).rename('NDVI')
  return image.addBands(ndvi);
}

var S2020 = S2020.map(addNDVI);

var listS2020dataset = S2020.toList(S2020.size());
print(listS2020dataset, 'Data list_2020');

var img1 = ee.Image(listS2020dataset.get(3)).clip(studyarea); 
// Image.clip() : dataset cut as area
// List.get() : get element of list (index)
Map.addLayer(img1, SFCCvis, 'SFCC Image1');
// Cloudfree scenes: 3, 4, 5
// addLayer for area, selecting between first and last with clean scenes index
// then, classifier learn for cloudfree image 

// can use similar meter-size bands data.
// S2 bands 2 10m, bands 3 10m, bands 4 10m...
// but bands 1, 9, 10 is 60m , So this can't use
var imgcollection = ee.ImageCollection([
                    ee.Image(listS2020dataset.get(3)),
                    ee.Image(listS2020dataset.get(4)),
                    ee.Image(listS2020dataset.get(5))])
                    .select(['B2', 'B3', 'B4', 'B5', 'B6', 'B7', 
                    'B8', 'B8A', 'B11', 'B12']);
print(imgcollection, 'imgcollection');


// Image stacking
var stackCollection = function(imgcollection) {
  var first = ee.Image(imgcollection.first()).select([]);
  var appendBands = function(image, previous) {
    return ee.Image(previous).addBands(image);
  };
  return ee.Image(imgcollection.iterate(appendBands, first));
};

var image_stack = stackCollection(imgcollection);
print(image_stack, 'Image Stack');
Map.addLayer(image_stack, SFCCvis, 'Stacked Image')


/// Image Classification
// -- Forest, Cropland, Fallow, Waterbody, Sand
// pick a Marker on element
// Class Merging
var points = Forest.merge(Cropland).merge(Fallow)
                    .merge(Waterbody).merge(Sand);
print(points, 'Trainging data');
// merge on Vector data of one

var sample = points.randomColumn();
var trainingsample = sample.filter('random <= 0.8'); 
// random-value than less 0.8 is use to train data
var validationsample = sample.filter('random > 0.8');  
// random-value than more 0.8 is use to valid data
print(trainingsample, 'Training sample');
print(validationsample, 'Validation sample');

var training = image_stack.sampleRegions({
    collection: trainingsample,
    properties: ['Class'],
    scale: 20
});
print(training, 'Traning data band values');


// Random-Forest Classifier Model Building
// ee.Classifier.smileRandomForest(numberOfTrees,
//variblesPerSplit, minLeafPopulation, bagFraction, maxNodes, seed)
var RFClassifier = ee.Classifier.smileRandomForest(200).train(training, 'Class');

var Classified = image_stack.classify(RFClassifier).clip(studyarea);
print(Classified, 'Classified');

var Palette = [
  'green',    // Forest
  'yellow',   // Cropland
  'brown',    // Fallow
  'blue',     // Waterbody 
  'grey'      // Sand
  ];
Map.addLayer(Classified, {palette: Palette, min: 1, max: 5}, 'Classified map');



/// Accuracy
// Get a confusion matrix and overall accuracy for the training sample.
var trainAccuracy = RFClassifier.confusionMatrix();
print("Training error matrix", trainAccuracy);
print("Training overall accuracy", trainAccuracy.accuracy());

validation = validation.classify(RFClassifier);
var validationAccuracy = validation.errorMatrix('Class', 'Clssification');
print('Validation error matrix', validationAccuracy);
print('Validation accruracy', validationAccuracy.accuracy());


/// Variable Importance
var explain = RFClassifier.explain();
print(explain, 'Explain');

// Variable Importance of RF Classifier
var variable_importance = ee.Feature(null, ee.Dictionary(explain).get('importance'));

// Chart of Variable of RF Classifier
var chartTitle = 'Random Forest: Bands Variable Importance';
var chart =
    ui.Chart.feature.byProperty(variable_importance)
      .setChartType('BarChart')
      .setOptions({
        title: chartTitle,
        legend: {position: 'none'},
        hAxis: {title: 'Importance'},
        vAxis: {title: 'Bands'}
      });
// Chart: Locaation and Plot
chart.style().set({
  position: 'bottom-left',
  width: '400px',
  height: '400px'
});
Map.add(chart);

/// Export
Export.image.toDrive({
  iamge: Classfied,
  description: 'RF_Classified_map',
  region: studyarea,
  scale: 20,
  fileFormat: 'GeoTIFF',
  maxPixels: 1e9,
});
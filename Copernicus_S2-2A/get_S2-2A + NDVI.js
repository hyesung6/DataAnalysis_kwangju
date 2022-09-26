function maskS2clouds(image) {
    var qa = image.select('QA60');
  
    // Bits 10 and 11 are clouds and cirrus, respectively.
    var cloudBitMask = 1 << 10;
    var cirrusBitMask = 1 << 11;
  
    // Both flags should be set to zero, indicating clear conditions.
    var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
        .and(qa.bitwiseAnd(cirrusBitMask).eq(0));
  
    return image.updateMask(mask);
  }
  
  function addNDVI(image) {
    var ndvi = image.normalizedDifference(['B8', 'B4']).rename('ndvi')
    return image.addBands([ndvi])
  }
    
  var image = ee.ImageCollection("COPERNICUS/S2_SR");
  
  var drycollection = image.filterDate('2021-01-01','2021-03-31')
                   .filterBounds(geometry)                                    //Change the area here
                   .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE',10))
                   .map(maskS2clouds)
                   .map(addNDVI);
                   
  
  print(drycollection); // You can see how much dates of images included
  
  //---REPEAT---//
  
  // -----point BAND value extraction---// 
  
  var points = ee.FeatureCollection(drycollection)            //change here
  
  var params1 = drycollection.map(function(image) {
    return image
      .reduceRegions({ 
        collection: points,
        reducer: ee.Reducer.median(),
        scale: 100
      })
      .copyProperties(image, ['system:time_start']);
  })
  .flatten(); // 다차원 배열을 1차원으로 change
    
  print(params1.limit(5000));
  
  // -----export the data----- //
  
  Export.table.toDrive({
    collection:  params1, 
    folder:  'earthengine',
    description:'part8_30_1', 
    fileNamePrefix: 'part8_30_1', 
    fileFormat : 'CSV'
  });
  
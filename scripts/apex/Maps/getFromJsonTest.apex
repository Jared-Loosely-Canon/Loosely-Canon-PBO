String jsonString = '[{"place_id":87588400,"licence":"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright","osm_type":"node","osm_id":8619017264,"boundingbox":["41.1997306","41.1998306","-73.1055584","-73.1054584"],"lat":"41.1997806","lon":"-73.1055084","display_name":"477, Woodland Drive, Devon, Milford, South Central COG, Connecticut, 06460, United States","class":"place","type":"house","importance":0.6201}]';

List<Object>  result = (List<Object>) JSON.deserializeUntyped(jsonString);
// List<Object> results = (List<Object>) result.get('results');
Map<String, Object> firstResult = (Map<String, Object>) result.get(0);

String latitude = (String) firstResult.get('lat');
String longitude = (String) firstResult.get('lon');

System.debug(latitude);
System.debug(longitude);
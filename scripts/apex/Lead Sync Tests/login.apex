
// Canon_Connect__c settings = [SELECT Id, Integration_User__r.email, Integration_Password__c, access_token__c, refresh_token__c FROM Canon_Connect__c LIMIT 1];
// Canon_Connect_Setting__mdt connect = Canon_Connect_Setting__mdt.getInstance('Connect');


// String email = settings.Integration_User__r.email;
// String password = settings.Integration_Password__c;
// Map<String,String> bodyMap = new Map<String,String>();
// bodyMap.put('email', email);
// bodyMap.put('password', password);
// String body = JSON.serialize(bodyMap);
// HttpResponse res;
// if(settings.refresh_token__c == null){
//     String httpMethod = 'POST'; 
//     String urlEndpoint = connect.Connect_Endpoint__c + 'auth/jwt/create';
//     WebCalloutHelper helper = new WebCalloutHelper(httpMethod, body, urlEndpoint);

//     Map<String,String> headers = new Map<String,String>();
//     headers.put('Content-Type', 'application/json');
//     headers.put('Accept', 'application/json');
//     helper.headerMapProperty = headers;

//     res = helper.callout();
// }

// System.debug('res: ' + res);
// System.debug('res: ' + res.getBody());
// Map<String,Object> tokens = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
// System.debug('tokens: ' + tokens);
// String access = tokens.get('access') != null ? (String) tokens.get('access') : null;
// String refresh = tokens.get('refresh') != null ? (String) tokens.get('refresh') : null;
// System.debug('access: ' + access);
// System.debug('refresh: ' + refresh);
// settings.access_token__c = access;
// settings.refresh_token__c = refresh;
// update settings;
ConnectAuthentication auth = new ConnectAuthentication();
Canon_Connect__c settings = auth.authenticate();
System.debug('settings: ' + settings);
ConnectAuthentication auth = new ConnectAuthentication();
Canon_Connect__c settings = auth.authenticate();
System.debug('Settings: ' + settings);
update settings;
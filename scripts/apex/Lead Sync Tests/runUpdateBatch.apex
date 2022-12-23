Canon_Connect__c settings = [SELECT Id, Integration_User__r.email,  Last_Contact_Sync__c, Last_Lead_Sync__c FROM Canon_Connect__c LIMIT 1];
settings.Last_Contact_Sync__c = null;
settings.Last_Lead_Sync__c = null;
update settings;

Database.executeBatch(new BatchUpdateConnectLeads(DateTime.now()));
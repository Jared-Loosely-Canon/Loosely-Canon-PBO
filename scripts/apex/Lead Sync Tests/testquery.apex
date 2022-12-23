Canon_Connect_Setting__mdt connect = Canon_Connect_Setting__mdt.getInstance('Connect');
Canon_Connect__c settings = [SELECT Id, Integration_User__r.email,  Last_Lead_Sync__c FROM Canon_Connect__c LIMIT 1];
Boolean markSynced = false;
List<Schema.FieldSetMember> fields = Schema.SObjectType.Lead.fieldSets.getMap().get('Phone_Fields').getFields();



Datetime lastSync = settings?.Last_Lead_Sync__c; 
if(lastSync == null){
    lastSync = Datetime.now().addDays(Integer.valueOf((connect.Days_to_Sync__c*-1)));
}
Date day = Date.valueOf(lastSync);

String phoneFields = '';
for (Schema.FieldSetMember field : fields) {
    phoneFields += field.getFieldPath() + ',';
    System.debug('field: ' + field.getSObjectField());
}
String selectStatement = 'SELECT ' + phoneFields + ' Id, FirstName, LastName, Email, ConvertedOpportunityId, ConvertedContactId, ConvertedAccountId FROM Lead';
String whereStatement = ' WHERE CreatedDate >= :day';// + day;

String query = selectStatement + whereStatement;
// String query = selectStatement;

System.debug('query: ' + query);
Lead[] leads = Database.query(query);
System.debug('leads: ' + leads);
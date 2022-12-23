Lead[] leads = [SELECT Id, Company, Email, FirstName, LastName, Phone, Title, LeadSource, Status, Website FROM Lead];
String message = 'Hey how is it going {!Lead.FirstName}? This is {!User.FirstName} from {!User.CompanyName}.';
List<String> leadIds = new List<Id>();
for(Lead l : leads){
    leadIds.add(String.valueOf(l.Id));
}
MergeFieldService service = new MergeFieldService(message, leadIds);
service.getMergeFields();
Map<String,String> valueMap = service.valueMap;
System.debug('valueMap: ' + valueMap);
for(String key: valueMap.keySet()){
    message = message.replace(key, valueMap.get(key));
}
System.debug('message: ' + message);
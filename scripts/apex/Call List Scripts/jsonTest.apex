Call_List_Member__c member = [SELECT Id, Contact__c, call_List__c FROM Call_List_Member__c WHERE Contact__c != null LIMIT 1];

ConnectWrappers.callListMemberWrapper callListMemberWrapper = new ConnectWrappers.callListMemberWrapper();
callListMemberWrapper.call_list_Id = member.call_List__c;
callListMemberWrapper.salesforce_contact_id = member.Contact__c;
callListMemberWrapper.connect_Id = member.connect_Id;

Map<String, ConnectWrappers.callListMemberWrapper> callListMemberWrapperMap = new Map<String, ConnectWrappers.callListMemberWrapper>();
callListMemberWrapperMap.put('1', callListMemberWrapper); 
String body = JSON.serialize(callListMemberWrapperMap);
System.debug('body: ' + body);
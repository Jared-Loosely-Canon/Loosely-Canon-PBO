canon_app__Call_List_Member__c[] members = [SELECT Id FROM canon_app__Call_List_Member__c WHERE canon_app__Call_List__c='a2l5c000002uaohAAA'];// WHERE canon_app__Call_List__c = 'a2l5c000002lU2vAAE'];
// System.debug(members.size());
delete members;


// RecordType[] rt = [SELECT Id, Name FROM RecordType WHERE SObjectType = 'Lead'];
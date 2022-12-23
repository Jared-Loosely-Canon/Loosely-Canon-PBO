Lead[] leads = [SELECT Id, Connect_Id__c FROM lead];
for(Lead lead : leads) {
    lead.Connect_Id__c = null;
}
update leads;
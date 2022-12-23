private static Canon_Connect_Setting__mdt connect = Canon_Connect_Setting__mdt.getInstance('Connect');

Datetime lastSync = connect?.Last_Lead_Sync__c;
if(lastSync == null){
    lastSync = Datetime.now().addDays(-365);
}
Lead[] leads = [SELECT
                Id,
                FirstName,
                LastName,
                MobilePhone,
                ConvertedOpportunityId,
                ConvertedContactId,
                ConvertedAccountId
            FROM
                Lead
            WHERE LastModifiedDate >= :lastSync OR CreatedDate >= :lastSync LIMIT 10];

System.debug('leads: ' + leads.size());

ContactWrapper[] contactWrappers = new List<ContactWrapper>();
for(Lead l : leads){
    ContactWrapper wrapper = new ContactWrapper();
    wrapper.First_Name = l.FirstName;
    wrapper.Last_Name = l.LastName;
    wrapper.Mobile_Phone = l.MobilePhone;
    wrapper.Salesforce_Lead_Id = l.Id;
    wrapper.Salesforce_Contact_Id = l.ConvertedContactId;
    wrapper.Salesforce_Person_Id = null;
    contactWrappers.add(wrapper);
}

String body = JSON.serialize(contactWrappers);
System.debug('json: ' + body);
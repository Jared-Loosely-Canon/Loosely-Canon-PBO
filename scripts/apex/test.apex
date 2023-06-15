CampaignMember[] campaignMembers = [SELECT Id, CampaignId, ContactId, LeadId, Status, HasResponded, CreatedDate, CreatedById, 
    LastModifiedDate, LastModifiedById, SystemModstamp, IsDeleted FROM CampaignMember 
    WHERE CampaignId = '701Dn000000lH6AIAU'];

Set<Id> contactIds = new Set<Id>();
Set<Id> leadIds = new Set<Id>();

for (CampaignMember member : campaignMembers) {
    if (member.ContactId != null) {
        contactIds.add(member.ContactId);
    } else if (member.LeadId != null) {
        leadIds.add(member.LeadId);
    }
}

Schema.DescribeSObjectResult describeResult = Contact.sObjectType.getDescribe();
String queryContacts = Utilities.queryAllFields(describeResult, 'Contact') + ' FROM Contact WHERE Id IN :contactIds';
Map<Id, Contact> contacts = new Map<Id, Contact>((List<Contact>) Database.query(queryContacts));

describeResult = Lead.sObjectType.getDescribe();
String queryLeads = Utilities.queryAllFields(describeResult, 'Lead') + ' FROM Lead WHERE Id IN :leadIds';
Map<Id, Lead> leads = new Map<Id, Lead>((List<Lead>) Database.query(queryLeads));

CampaignMemberDetails[] cmds = new List<CampaignMemberDetails>();

for(CampaignMember c : campaignMembers){
    if (c.ContactId != null) {
        cmds.add(new CampaignMemberDetails(c, contacts.get(c.ContactId)));
    } else if (c.LeadId != null) {
        cmds.add(new CampaignMemberDetails(c, leads.get(c.LeadId)));
    }
}

String data = JSON.serialize(cmds);
System.debug(data);
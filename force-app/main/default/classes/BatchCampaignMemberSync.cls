/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 07-10-2023
 * @last modified by  : Jared Simpson
**/
public without sharing class BatchCampaignMemberSync implements Database.Batchable<sObject>, Database.AllowsCallouts {
    public Id campaignId;
    public Boolean success = true;

    public BatchCampaignMemberSync(Id campaignId){
        this.campaignId = campaignId;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        Schema.DescribeSObjectResult  describeResult = CampaignMember.sObjectType.getDescribe();
        String queryCampaignMember = Utilities.queryAllFields(describeResult, 'CampaignMember');
        queryCampaignMember += ' FROM CampaignMember WHERE CampaignId = \'' + campaignId + '\'';

        return Database.getQueryLocator(queryCampaignMember);
    }

    public void execute(Database.BatchableContext BC, List<CampaignMember> campaignMembers) {
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

        WebCalloutHelper helper = new WebCalloutHelper('POST', data, 'callout:Connect_Login/' + 'api/services/salesforce/campaign-member');
        HTTPResponse res = helper.callout();

        System.debug('Response: ' + res.getBody());

        if (res.getStatusCode() != 201 && Test.isRunningTest() == false) {
            success = false;
            throw new CalloutException(res.getBody());
        }
    }

    public void finish(Database.BatchableContext BC){
        if(success){
            Campaign campaign = new Campaign(Id = campaignId, Last_Canon_Email_Sync__c = System.now());
            update campaign;
        }
    }
}
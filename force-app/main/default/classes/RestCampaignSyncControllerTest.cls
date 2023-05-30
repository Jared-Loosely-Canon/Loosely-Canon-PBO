/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 05-30-2023
 * @last modified by  : Jared Simpson
**/
@isTest
private with sharing class RestCampaignSyncControllerTest {
    @TestSetup
    static void makeData(){
        List<Campaign> campaigns = new List<Campaign>();
        for(Integer i = 0; i < 1; i++){
            campaigns.add(new Campaign(Name = 'Test Campaign ' + i));
        }
        insert campaigns;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < 10; i++){
            contacts.add(new Contact(FirstName = 'Test', LastName = 'Contact ' + i));
        }
        insert contacts;

        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 10; i++){
            leads.add(new Lead(FirstName = 'Test', LastName = 'Lead ' + i));
        }
        insert leads;
        
        List<CampaignMember> campaignMembers = new List<CampaignMember>();
        for(Integer i = 0; i < 10; i++){
            campaignMembers.add(new CampaignMember(CampaignId = campaigns[0].Id, ContactId = contacts[i].Id));
            campaignMembers.add(new CampaignMember(CampaignId = campaigns[0].Id, LeadId = leads[i].Id));
        }
        insert campaignMembers;
    }

    @isTest
    static void testSyncCampaignSuccess(){
        Campaign campaign = [SELECT Id, Name FROM Campaign LIMIT 1];
        String res = RestCampaignSyncController.syncCampaign(campaign.Id);
        System.assertEquals('Successfully started the sync', res, 'The sync should have started');
    }

    @isTest
    static void testSyncCampaignFailure(){
        try{
            String res = RestCampaignSyncController.syncCampaign('');
        }
        catch(Exception e){
            System.assertEquals('Script-thrown exception', e.getMessage(), 'The response should be an error message');
        }
    }
}
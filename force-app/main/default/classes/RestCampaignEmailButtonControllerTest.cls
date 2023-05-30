/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 05-30-2023
 * @last modified by  : Jared Simpson
**/
@isTest
private with sharing class RestCampaignEmailButtonControllerTest {
    @TestSetup
    static void makeData(){
        List<Campaign> campaigns = new List<Campaign>();
        for(Integer i = 0; i < 1; i++){
            campaigns.add(new Campaign(Name = 'Test Campaign ' + i));
        }
        insert campaigns; 
    }

    @isTest
    static void testSendCampaignEmailSuccess(){
        Campaign campaign = [SELECT Id FROM Campaign LIMIT 1];
        String res = RestCampaignEmailButtonController.sendCampaignEmail(campaign.Id);
        System.assertEquals('Successfully started the email send', res, 'The response should be a success message');
    }

    @isTest
    static void testSendCampaignEmailFail(){
        try{
            String res = RestCampaignEmailButtonController.sendCampaignEmail('');
        }
        catch(Exception e){
            System.assertEquals('Script-thrown exception', e.getMessage(), 'The response should be an error message');
        }
    }
}
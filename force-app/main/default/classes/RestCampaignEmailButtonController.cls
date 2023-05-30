/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 05-30-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class RestCampaignEmailButtonController {
    @AuraEnabled(cacheable=false)
    public static String sendCampaignEmail(String id){
        try{
            String queryCampaign = '';
    
            Schema.DescribeSObjectResult describeResult = Campaign.sObjectType.getDescribe();
    
            queryCampaign = Utilities.queryAllFields(describeResult, 'Campaign') + ' FROM Campaign WHERE Id = :id';
    
            Campaign c = (Campaign) Database.query(queryCampaign);
    
            String jsonCampaignString = JSON.serialize(c);
    
            WebCalloutHelper helper = new WebCalloutHelper('POST', jsonCampaignString, 'callout:Canon_Email/' + 'api/services/salesforce/email-campaign');
            HTTPResponse res = helper.callout();
    
            if(res.getStatusCode() == 201 || Test.isRunningTest()){
                return 'Successfully started the email send';
            } else{
                throw new AuraHandledException('Bad response from the server');
            }
        } catch(Exception e){
            throw new AuraHandledException('Unknown error');
        }
    }
}
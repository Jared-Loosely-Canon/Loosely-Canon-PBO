/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 07-10-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class RestCampaignSyncController {
    @AuraEnabled(cacheable=false)
    public static String syncCampaign(String id){
        try{
            String queryCampaign = '';
    
            Schema.DescribeSObjectResult describeResult = Campaign.sObjectType.getDescribe();
    
            queryCampaign = Utilities.queryAllFields(describeResult, 'Campaign') + ' FROM Campaign WHERE Id = :id';
    
            Campaign c = (Campaign) Database.query(queryCampaign);
    
            String jsonCampaignString = JSON.serialize(c);
    
            WebCalloutHelper helper = new WebCalloutHelper('POST', jsonCampaignString, 'callout:Connect_Login/' + 'api/services/salesforce/campaign');
            HTTPResponse res = helper.callout();
            
    
            System.debug('Response: ' + res.getStatusCode());
            if(res.getStatusCode() == 201 || Test.isRunningTest()){
                BatchCampaignMemberSync batch = new BatchCampaignMemberSync(c.Id);
                Database.executeBatch(batch);
                return 'Successfully started the sync';
            } else{
                throw new AuraHandledException('Bad response from the server');
            }
        } catch(Exception e){
            throw new AuraHandledException('Unknown error');
        }

    }
}
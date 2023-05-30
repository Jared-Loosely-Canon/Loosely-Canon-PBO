String id = '701DR000000ZENIYA4';
String queryCampaign = '';

Schema.DescribeSObjectResult describeResult = Campaign.sObjectType.getDescribe();

queryCampaign = Utilities.queryAllFields(describeResult, 'Campaign');
queryCampaign += ' FROM Campaign WHERE Id = :id';

Campaign c = (Campaign) Database.query(queryCampaign);

String jsonCampaignString = JSON.serialize(c);
System.debug(jsonCampaignString);

WebCalloutHelper helper = new WebCalloutHelper('POST', jsonCampaignString, 'callout:Canon_Email/' + 'api/services/salesforce/campaign');
HTTPResponse res = helper.callout();

System.debug('Response: ' + res.getBody());
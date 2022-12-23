// Get the report ID
List <Report> reportList = [SELECT Id,DeveloperName FROM Report where 
    Id = '00O0R0000026g1aUAA'];
String reportId = (String)reportList.get(0).get('Id');

Call_list__c callList = new Call_list__c();
callList.Id = 'a0G0R000003wCbLUAU';

Call_List_Member__c[] callListMembers = new List<Call_List_Member__c>();


// Run a report synchronously
Reports.reportResults results = Reports.ReportManager.runReport(reportId, true);
results.getAllData();

String[] idList = new List<String>();

Reports.GroupingValue[] dim = results.getGroupingsDown().getGroupings();
// System.debug('Report getGroupingsDown: ' + results.getGroupingsDown());
for(Reports.GroupingValue groupingVal : dim){
    Call_List_Member__c callListMember = new Call_List_Member__c();
    String val = String.valueOf(groupingVal.getValue());
    if(val != null && val.startsWith('003')){
        callListMember.Contact__c = val;
    // } else if(val != null && val.startsWith('001')){
    //     callListMember.Account__c = val;
    } else if(val != null && val.startsWith('00Q')){
        callListMember.Lead__c = val;
    } else{
        continue;
    }
    callListMember.name = 'Call List Members: ' + val;
    callListMember.Call_List__c = callList.Id;
    callListMembers.add(callListMember);
}
insert callListMembers;
System.debug('idList size: ' + idList.size());

/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 08-31-2023
 * @last modified by  : Jared Simpson
**/
global class TriggerHelper {
    global static Boolean bypassTriggerCheck() {
        if (Trigger.isExecuting) {
            return (Trigger.isAfter && Trigger.isUpdate && updatedConnectId(Trigger.old[0]));
        } else{
            return false;
        }
    }

    global static Boolean updatedConnectId(SObject o){
        if(o instanceOf Contact){
            Contact c = (Contact)o;
            if(c.canon_app__Connect_Id__c == null){
                return true;
            }
        } else if(o instanceOf Lead){
            Lead l = (Lead)o;
            if(l.canon_app__Connect_Id__c == null){
                return true;
            }
        } 
        return false;
    }

    @InvocableMethod(label='Bypass Trigger Check' description='Returns true if Canon Connect is Syncing. Bypass your flow with this')
    global static List<Result> getBypassTriggerCheckResult() {
        List<Result> results = new List<Result>();
        Result result = new Result();
        result.bypassResult = bypassTriggerCheck();
        results.add(result);
        return results;
    }

    global class Result {
        @InvocableVariable(required=true)
        global Boolean bypassResult;
    }

    global static Boolean personAccountEnabled() {
        Boolean isPersonAccountsEnabled;
        try {
            Schema.DescribeSObjectResult accResult = Account.sObjectType.getDescribe();
            Map<String, Schema.SObjectField> sObjectFields = accResult.fields.getMap();
            if(sObjectFields.containsKey('personcontactid'))
                isPersonAccountsEnabled = true;
            else
                isPersonAccountsEnabled = false;
        } catch (Exception e) {
            isPersonAccountsEnabled = false;
        }
        return isPersonAccountsEnabled;
    }
}
/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 08-31-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class AccountTriggerHandler extends TriggerFactory {
    public AccountTriggerHandler() {
        super();
        this.newRecords = (List<SObject>) Trigger.new;
        this.oldRecords = (List<SObject>) Trigger.old;
        this.newRecordsMap = Trigger.newMap;
        this.oldRecordsMap = Trigger.oldMap;
    }

    private static canon_app__Canon_Connect_Setting__mdt connect = canon_app__Canon_Connect_Setting__mdt.getInstance('Connect');

    public override void beforeInsert(){

    }

    public override void afterInsert(){
        Map<Id, Account> accountsCreatedInSalesforce = new Map<Id, Account>();
        for(Account o : (List<Account>) this.newRecords){
            if(o.canon_app__Connect_Id__c == null && o.canon_app__Connect_Id__c == null){
                accountsCreatedInSalesforce.put(o.Id, o);
            }
        }
        if(accountsCreatedInSalesforce.size() > 0){
            if((connect.canon_app__Connect_Sync_Enabled__c && connect.canon_app__Sync_or_Async_Data_Feed__c == 'Synchronous') || Test.isRunningTest()){
            ID jobID = System.enqueueJob(new AccountSerializerQueueable(accountsCreatedInSalesforce, 'POST'));
            }
        }
    }

    public override void beforeUpdate(){

    }   

    public override void afterUpdate(){
        if((connect.canon_app__Connect_Sync_Enabled__c && connect.canon_app__Sync_or_Async_Data_Feed__c == 'Synchronous') || Test.isRunningTest()){
            ID jobID = System.enqueueJob(new AccountSerializerQueueable((Map<Id, Account>) this.newRecordsMap, 'PUT'));
        }
    }

    public override void beforeDelete(){
        List<canon_app__Cadence__c> cadences = [SELECT Id, canon_app__Status__c FROM canon_app__Cadence__c WHERE canon_app__Account__c IN :this.oldRecordsMap.keySet() WITH SECURITY_ENFORCED];
        if(cadences.size() > 0 && Utilities.checkDeleteFieldLevelSecurity(cadences[0])){
            delete cadences;
        }
    }

    public override void afterDelete(){
        if(connect.canon_app__Connect_Sync_Enabled__c || Test.isRunningTest()) {
            ID jobID = System.enqueueJob(new AccountSerializerQueueable((Map<Id, Account>) this.oldRecordsMap, 'DELETE'));
        }
    }

    public override void afterUndelete(){
        if(connect.canon_app__Connect_Sync_Enabled__c || Test.isRunningTest()) {
            ID jobID = System.enqueueJob(new AccountSerializerQueueable((Map<Id, Account>) this.newRecordsMap, 'POST'));
        }
    }
}
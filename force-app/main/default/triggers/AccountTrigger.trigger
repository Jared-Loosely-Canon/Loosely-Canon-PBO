/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 03-13-2023
 * @last modified by  : Jared Simpson
**/
trigger AccountTrigger on Account (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    if(!TriggerHelper.personAccountEnabled()){
        return;
    }
    if(System.isBatch() || System.isFuture() || System.isQueueable() || System.isScheduled() || System.isFunctionCallback()) {
        return;
    } else if(TriggerHelper.bypassTriggerCheck()) {
        return;
    } else {
        TriggerFactory.run('AccountTriggerHandler');
    }
}
/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 04-11-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class EventTriggerHandler extends TriggerFactory {
    public EventTriggerHandler() {
        super();
        this.newRecords = (List<SObject>) Trigger.new;
        this.oldRecords = (List<SObject>) Trigger.old;
        this.newRecordsMap = Trigger.newMap;
        this.oldRecordsMap = Trigger.oldMap;
    }
    String orgTimezone = UserInfo.getTimeZone().getID();


    public override void beforeInsert(){
        for(Event e : (Event[]) newRecords){
            DateTime dtUtc = e.StartDateTime;
            e.Start_Date_Time_Readable__c = dtUtc.format('h:mm a M/d');
            e.Start_Time_Readable__c = dtUtc.format('h:mm a');
        }
    }

    public override void afterInsert(){

    }

    public override void beforeUpdate(){
        for(Event e : (Event[]) newRecords){
            Event oldEvent = (Event) oldRecordsMap.get(e.Id);
            if(e.StartDateTime != oldEvent.StartDateTime) {
                DateTime dtUtc = e.StartDateTime;
                e.Start_Date_Time_Readable__c = dtUtc.format('h:mm a M/d');
                e.Start_Time_Readable__c = dtUtc.format('h:mm a');
            }
        }
    }   

    public override void afterUpdate(){

    }

    public override void beforeDelete(){

    }

    public override void afterDelete(){

    }

    public override void afterUndelete(){

    }
}
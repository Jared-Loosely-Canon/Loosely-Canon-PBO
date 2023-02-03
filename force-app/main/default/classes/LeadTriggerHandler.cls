/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 02-02-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class LeadTriggerHandler extends TriggerFactory {
    public LeadTriggerHandler() {
        super();
        this.newRecords = (List<SObject>) Trigger.new;
        this.oldRecords = (List<SObject>) Trigger.old;
        this.newRecordsMap = Trigger.newMap;
        this.oldRecordsMap = Trigger.oldMap;
    }

    public override void beforeInsert(){
        // Lead[] newLeads = (Lead[]) this.newRecords;

        // for(Lead lead : newLeads){
        //     lead.LeadSource = 'Web';
        // }
    }

    public override void afterInsert(){

    }

    public override void beforeUpdate(){

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
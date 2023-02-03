/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 02-02-2023
 * @last modified by  : Jared Simpson
**/
trigger LeadTrigger on Lead (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    TriggerFactory.run('LeadTriggerHandler');
}
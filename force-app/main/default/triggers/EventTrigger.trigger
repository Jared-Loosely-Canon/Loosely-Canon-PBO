/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 04-09-2023
 * @last modified by  : Jared Simpson
**/
trigger EventTrigger on Event (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    TriggerFactory.run('EventTriggerHandler');
}
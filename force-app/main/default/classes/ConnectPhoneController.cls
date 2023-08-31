/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 07-14-2023
 * @last modified by  : Jared Simpson
**/
global with sharing class ConnectPhoneController {
    @AuraEnabled(cacheable=true)
    global static canon_app__Canon_Connect_Setting__mdt getSettings(){
        canon_app__Canon_Connect_Setting__mdt settings = canon_app__Canon_Connect_Setting__mdt.getInstance('Connect');
        return settings;
    }

    global List<canon_app__Canon_Connect_Setting__mdt> controllerSettings() {
        return [SELECT Id, canon_app__Connect_Endpoint__c FROM canon_app__Canon_Connect_Setting__mdt WHERE DeveloperName = 'Connect'];
    }
}
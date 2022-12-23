Scheduled_Text__c[] texts = [SELECT Id FROM Scheduled_Text__c];
Scheduled_Task__c[] tasks = [SELECT Id FROM Scheduled_Task__c];
Cadence__c[] cadences = [SELECT Id FROM Cadence__c];
delete texts;
delete tasks;
delete cadences;
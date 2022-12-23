Cadence__c[] cadences = [SELECT Id, Status__c FROM Cadence__c];
for(Cadence__c c: cadences){
    c.status__c = 'In Progress';
}
update cadences;
Connect_Event__e e = new Connect_Event__e();
e.Navigation__c = true;
e.Object__c = 'Lead';
e.Record_Id__c = '00QDP00000V2EQN2A3';

List<Connect_Event__e> events = new List<Connect_Event__e>();
events.add(e);

List<Database.SaveResult> results = EventBus.publish(events);

for (Database.SaveResult sr : results) {
    if (sr.isSuccess()) {
        System.debug('Successfully published event.');
    } else {
        for(Database.Error err : sr.getErrors()) {
            System.debug('Error returned: ' +
                        err.getStatusCode() +
                        ' - ' +
                        err.getMessage());
        }
    }       
}
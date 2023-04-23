// Get the timezone of the organization
String orgTimezone = UserInfo.getTimeZone().getID();

// Create a DateTime variable for today at 9:00 am in the UTC timezone
DateTime dateTimeUTC = DateTime.newInstanceGMT(Date.today(), Time.newInstance(9, 0, 0, 0));

// Convert the DateTime to the timezone of the organization
DateTime dateTimeOrg = dateTimeUTC.addHours(TimeZone.getTimeZone(orgTimezone).getOffset(dateTimeUTC) / 3600000);

// Extract the Time component from the converted DateTime
Time timeOrg = dateTimeOrg.time();

// Output the Time variable
System.debug('Time variable: ' + timeOrg);


canon_app__Task_Template__c[] taskTemplates = [SELECT Id, canon_app__Due_Time__c FROM canon_app__Task_Template__c];
for(canon_app__Task_Template__c taskTemplate : taskTemplates) {
    if(taskTemplate.canon_app__Due_Time__c != null) {
        taskTemplate.canon_app__Due_Time__c = Time.newInstance(9, 0, 0, 0);
    }
}
delete taskTemplates;

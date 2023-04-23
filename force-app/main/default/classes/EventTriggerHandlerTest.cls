/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 04-11-2023
 * @last modified by  : Jared Simpson
**/
@IsTest
private class EventTriggerHandlerTest {
    @IsTest
    static void testBeforeInsert() {
        // Create a new event with a start date/time of April 10, 2023 at 9:00 AM UTC
        Event e = new Event(
            Subject = 'Test Event',
            StartDateTime = DateTime.newInstance(Date.newInstance(2023, 4, 10), Time.newInstance(9, 0, 0, 0)),
            EndDateTime = DateTime.newInstance(Date.newInstance(2023, 4, 10), Time.newInstance(10, 0, 0, 0))
        );

        // Insert the event
        Test.startTest();
        insert e;
        Test.stopTest();

        // Verify that the Start_Date_Time_Readable__c field was populated with the correct value
        e = [SELECT Start_Date_Time_Readable__c FROM Event WHERE Id = :e.Id];
        System.assertEquals('9:00 AM 4/10', e.Start_Date_Time_Readable__c);
    }

    @IsTest
    static void testBeforeUpdate() {
        // Create a new event with a start date/time of April 10, 2023 at 9:00 AM UTC
        Event e = new Event(
            Subject = 'Test Event',
            StartDateTime = DateTime.newInstance(Date.newInstance(2023, 4, 10), Time.newInstance(9, 0, 0, 0)),
            EndDateTime = DateTime.newInstance(Date.newInstance(2023, 4, 10), Time.newInstance(10, 0, 0, 0))
        );
        insert e;

        // Update the start date/time to April 11, 2023 at 10:00 AM UTC
        e.StartDateTime = DateTime.newInstance(Date.newInstance(2023, 4, 11), Time.newInstance(10, 0, 0, 0));
        e.EndDateTime = DateTime.newInstance(Date.newInstance(2023, 4, 11), Time.newInstance(11, 0, 0, 0));

        // Update the event
        Test.startTest();
        update e;
        Test.stopTest();

        // Verify that the Start_Date_Time_Readable__c field was updated with the correct value
        e = [SELECT Start_Date_Time_Readable__c FROM Event WHERE Id = :e.Id];
        System.assertEquals('10:00 AM 4/11', e.Start_Date_Time_Readable__c);

        delete e;
    }
}

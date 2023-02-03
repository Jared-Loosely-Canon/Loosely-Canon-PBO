/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 02-02-2023
 * @last modified by  : Jared Simpson
**/
@isTest
private with sharing class LeadServiceTest {
    @TestSetup
    static void makeData(){
        // Create a test leads
        Lead[] newLeads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            Lead testLead = new Lead(
                FirstName = 'Test ' + i,
                LastName = 'Lead',
                Company = 'Test Company ' + i,
                Status = 'Open - Not Contacted'
            );
            newLeads.add(testLead);
        }
        insert newLeads;
    }

    @isTest
    static void testGetLeads(){
        List<Lead> leads = [SELECT Id, Status FROM Lead WHERE Status = 'Open - Not Contacted'];

        // Assert that the leads were returned
        System.assertEquals(200, leads.size(), 'The leads were not created');
    }

    @isTest
    static void updateLeads(){
        List<Lead> leads = [SELECT Id, Status FROM Lead WHERE Status = 'Open - Not Contacted'];

        for(Lead lead : leads){
            lead.Status = 'Open - Contacted';
        }

        update leads;

        // Assert that the leads were updated
        List<Lead> updatedLeads = [SELECT Id, Status FROM Lead WHERE Status = 'Open - Contacted'];
        System.assertEquals(200, updatedLeads.size(), 'The leads were not updated');
    }

    @isTest
    static void deleteLeads(){
        List<Lead> leads = [SELECT Id, Status FROM Lead WHERE Status = 'Open - Not Contacted'];

        delete leads;

        // Assert that the leads were deleted
        List<Lead> deletedLeads = [SELECT Id, Status FROM Lead WHERE Status = 'Open - Not Contacted'];
        System.assertEquals(0, deletedLeads.size(), 'The leads were not deleted');
    }
}
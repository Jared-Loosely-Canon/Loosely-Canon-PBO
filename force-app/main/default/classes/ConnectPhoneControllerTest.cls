/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 07-14-2023
 * @last modified by  : Jared Simpson
**/
@isTest
private with sharing class ConnectPhoneControllerTest {
    @isTest
    static void testConnectPhoneController() {
        Test.startTest();
        ConnectPhoneController.getSettings();
        ConnectPhoneController controller = new ConnectPhoneController();
        controller.controllerSettings();
        Test.stopTest();
    }
}
/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 08-31-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class ContactWrapper {
    public String Salesforce_Record_Id {get;set;}
    public String Salesforce_Lead_Id {get;set;}
    public String Salesforce_Contact_Id {get;set;}
    public String Salesforce_Person_Account_Id {get;set;}
    public String Salesforce_User_Id {get;set;}
    public String Salesforce_Org_Id {get;set;}
    public String Connect_Id {get;set;}
    public String First_Name {get;set;}
    public String Last_Name {get;set;}
    public String Email {get;set;}
    public String Phone {get;set;}
    public String[] Phones {get;set;}
    public String id {get;set;}
    public Boolean Do_Not_Email {get;set;}
    public Boolean Do_Not_Call {get;set;}
    public Boolean Do_Not_Text {get;set;}
    public Boolean Do_Not_Auto_Dial {get;set;}
    public Boolean Do_Not_Contact {get;set;}
    public Boolean Text_Marketing_Opt_In {get;set;}
    public Boolean Email_Marketing_Opt_In {get;set;}
    public Boolean Is_Person_Account {get;set;}

    public static ContactWrapper contactWrapperBuilder(Lead l){
        ContactWrapper wrapper = new ContactWrapper();
        wrapper.id = l.canon_app__Connect_Id__c;
        wrapper.Connect_Id = l.canon_app__Connect_Id__c;
        wrapper.First_Name = l.FirstName;
        wrapper.Last_Name = l.LastName;
        wrapper.Salesforce_Lead_Id = l.Id;
        wrapper.Salesforce_Contact_Id = l.ConvertedContactId;
        wrapper.Salesforce_Person_Account_Id = l.ConvertedAccountId;
        wrapper.Do_Not_Call = l.canon_app__Do_Not_Call__c;
        wrapper.Do_Not_Email = l.canon_app__Do_Not_Email__c;
        wrapper.Do_Not_Contact = l.canon_app__Do_Not_Contact__c;
        wrapper.Do_Not_Text = l.canon_app__Do_Not_Text__c;
        wrapper.Do_Not_Auto_Dial = l.canon_app__Do_Not_Auto_Dial__c;
        wrapper.Text_Marketing_Opt_In = l.canon_app__Text_Marketing_Opt_In__c;
        wrapper.Email_Marketing_Opt_In = l.canon_app__Email_Marketing_Opt_In__c;
        return wrapper;
    }

    public static ContactWrapper contactWrapperBuilder(Contact l){
        ContactWrapper wrapper = new ContactWrapper();
        wrapper.id = l.canon_app__Connect_Id__c;
        wrapper.Connect_Id = l.canon_app__Connect_Id__c;
        wrapper.First_Name = l.FirstName;
        wrapper.Last_Name = l.LastName;
        wrapper.Salesforce_Lead_Id = null;
        wrapper.Salesforce_Contact_Id = l.Id;
        wrapper.Salesforce_Person_Account_Id = null;
        wrapper.Do_Not_Call = l.canon_app__Do_Not_Call__c;
        wrapper.Do_Not_Email = l.canon_app__Do_Not_Email__c;
        wrapper.Do_Not_Contact = l.canon_app__Do_Not_Contact__c;
        wrapper.Do_Not_Text = l.canon_app__Do_Not_Text__c;
        wrapper.Do_Not_Auto_Dial = l.canon_app__Do_Not_Auto_Dial__c;
        wrapper.Text_Marketing_Opt_In = l.canon_app__Text_Marketing_Opt_In__c;
        wrapper.Email_Marketing_Opt_In = l.canon_app__Email_Marketing_Opt_In__c;
        return wrapper;
    }

    public static ContactWrapper contactWrapperBuilder(Account l){
        ContactWrapper wrapper = new ContactWrapper();
        Map<String, String> accountFields = new Map<String, String>{
            'Connect_Id__pc' => 'Connect_Id__pc', 'First_Name' => 'FirstName', 'Last_Name' => 'LastName', 'Salesforce_Contact_Id' => 'PersonContactId', 
            'Salesforce_Person_Account_Id' => 'Id', 'Id' => 'Id',
            'Do_Not_Email' => 'Do_Not_Email__pc', 'Do_Not_Call' => 'Do_Not_Call__pc', 'Do_Not_Text' => 'Do_Not_Text__pc', 
            'Do_Not_Auto_Dial' => 'Do_Not_Auto_Dial__pc', 'Do_Not_Contact' => 'Do_Not_Contact__pc',
            'Text_Marketing_Opt_In' => 'Text_Marketing_Opt_In__pc', 'Email_Marketing_Opt_In' => 'Email_Marketing_Opt_In__pc'};
        wrapper.id = (String) l.get(accountFields.get('Connect_Id__pc'));
        wrapper.Connect_Id = (String) l.get(accountFields.get('Connect_Id__pc'));
        wrapper.First_Name = (String) l.get(accountFields.get('First_Name'));
        wrapper.Last_Name = (String) l.get(accountFields.get('Last_Name'));
        wrapper.Salesforce_Lead_Id = null;
        wrapper.Salesforce_Contact_Id = (String) l.get(accountFields.get('Salesforce_Contact_Id'));
        wrapper.Salesforce_Person_Account_Id = (String) l.get(accountFields.get('Id'));
        wrapper.Do_Not_Call = (Boolean) l.get(accountFields.get('Do_Not_Call'));
        wrapper.Do_Not_Email = (Boolean) l.get(accountFields.get('Do_Not_Email'));
        wrapper.Do_Not_Contact = (Boolean) l.get(accountFields.get('Do_Not_Contact'));
        wrapper.Do_Not_Text = (Boolean) l.get(accountFields.get('Do_Not_Text'));
        wrapper.Do_Not_Auto_Dial = (Boolean)l.get(accountFields.get('Do_Not_Auto_Dial'));
        wrapper.Text_Marketing_Opt_In = (Boolean) l.get(accountFields.get('Text_Marketing_Opt_In'));
        wrapper.Email_Marketing_Opt_In = (Boolean) l.get(accountFields.get('Email_Marketing_Opt_In'));
        wrapper.Is_Person_Account = true;        
        return wrapper;
    }

    public static HttpResponse sendRequest(ContactWrapper[] contactWrappers, String endpoint, String operation){
        String httpMethod = operation; 
        String body = JSON.serialize(contactWrappers);
        String urlEndpoint = 'api/salesforce/'+endpoint;

        WebCalloutHelper helper = new WebCalloutHelper(httpMethod, body, urlEndpoint);

        HttpResponse res = helper.callout();
        return res;
    }
}
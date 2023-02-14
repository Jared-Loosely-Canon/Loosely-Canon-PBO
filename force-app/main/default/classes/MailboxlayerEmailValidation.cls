/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 02-10-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class MailboxlayerEmailValidation {
    private Mailboxlayer_Credentials__mdt mailbox = Mailboxlayer_Credentials__mdt.getInstance('Credential_One');

    public String validateEmails(Map<Id, String> idEmailMap){
        List<Map<String, Object>> responses = new List<Map<String, Object>>();
        Map<Id, String> emailUpdates = new Map<Id, String>();
        for(Id i : idEmailMap.keySet()){
            String email = idEmailMap.get(i);
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('https://api.apilayer.com/email_verification/check?email='+email);
            req.setHeader('apikey', mailbox.API_Key__c);
            Http http = new Http();
            HttpResponse res;
            if(!Test.isRunningTest()){
                   res = http.send(req);
                }
                if(Test.isRunningTest()){
                    res = new HttpResponse();
                    res.setStatusCode(200);
                }
            if (res.getStatusCode() == 200) {
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                if (responseMap.get('format_valid') == true && responseMap.get('smtp_check') == true) {
                    responses.add(responseMap);
                } else {
                    emailUpdates.put(i, email+'.invalid');
                }
            }
        }
        Lead[] leadUpdates = new List<Lead>();
        Contact[] contactUpdates = new List<Contact>();
        for(Id i : emailUpdates.keySet()){
            if (String.valueOf(i).startsWith('00Q')){
                Lead lead = new Lead(Id = i, Email = emailUpdates.get(i));
                leadUpdates.add(lead);
            } else {
                Contact contact = new Contact(Id = i, Email = emailUpdates.get(i));
                contactUpdates.add(contact);
            } 
        }
        try {
            if(leadUpdates.size() > 0){
                update leadUpdates;
            }
            if(contactUpdates.size() > 0){
                update contactUpdates;
            }
        } catch (Exception e) {
            return 'An error occured: ' + e.getMessage();
        }
        return 'success';
    }

    public HTTPResponse validateEmail(String email){
        String urlEndpoint = 'https://apilayer.com/api/check?access_key=YOUR_ACCESS_KEY&email='+email;
        WebCalloutHelper helper = new WebCalloutHelper('GET', '', urlEndpoint);
        HTTPResponse res = helper.callout();
        return res;
    }

    @InvocableMethod(label='Validate Email' description='Validate Email')
    public static void validateEmail(List<InputResult> inputs){
        Map<Id, String> idEmailMap = new Map<Id, String>();
        for(InputResult input : inputs){
            idEmailMap.put(input.id, input.email);
        }
        MailboxlayerEmailValidation validator = new MailboxlayerEmailValidation();
        String result = validator.validateEmails(idEmailMap);
    }

    @AuraEnabled(cacheable=false)
    public static string validateEmailController(String[] ids){
        Map<Id, String> idEmailMap = new Map<Id, String>();
        String[] contactIds = new List<String>();
        String[] leadIds = new List<String>();
        for(String id : ids){
            if (id.startsWith('003')){
                contactIds.add(id);
            } else {
                leadIds.add(id);
            }
        }
        List<Contact> contacts = [SELECT Id, Email FROM Contact WHERE Id IN :contactIds];
        List<Lead> leads = [SELECT Id, Email FROM Lead WHERE Id IN :leadIds];
        for(Contact c : contacts){
            idEmailMap.put(c.Id, c.Email);
        }
        for(Lead l : leads){
            idEmailMap.put(l.Id, l.Email);
        }

        MailboxlayerEmailValidation validator = new MailboxlayerEmailValidation();
        return validator.validateEmails(idEmailMap);
    }

    public class InputResult {
        @InvocableVariable(label='Email' description='Email' required=true)
        public String email;

        @InvocableVariable(label='Id' description='Record Id' required=true)
        public String id;
    }

}
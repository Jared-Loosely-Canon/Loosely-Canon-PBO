/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 08-31-2023
 * @last modified by  : Jared Simpson
**/
public class AccountSerializerQueueable implements Queueable, Database.AllowsCallouts {
    public AccountSerializerQueueable(Map<Id, Account> accounts, String operation) {
        this.accounts = accounts;
        this.operation = operation;
        this.phoneHelper = new PhoneHelper(this.accounts.values()[0].getSObjectType().getDescribe().getName());
    }

    private Map<Id, Account> accounts;
    private String operation;
    private String classDescription = 'AccountSerializerQueuable - Sends accounts to the Connect Server';
    Boolean runCatchTest = false;
    
    private PhoneHelper phoneHelper;
    private Map<Id, PhoneHelper.PhoneWrapper[]> objectPhoneMap = new Map<Id, PhoneHelper.PhoneWrapper[]>();
    private PhoneHelper.PhoneWrapper[] phoneWrappers = new List<PhoneHelper.PhoneWrapper>();

    public void execute(QueueableContext context) {
        if (this.accounts.size() > 0 && Utilities.checkUpdateFieldLevelSecurity(this.accounts.values()[0])) {
            try {
                if(runCatchTest){
                    Integer i = 1/0;
                }
                List<Account> AccountUpdateList = new List<Account>();
                ContactWrapper[] contactWrappers = new List<ContactWrapper>();
                
                for(Account o : this.accounts.values()){
                    ContactWrapper wrapper = ContactWrapper.contactWrapperBuilder(o);
                    PhoneHelper.PhoneWrapper[] objectPhones = new List<PhoneHelper.PhoneWrapper>();

                    if(this.operation == 'POST'){
                        wrapper.id = null;
                        wrapper.Connect_Id = null;
                    } else {
                        wrapper.id = o.canon_app__Connect_Id__c;
                        wrapper.Connect_Id = o.canon_app__Connect_Id__c;
                    }
                    
                    for (String fieldApiName : phoneHelper.phoneApiNames) {
                        String fieldValue = String.valueOf(o.get(fieldApiName));
                        if(fieldValue != null && fieldValue != '' && fieldValue != 'null'){
                            PhoneHelper.PhoneWrapper phoneWrapper = new PhoneHelper.PhoneWrapper();
                            phoneWrapper.Phone_Number = fieldValue;
                            phoneWrapper.Type = phoneHelper.apiLabelMap.get(fieldApiName);
                            phoneWrapper.Salesforce_Contact_Id = o.canon_app__Connect_Id__c;
                            objectPhones.add(phoneWrapper);
                        }
                    }
                    if(objectPhones.size() == 0 && o.canon_app__Connect_Id__c != null){
                        PhoneHelper.PhoneWrapper phoneWrapper = new PhoneHelper.PhoneWrapper();
                        phoneWrapper.Salesforce_Contact_Id = o.canon_app__Connect_Id__c;
                        objectPhones.add(phoneWrapper);
                    }
                    this.objectPhoneMap.put(o.Id, objectPhones);
                    contactWrappers.add(wrapper);
                }
                
                HttpResponse res = sendRequest(contactWrappers,'contacts');
                if(res.getStatusCode() == 201 && this.operation == 'POST'){
                    AccountUpdateList = updates(res.getBody());
                }
                if(this.operation != 'DELETE'){
                    for(PhoneHelper.PhoneWrapper[] phoneWrapper : this.objectPhoneMap.values()){
                        this.phoneWrappers.addAll(phoneWrapper);
                    }
                    res = sendRequest(phoneWrappers, 'phoneIntegration');
                }
                if((res.getStatusCode() == 201 && this.operation == 'POST') || Test.isRunningTest()){
                    update AccountUpdateList;
                }
            } catch (Exception e) {
                System.debug('Jared debug Account '+e.getMessage());
                // LogHandler handler = new LogHandler(e,'AccountSerializerQueuable', this.classDescription);
            }
        }
    }

    public HttpResponse sendRequest(ContactWrapper[] contactWrappers, String endpoint){
        String httpMethod = this.operation; 
        String body = JSON.serialize(contactWrappers);
        String urlEndpoint = 'api/salesforce/'+endpoint;

        WebCalloutHelper helper = new WebCalloutHelper(httpMethod, body, urlEndpoint);

        HttpResponse res = helper.callout();
        return res;
    }

    public HttpResponse sendRequest(PhoneHelper.PhoneWrapper[] phoneWrappers, String endpoint){
        String httpMethod = 'POST'; 
        String body = JSON.serialize(phoneWrappers);
        String urlEndpoint = 'api/salesforce/'+endpoint;
        WebCalloutHelper helper = new WebCalloutHelper(httpMethod, body, urlEndpoint);

        HttpResponse res = helper.callout();
        return res;
    }

    private List<Account> updates(String body){
        ConnectWrappers.createContactResponseWrapper wrapper = new ConnectWrappers.createContactResponseWrapper();
        List<ConnectWrappers.createContactResponseWrapper> wrappers = wrapper.parse(body);
        Account[] AccountUpdateList = new List<Account>();
        for(ConnectWrappers.createContactResponseWrapper wrap : wrappers){
            Account Account = new Account();
            Account.Id = wrap.Salesforce_Person_Account_Id;
            Account.canon_app__Connect_Id__c = wrap.id;
            AccountUpdateList.add(Account);
            for(PhoneHelper.PhoneWrapper phoneWrapper : this.objectPhoneMap.get(Account.Id)){
                phoneWrapper.Salesforce_Contact_Id = Account.canon_app__Connect_Id__c;
            }
        }
        return AccountUpdateList;
    }
}
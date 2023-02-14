Lead[] leads = [SELECT Id, Email FROM Lead WHERE Email != null];
String[] emails = new List<String>();
for(Lead l: leads){
    emails.add(l.Email);
}
Mailboxlayer_Credentials__mdt mailbox = Mailboxlayer_Credentials__mdt.getInstance('Credential_One');
List<Map<String, Object>> responses = new List<Map<String, Object>>();

for(String email : emails){
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
            System.debug('Valid email: ' + Lead.Email);
            responses.add(responseMap);
        } else {
            System.debug('Invalid email: ' + Lead.Email);
            responses.add(responseMap);
        }
    }
}
System.debug('responses: ' + responses);
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:Connect_Login/api/sms/salesforce?unread');
req.setMethod('GET');
System.debug('Jared Check req: '+ req);
System.debug('Jared Check req body: '+ req.getBody());
System.debug('Jared Check req authorization header: '+ req.getHeader('Authorization'));
Http http = new Http();
HTTPResponse res = http.send(req);
System.debug('Jared Check res: '+ res.getBody());

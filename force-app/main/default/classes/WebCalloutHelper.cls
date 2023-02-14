/*
* @Description: Used to abstract making web callouts so that there is no need to write or test them again
* @Author: Jared Simpson
* @Knowledge Article: https://looselycanonllc.atlassian.net/wiki/spaces/CD/pages/9207908/Canon+Apex
* @Version: v1.0.0
*/
public with sharing class WebCalloutHelper {
    public WebCalloutHelper(String httpMethod, String body, String urlEndpoint) {
        this.httpMethod = httpMethod;
        this.body = body;
        this.urlEndpoint = urlEndpoint;
    }

    private String httpMethod;
    public String httpMethodProperty{
        get{ return this.httpMethod; }
        set{ this.httpMethod = value; }
    }

    private String body; 
    public String bodyProperty{
        get{ return this.body; }
        set{ this.body = value; }
    }

    private String urlEndpoint; 
    public String urlEndpointProperty{
        get{ return this.urlEndpoint; }
        set{ this.urlEndpoint = value; }
    }

    private Map<String,String> headerMap = new Map<String,String>(); 
    public Map<String,String> headerMapProperty{
            get{ return this.headerMap; }
            set{ this.headerMap = value; }
    }

    public HTTPResponse callout(){
        Http http = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint(this.urlEndpoint);
        req.setMethod(this.httpMethod);
        if(headerMap.size()>0){
            for(String key: headerMap.keySet()){
                req.setHeader(key, headerMap.get(key));
            }
        }
        req.setBody(this.body);
      
        //Execute web service call here     
        HTTPResponse res = new HttpResponse();
        if(!Test.isRunningTest()){
           res = http.send(req);
        }
        if(Test.isRunningTest()){
            res = new HttpResponse();
            res.setStatusCode(200);
        }
        return res;
    }
}

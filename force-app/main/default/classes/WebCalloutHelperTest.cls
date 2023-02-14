@isTest(SeeAllData = false)
private with sharing class WebCalloutHelperTest {
    @testSetup
    private static void makeData(){

    }
    @isTest 
    private static void test_callout_Success(){
        String url = 'test';
        String method = 'post';
        String body = 'test';
        WebCalloutHelper callout = new WebCalloutHelper(url, method, body);
        Map<String,String> headerMap = new Map<String,String>{'Content-Type' => 'application/json'};
        callout.urlEndpointProperty = url;
        callout.httpMethodProperty = url;
        callout.bodyProperty = body;
        callout.headerMapProperty = headerMap;

        url = callout.httpMethodProperty;
        method = callout.urlEndpointProperty;
        body = callout.bodyProperty;
        headerMap = callout.headerMapProperty;

        HTTPResponse res = callout.callout();
        System.assertEquals(200, res.getStatusCode());
    }
}

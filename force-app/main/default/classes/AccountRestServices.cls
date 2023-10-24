@RestResource(urlMapping='/Account/*')
global with sharing class AccountRestServices {
    
    //newly added POST method for creating account record
    @HttpPost
    global static ID createAccount() {
        RestRequest req = RestContext.request;

        RestResponse res = Restcontext.response;
        System.debug('Request Headers-->'+req.headers);
        System.debug('Request Method-->'+req.httpMethod);
        System.debug('Request Body-->'+req.requestBody.tostring());
        Account Acc = (Account) JSON.deserialize(req.requestBody.tostring(), Account.class);
        insert Acc;
        return Acc.id;
    }

    /*@HttpPatch
    global static void updateAccount() {
        RestRequest req = RestContext.request;

        RestResponse res = Restcontext.response;
        System.debug('req.requestURI == '+req.requestURI);
        String AccNumber = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        
        System.debug('Request Body-->'+req.requestBody.tostring());
        System.debug('AccNumber == '+AccNumber);

        Account accToUpdate = [select id, name from account where id =: AccNumber ];
        
    }*/
}
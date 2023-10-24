@RestResource(urlMapping='/Contact/*')
global with sharing class ContactRestServices {
    
    //newly added POST method for creating contact record
    @HttpPost
    global static ID createContact() {
        RestRequest req = RestContext.request;

        RestResponse res = Restcontext.response;
        System.debug('Request Body-->'+req.requestBody.tostring());
        Contact Con = (Contact) JSON.deserialize(req.requestBody.tostring(), Contact.class);
        insert Con;
        return Con.id;
    }
}
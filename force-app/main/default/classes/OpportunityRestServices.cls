@RestResource(urlMapping='/Opportunity/*')
global with sharing class OpportunityRestServices {
    
    //newly added POST method for creating account record
    @HttpPost
    global static ID createOpportunity() {
        RestRequest req = RestContext.request;

        RestResponse res = Restcontext.response;
        System.debug('Request Body-->'+req.requestBody.tostring());
        Opportunity Opp = (Opportunity) JSON.deserialize(req.requestBody.tostring(), Opportunity.class);
        insert Opp;
        return Opp.id;
    }
}
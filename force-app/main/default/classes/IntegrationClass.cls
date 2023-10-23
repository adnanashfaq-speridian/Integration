public without sharing class IntegrationClass {
    //Use your Client Id 
    String clientId ='3MVG9fe4g9fhX0E59dfIZ4Ri9oO_n.RP1X.8sz6v5lYl6B7KTifXSvxS.9NGzmZ3JqdanB_M7BPU6tKqzqqdi';
    //Use your Client Secret
    String clientsecret='610501FCA4A4A110A70D0FB0C7EBC35D9B6C65F3A8D70570F56945A430B7ACAF';
    //Your Destination org username
    //String username='dev.adnan22-u2gn@force.com';
    //Your Destination orgPassword+Security Token
    String accessTokenurl='https://speridiantechnologiesllc3.my.salesforce.com/services/oauth2/token';
    //String authurl='https://speridiantechnologiesllc3.lightning.force.com/services/oauth2/authorize';
    
    public class deserializeResponse {
        public String id;
        public String access_token;
    }
    
    public String ReturnAccessToken(IntegrationClass Acc){
        String reqbody = 'grant_type=client_credentials&client_id='+clientId+'&client_secret='+clientSecret;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setHeader('Content-Type', 'application/json');
        req.setBody(reqbody);
        req.setMethod('POST');
        
        req.setEndpoint(accessTokenurl);
        HttpResponse res=h.send(req);
        deserializeResponse resp1= (deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        return resp1.access_token;
    }
    
    @future(callout=true)
    public static void createAccount(String AccountId){
        IntegrationClass acc1= new IntegrationClass();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken+'###AP');
        if(accessToken!=null){
            //Change “ap4” in url to your Destination Org
            String endPoint='https://speridiantechnologiesllc3.my.salesforce.com/services/data/v32.0/sobjects/Account';  
            //String jsonstr='{"Name":"'+ Accname +'","Phone":"'+ Phone +'","Website":"'+ Website +'"}';
            string jsonstr = generateJSONFormatDataforAccount(AccountId);
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###a###');
            deserializeResponse deresp= (deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('### Deserialized Response ###'+deresp);
        }
    }
   
    public static string generateJSONFormatDataforAccount(Id AccountId){
        JSONGenerator jsGen = JSON.createGenerator(true);
        jsGen.writeStartObject();  
        
        for(Account acc : [SELECT Id, name, website, Phone FROM Account WHERE Id =: AccountId]){
            jsGen.writeFieldName('ConatctData');
            jsGen.writeStartObject();
            jsGen.writeStringField('Name', acc.Name);
            jsGen.writeStringField('website', acc.website);
            jsGen.writeStringField('Phone', acc.Phone);
            jsGen.writeEndObject();
        }
        
        jsGen.writeEndObject();
        String jsonData = jsGen.getAsString();
        System.debug('json format Data==> ' + jsonData);
        return jsonData;
    }
}
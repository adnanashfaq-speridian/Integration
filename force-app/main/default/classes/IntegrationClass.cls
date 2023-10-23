public without sharing class IntegrationClass {
    //FOR ORIGINAL ORG
    String clientId ='3MVG9fe4g9fhX0E59dfIZ4Ri9oO_n.RP1X.8sz6v5lYl6B7KTifXSvxS.9NGzmZ3JqdanB_M7BPU6tKqzqqdi';
    String clientsecret='610501FCA4A4A110A70D0FB0C7EBC35D9B6C65F3A8D70570F56945A430B7ACAF';
    String accessTokenurl='https://speridiantechnologiesllc3.my.salesforce.com/services/oauth2/token';

    //FOR SCRATCH ORG
    /*String clientId ='3MVG9WiZ4_mwZLgeL0hLQf_Ho8asfwaNJE.VteLhbiVbP937X0LY9IUojta29NzECMvNqzXgW5lOe3jtu5ud3';
    String clientsecret='4DB160B55742CBC791CC195DCAC3D3358699FF5F5E60F9B1E6CBDAA863E8EA18';
    String accessTokenurl='https://page-agility-6071-dev-ed.scratch.my.salesforce.com/services/oauth2/token';*/

    public class deserializeResponse {
        public String id;
        public String access_token;
    }
    
    public String ReturnAccessToken(IntegrationClass Acc){
        String reqbody = 'grant_type=client_credentials&client_id='+clientId+'&client_secret='+clientSecret;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(reqbody);
        req.setMethod('POST');
        
        req.setEndpoint(accessTokenurl);
        HttpResponse res=h.send(req);
        deserializeResponse resp1= (deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        return resp1.access_token;
    }
    
    public static string generateJSONFormatDataforAccount(Id AccountId){
        JSONGenerator jsGen = JSON.createGenerator(true);
      
        
        for(Account acc : [SELECT Id, name, website, Phone FROM Account WHERE Id =: AccountId]){
            
            jsGen.writeStartObject();
            jsGen.writeStringField('Name', acc.Name);
            jsGen.writeStringField('External_ID__c', acc.Id);
            jsGen.writeBooleanField('IsFromIntegration__c' , true); 
            if(acc.website != null){
                jsGen.writeStringField('website', acc.website);
            }
            if( acc.Phone != null){
                jsGen.writeStringField('Phone', acc.Phone);
            }
            jsGen.writeEndObject();
        }
        
     
        String jsonData = jsGen.getAsString();
        System.debug('json format Data==> ' + jsonData);
        return jsonData;
    }

    @future(callout=true)
    public static void createAccount(String AccountId){
        IntegrationClass acc1= new IntegrationClass();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken+'###AP');
        if(accessToken!=null){
            
            String endPoint='https://speridiantechnologiesllc3.my.salesforce.com/services/data/v32.0/sobjects/Account';  
            //String endPoint='https://page-agility-6071-dev-ed.scratch.my.salesforce.com/services/data/v32.0/sobjects/Account'; 
           
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

    @future(callout=true)
    public static void updateAccount(String AccountId, String externalID){
        IntegrationClass acc1= new IntegrationClass();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken + '###Access Token acc');
        if(accessToken!=null){
            
            String endPoint='https://speridiantechnologiesllc3.my.salesforce.com/services/data/v32.0/sobjects/Account/'+externalID;  
            //String endPoint='https://page-agility-6071-dev-ed.scratch.my.salesforce.com/services/data/v32.0/sobjects/Account/'+externalID; 
            
            string jsonstr = generateJSONFormatDataforAccount(AccountId);
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('PATCH');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###a###');
            deserializeResponse deresp= (deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('### Deserialized Response ###'+deresp);
        }
    }
}
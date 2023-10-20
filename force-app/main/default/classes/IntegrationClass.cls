public class IntegrationClass {
    //Use your Client Id 
    String clientId ='3MVG9fe4g9fhX0E59dfIZ4Ri9oO_n.RP1X.8sz6v5lYl6B7KTifXSvxS.9NGzmZ3JqdanB_M7BPU6tKqzqqdi';
    //Use your Client Secret
    String clientsecret='610501FCA4A4A110A70D0FB0C7EBC35D9B6C65F3A8D70570F56945A430B7ACAF';
    //Your Destination org username
    String username='dev.adnan22-u2gn@force.com';
    //Your Destination orgPassword+Security Token
    String password='Speridian@12346Cel800D5g00000L8SQV8885g00000A1i00wtQWqpNd0MjXUWxOCvETHeyU90zpAnn6yOl6xRBDKwMbMLIZ3KoQ8YiPiLoGinPzGavt5bMO';
    String accesstoken_url='https://speridiantechnologiesllc3.lightning.force.com/services/oauth2/token';
    String authurl='https://speridiantechnologiesllc3.lightning.force.com/services/oauth2/authorize';
    
    public class deserializeResponse {
        public String id;
        public String access_token;
    }
    
    public String ReturnAccessToken(IntegrationClass Acc){
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        // String reqbody='{“grant_type”:”password”,”client_id”:clientId,”client_secret”:clientSecret,"username":username,"password":password}';
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        //Change “ap4” in url to your Destination Org Instance
        req.setEndpoint('https://speridiantechnologiesllc3.lightning.force.com/services/oauth2/token');
        HttpResponse res=h.send(req);
        //System.debug(res.getBody()+'By-AP-1986-Response');
        deserializeResponse resp1= (deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        //System.debug(resp1+'By-AP-deserializeresponse');
        return resp1.access_token;
    }
    
    @future(callout=true)
    public static void createAccount(String Accname, String Phone, String Website){
        IntegrationClass acc1= new IntegrationClass();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken+'###AP');
        if(accessToken!=null){
            //Change “ap4” in url to your Destination Org
            String endPoint='https://speridiantechnologiesllc3.lightning.force.com/services/data/v32.0/sobjects/Account';  
            String jsonstr='{"Name":"'+ Accname +'","Phone":"'+ Phone +'","Website":"'+ Website +'"}';
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###Akash###');
            deserializeResponse deresp= (deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('### Deserialized Response ###'+deresp);
        }
    }
}
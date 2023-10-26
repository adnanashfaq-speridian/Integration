public class MetadataService{
    
    @AuraEnabled
    public static void upsertMetadata(string selectedFields){
        try {
            system.debug('Enter --- '+selectedFields);
            CreateUpdateMetadataUtils.createUpdateMetadata('LWC_Lookup_Field__mdt.ADMIN','Admin',selectedFields);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    /*@auraenabled
    public static void handleUpsert(String fullName, String label, string fieldWithValues){
        //Deserialize all fields information and create JSON object
        List<Object> results = (List<Object>) JSON.deserializeUntyped(fieldWithValues);
        Map<String, Object> fieldWithValuesMap=new Map<String, Object>();
        for (Object obj: results) {
            fieldWithValuesMap.putAll((Map<String, Object>)obj);
        }
        
        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();        
        customMetadata.fullName = fullName+'.'+label;        
        customMetadata.label = label;        
        for (String key: fieldWithValuesMap.keySet()) {            
            Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();            
            customField.field = key;            
            customField.value = fieldWithValuesMap.get(key);            
            customMetadata.values.add(customField);            
        }
       	Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();        
        mdContainer.addMetadata(customMetadata);        
        MetadataServiceCallback callback = new MetadataServiceCallback();   
        Id jobId = Test.isRunningTest() ? 'a0cM00000043ST4' : Metadata.Operations.enqueueDeployment(mdContainer, callback);
        //system.debug('jobId:'+jobId);
    }*/
}
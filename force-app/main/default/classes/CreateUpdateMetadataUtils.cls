public class CreateUpdateMetadataUtils implements Metadata.DeployCallback {
    
    public void handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug(' success : '+ result);
        } else {
            System.debug(' fail : '+ result);
        }
    }
    
    public static void createUpdateMetadata(String fullName, String label, string valueOfField){
       
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = fullName;
        customMetadata.label = label;
        
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = 'Account_Selected_Fields__c';
        
        string temp = valueOfField.replaceAll('"','');        
        customField.value = temp;
        system.debug('customField.value == '+customField.value);

        customMetadata.values.add(customField);
                      
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        system.debug('mdContainer == '+mdContainer);
        CreateUpdateMetadataUtils callback = new CreateUpdateMetadataUtils();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
}
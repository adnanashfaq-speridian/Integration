Trigger AccountTrigger on Account (after insert , after update){
    
    if(trigger.isInsert){
        for(Account a:Trigger.new) {
            if(a.External_ID__c == null){
                IntegrationClass.createAccount(a.id); 
            }
        }   
    } 

    if(trigger.isUpdate){
        for(Account a:Trigger.new) {
            if(a.IsFromIntegration__c == false && trigger.oldmap.get(a.id).IsFromIntegration__c == true){
                IntegrationClass.updateAccount(a.id); 
            }
        }   
    }   
}
Trigger ContactTrigger on Contact (after insert , after update){
    
    if(trigger.isInsert){
        for(Contact a:Trigger.new) {
            if(a.External_ID__c == null){
                ContactIntegration.createContact(a.id); 
            }
        }  
    }
    
    if(trigger.isUpdate){
        for(Contact a:Trigger.new) {
            if(a.IsFromIntegration__c == false && trigger.oldmap.get(a.id).IsFromIntegration__c == true){
                ContactIntegration.updateContact(a.id);
            } 
        }  
    }
}
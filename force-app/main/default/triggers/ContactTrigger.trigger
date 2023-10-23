Trigger ContactTrigger on Contact (after insert , after update){
    
    if(trigger.isInsert){
        for(Contact a:Trigger.new) {
            ContactIntegration.createContact(a.id); 
        }  
    }
    
    if(trigger.isUpdate){
        for(Contact a:Trigger.new) {
            ContactIntegration.updateContact(a.id); 
        }  
    }
}
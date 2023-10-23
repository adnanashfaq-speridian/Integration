Trigger ContactTrigger on Contact (after insert , before update , after update){
    
    if(trigger.isInsert){
        for(Contact a:Trigger.new) {
            if(a.External_ID__c == null){
                ContactIntegration.createContact(a.id); 
            }
        }  
    }
    
    if(trigger.isUpdate && trigger.isBefore){
        for(Contact a:Trigger.new) {
            if(a.IsFromIntegration__c == true ){
                a.IsFromIntegration__c = false;
                a.Integration_Action__c = 'NO';
            }
            else{
                a.Integration_Action__c = 'YES';
            }
        }  
    }

    if(trigger.isUpdate && trigger.isAfter){
        for(Contact a:Trigger.new) {
            if(a.Integration_Action__c == 'YES'){
                ContactIntegration.updateContact(a.id); 
            }
        }   
    }   
}
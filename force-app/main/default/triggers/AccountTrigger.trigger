
Trigger AccountTrigger on Account (after insert , after update){
    
    if(trigger.isInsert){
        for(Account a:Trigger.new) {
            IntegrationClass.createAccount(a.id); 
        }   
    } 
    if(trigger.isUpdate){
        for(Account a:Trigger.new) {
            IntegrationClass.updateAccount(a.id); 
        }   
    }
   
}
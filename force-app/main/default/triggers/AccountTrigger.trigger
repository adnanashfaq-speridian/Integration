Trigger AccountTrigger on Account (after insert , before update , after update){
    
    if(trigger.isInsert){
        for(Account a:Trigger.new) {
            if(a.External_ID__c == null){
                IntegrationClass.createAccount(a.id); 
            }
        }   
    } 

    if(trigger.isUpdate && trigger.isBefore){
        for(Account a:Trigger.new) {
            system.debug('a.IsFromIntegration__c BEFORE ' + a.IsFromIntegration__c);
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
        for(Account a:Trigger.new) {
            system.debug('a.IsFromIntegration__c AFTER ' + a.IsFromIntegration__c);
            if(a.Integration_Action__c == 'YES'){
                IntegrationClass.updateAccount(a.id, a.External_ID__c); 
            }
        }   
    }   
}
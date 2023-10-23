Trigger OpportunityTrigger on Opportunity (after insert , before update , after update){
    
    if(trigger.isInsert){
        for(Opportunity opp : Trigger.new) {
            if(opp.External_ID__c == null){
                OpportunityIntegration.createOpportunity(opp.id); 
            }           
        }
    }

    if(trigger.isUpdate && trigger.isBefore){
        for(Opportunity a:Trigger.new) {
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
        for(Opportunity a:Trigger.new) {
            if(a.Integration_Action__c == 'YES'){
                OpportunityIntegration.updateOpportunity(a.id, a.External_ID__c); 
            }
        }   
    }   
}
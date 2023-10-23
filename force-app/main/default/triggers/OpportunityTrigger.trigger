Trigger OpportunityTrigger on Opportunity (after insert , after update){
    
    if(trigger.isInsert){
        for(Opportunity opp : Trigger.new) {
            if(opp.External_ID__c == null){
                OpportunityIntegration.createOpportunity(opp.id); 
            }           
        }
    }

    if(trigger.isUpdate){
        for(Opportunity opp : Trigger.new) {
            if(opp.IsFromIntegration__c == false && trigger.oldmap.get(opp.id).IsFromIntegration__c == true){
                OpportunityIntegration.updateOpportunity(opp.id); 
            }
        }  
    }
}
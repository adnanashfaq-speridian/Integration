Trigger OpportunityTrigger on Opportunity (after insert , after update){
    
    if(trigger.isInsert){
        for(Opportunity a:Trigger.new) {
        OpportunityIntegration.createOpportunity(a.id); 
        }
    }

    if(trigger.isUpdate){
        for(Opportunity a:Trigger.new) {
            OpportunityIntegration.updateOpportunity(a.id); 
        }  
    }
}
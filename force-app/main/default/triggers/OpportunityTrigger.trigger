Trigger OpportunityTrigger on Opportunity (after insert){
    for(Opportunity a:Trigger.new) {
        OpportunityIntegration.createOpportunity(a.id); 
    }    
}
Trigger ContactTrigger on Contact (after insert){
    for(Contact a:Trigger.new) {
        ContactIntegration.createContact(a.id); 
    }    
}
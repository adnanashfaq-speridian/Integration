
Trigger AccountTrigger on Account (after insert){
    for(Account a:Trigger.new) {
        IntegrationClass.createAccount(a.name, a.Phone, a.Website); 
    }    
}
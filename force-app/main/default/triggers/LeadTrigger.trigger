trigger LeadTrigger on Lead (before insert, before update) {
    for(lead Id : trigger.new){
        if(Id.leadSource == null){
          Id.leadSource = 'Other';   
        }
        if(Id.Industry == null){
            Id.addError('You can not insert or update a lead if Industry is empty!...');
        }
    }
}
trigger OpportunityTrigger on Opportunity (before insert) {
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityTriggerHandler.handleAfterUpdate(trigger.new);
    }
    if(trigger.isAfter && trigger.isInsert){
        OpportunityTriggerHandler.handleAfterInsert(trigger.new);
    }
}
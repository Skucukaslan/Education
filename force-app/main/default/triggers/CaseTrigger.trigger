trigger CaseTrigger on Case (after insert) {
    for(Case cs : Trigger.new){
        SalesforceConnect.sendCaseToSFORGB(cs.Subject, cs.Status, cs.Origin, cs.Priority);
    }
}
public class OpportunityTriggerHandler {
    
    public static void handleAfterInsert(List<Opportunity> opportunityList){
        //to fetch data from related Center record we need a SOQL in which we query related Center fields
        List<Opportunity> oppList = [SELECT ID, Center__c,
                               Center__r.Asset_Manager__r.id, Center__r.Leasing_Admin__r.id, Center__r.Leasing_Analyst__r.id
                               FROM Opportunity 
                               WHERE ID IN :opportunityList]; // we use Trigger.newMap.keySet() or trigger.new to filter opportunities because we need only opportunities which fire my trigger
         
        
        //in below for each loop, we assign team members but we fetched team members` ids from related Center fields.
        for(Opportunity opp:oppList){
            if(opp.Center__c!=null){
                opp.Asset_Manager__c=opp.Center__r.Asset_Manager__r.id;
                opp.Leasing_Admin__c=opp.Center__r.Leasing_Admin__r.id;
                opp.Leasing_Analyst__c=opp.Center__r.Leasing_Analyst__r.id;
            }
        }
        Database.update(oppList);
    }
    
    
    /*bad pratice
for(Opportunity opp:oppList){
Center__c cntr=[SELECT ID, Name, Asset_Manager__c, Leasing_Admin__c, Leasing_Analyst__c
FROM Center__c WHERE ID=:opp.Center__c];
opp.Asset_Manager__c=cntr.Asset_Manager__c;
opp.Leasing_Admin__c=cntr.Leasing_Admin__c;
opp.Leasing_Analyst__c=cntr.Leasing_Analyst__c;
}
} */
    
    public static void handleAfterUpdate(List<Opportunity> oppList){
        List<Contract> cntrList=new List<Contract>();
        for(Opportunity opp : oppList){
            if(opp.StageName == 'Closed Won'){
                Contract newContr = new Contract(
                    AccountId=opp.AccountId,
                    Center__c=opp.Center__c,
                    Space__c=opp.Space__c,
                    Contact_Name__c=opp.Contact_Name__c,
                    Type__c=opp.Type,
                    StartDate=opp.CloseDate,
                    Asset_Manager__c=opp.Asset_Manager__c,
                    Leasing_Admin__c=opp.Leasing_Admin__c,
                    Leasing_Analyst__c=opp.Leasing_Analyst__c,
                    OwnerId=opp.OwnerId,
                    Status='Draft'
                );
                cntrList.add(newContr);
            }
        }
        Database.insert(cntrList);
    }
}
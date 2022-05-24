public class UserDeactivationBatch implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        Integer daysNotLogin = Integer.valueOf(System.Label.DaysNotLogin);
        Datetime beforeCertainDate = Date.today()-daysNotLogin;
        String formatedCertainDate = beforeCertainDate.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        String query = 'SELECT Id, Name, IsActive, LastLoginDate FROM User WHERE IsActive = True AND LastLoginDate <=' + formatedCertainDate;
        //String query = 'SELECT Id, Name, IsActive, LastLoginDate FROM User WHERE IsActive = True AND LastLoginDate <= LAST_N_DAYS:'+ daysNotLogin
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<User> scope){
        
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
}
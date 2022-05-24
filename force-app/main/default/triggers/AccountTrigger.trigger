trigger AccountTrigger on Account (before insert, before update, before delete, after insert,after update,after delete,after undelete ) {
   // First way of seperation Trigger Logics
    if(trigger.isBefore){
        if(trigger.isInsert){
            for(account acc: trigger.new){
    acc.Name= acc.Name+'TechProTest';
}
        }
        if(trigger.isUpdate){
          
        }
        if(trigger.isDelete){
           
        }
    }
    if(trigger.isAfter){
        if(trigger.isInsert){
             
             }
            
        }
        if(trigger.isUpdate){
            
        }
        if(trigger.isDelete){
           
        }
        if(trigger.isUndelete){
            
        }
      }
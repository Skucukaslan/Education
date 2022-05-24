public class SalesforceConnect {
    public static void getCasesFromSFORGB(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFORGNC/services/apexrest/Cases');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            List<Object> results= (List<Object>)JSON.deserializeUntyped(response.getBody());
            List<Case> caseList=new List<Case>();
            for(Object obj : results){
                Map<String,Object> caseProps = (Map<String,Object>)obj;
                System.debug('CaseNumber: '+caseProps.get('CaseNumber')+' - Subject: '+caseProps.get('Subject'));
                Case tempCase=new Case();
                tempCase.Subject=(String)caseProps.get('Subject');
                tempCase.Status=(String)caseProps.get('Status');
                tempCase.Origin=(String)caseProps.get('Origin');
                tempCase.Priority=(String)caseProps.get('Priority');
                caseList.add(tempCase);
            }
            Database.insert(caseList,false);
            //System.debug('response: '+ response.getBody());
        }else{
            System.debug('error: '+response.getStatusCode());
        }
    }
    @future(Callout=true)
    public static void sendCaseToSFORGB(String subject, String status, String origin, String priority){
        String body = '{"subject" : "'+subject+'", "status" : "'+status+'", "origin" : "'+origin+'", "priority" : "'+priority+'"}';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFORGNC/services/apexrest/Cases');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        request.setBody(body);
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 201 || response.getStatusCode() == 200){
            System.debug('result: '+ response.getBody());
        }else{
            System.debug('error: '+response.getStatusCode());
        }
    }
}
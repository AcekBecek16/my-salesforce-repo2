public class BASTController {
    public Project__c project {get;set;}
    public List<OpportunityLineItem>opplineitem{get;set;}
    public User user{get;set;}
    String resultIDs;

    public BASTController(ApexPages.StandardController stdController){
        Id ProjectID = ((Project__c)stdController.getRecord()).Id;
        loadproject(ProjectID);
        loadoptylineitem(ProjectID);
        loaduserinfo();
        
    }

    public void loadproject(String ProjectID){
        this.project = [Select Id, Date_of_Created_BAST__c, Name, Project_Account__r.Name, Project_Contact__r.FirstName,
                        Project_Contact__r.LastName, Project_Account__r.BillingStreet,
                        Project_Account__r.BillingState, Project_Account__r.BillingCity, Signi__r.Signature__c, Signi__r.Name, Signi__r.Role__c,
                        Project_Account__r.BillingPostalCode, Project_Account__r.BillingCountry, Project_Contact__r.Title,
                        BAST_No__c From Project__c Where Id=:ProjectID];
    }
    
    public void loadoptylineitem(String ProjectID){
        Map<String, list<string>> optyId = new Map<String, list<string>>();
        for (Project__c project : [Select Id, Opportunity__c From Project__c where Id=:ProjectID]) {
            resultIDs = project.Opportunity__c ;
        }
        this.opplineitem = [Select Id, Name, Product2.Name, Quantity From OpportunityLineItem Where OpportunityId=:resultIDs];
    }

    public void loaduserinfo(){
        String UserId = UserInfo.getUserId();
        this.user = [Select FirstName, LastName,Title, Signature__c From User Where Id=:UserId];

    }
}
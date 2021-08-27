@isTest
public  class GithubControllerTest 
{
    @TestSetup
    static void GithubTest()
    {
        String GIT_URL = 'https://api.github.com/repos/Bramhanath6/sample-project/commits/32db56cf3424a642483b5903dc99bb9f2ebecfe3';
        Integer gitUrlPos = -1;
        Account_Training__c atc = new Account_Training__c
         (name='Test Account Training');
        insert(atc);
        Contact cont = new Contact 
         (Firstname= 'Mahi', 
          Lastname ='Patel',
          Email= 'Test@havefunsolving.com');
        insert(cont);
        Training_Participant__c tpl =new Training_Participant__c
         (name ='Testing', 
          Contact__c= cont.id,
          Github_Public_Repo__c = 'https://github.com/Bramhanath6/sample-project', 
          Account_Training__c = atc.id);
        insert(tpl);
    }
    @isTest static void getCommitstest()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class,new CalloutMock());
        Training_Participant__c tpr = [select id from  Training_Participant__c where name='Testing'];
        GithubController.getCommits(tpr.id);
        Test.stopTest(); 
    }
    @isTest static void getCodetest()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class,new CalloutMock());
        Training_Participant__c tpr = [select id from  Training_Participant__c where name='Testing'];
        GithubController.getCode(tpr.id);
        Test.stopTest(); 
    }
    @isTest static void getCommitTest()
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class,new CalloutMock());
        Training_Participant__c tpr = [select id from  Training_Participant__c where name='Testing'];
        GithubController.getCommit(tpr.id);
        Test.stopTest(); 
    }
}
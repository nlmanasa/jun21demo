public with sharing class GithubController {
    @AuraEnabled
    public static List<Object> getCommits(String recordId) {
        System.debug('>>> In getCommits. Participant ID: ' + recordId);
        List<Object> commits;
        String GIT_URL = 'https://github.com';
        Integer gitUrlPos = -1; 

        Training_Participant__c tp = [select Github_Public_Repo__c 
                                        from Training_Participant__c
                                       where Id = :recordId];

        if (tp != null && String.isNotBlank(tp.Github_Public_Repo__c)) {
            gitUrlPos = tp.Github_Public_Repo__c.indexOf(GIT_URL);
        }

        if (gitURLPos == 0) {
            String commitsURL = 'callout:Github/repos' + 
                                tp.Github_Public_Repo__c.substring(GIT_URL.length()) + 
                                '/commits';
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(commitsURL);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                commits = (List<Object>)JSON.deserializeUntyped(res.getBody());
            }
        }
        return commits;
    } 

    @AuraEnabled
    public static String getCode(String codeURL) {
        System.debug('Came into getCode');
        HttpRequest req = new HttpRequest();
        req.setEndpoint(codeURL);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if (res.getStatusCode() == 302) {
            String loc = res.getHeader('Location');
            System.debug('>>>> redirected to: ' + loc);
            req = new HttpRequest();
            req.setEndpoint(loc);
            req.setMethod('GET');
            http = new Http();
            res = http.send(req);
        }
        return (res.getBody());
    } 

    @AuraEnabled
    public static Object getCommit(String commitUrl) {
        Object gitCommit;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(commitUrl);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            gitCommit = (Object)JSON.deserializeUntyped(res.getBody());
        }
        
        return gitCommit;
    } 
}
public with sharing class searchContactlwc {
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContactNameMethod (String contName, String contEmail){
        String keyNameString = '%' +  contName + '%';
        return [Select Id, FirstName, LastName, Email from Contact Where Name like:keyNameString];
     }   
}

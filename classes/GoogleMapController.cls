public with sharing class GoogleMapController
{
public List<Address__c> addList{get;set;}

public GoogleMapController()
{
  addList=[select name,City__c,Street__c,Zip__c,State__c from Address__c];
  


}

public List<Address__c> getAddress()
{
  return addList;

}

}
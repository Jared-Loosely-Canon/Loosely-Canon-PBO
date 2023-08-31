/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 04-16-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class ConnectWrappers {
    public class MessageWrapper{
        public String Body {get;set;}
        public String To_Number {get;set;}
        public String From_Number {get;set;}
        public String Salesforce_Record_Id {get;set;}
        public String Salesforce_Lead_Id {get;set;}
        public String Salesforce_Contact_Id {get;set;}
        public String Salesforce_Person_Account_Id {get;set;}
        public String Salesforce_User_Id {get;set;}
        public String Salesforce_Org_Id {get;set;}
        public String First_Name {get;set;}
        public String Last_Name {get;set;}
        public String Email {get;set;}
        public String Mobile_Phone {get;set;}
    }

    public class createContactResponseWrapper {

        public String id {get;set;}
        public String First_Name {get;set;}
        public String Last_Name {get;set;}
        public String Organization_Id {get;set;}
        public String Salesforce_Lead_Id {get;set;}
        public String Salesforce_Contact_Id {get;set;}
        public String Salesforce_Person_Account_Id {get;set;}


        public List<createContactResponseWrapper> parse(String json) {
            return (List<createContactResponseWrapper>) System.JSON.deserialize(json, List<createContactResponseWrapper>.class);
        }
    }

    public class callListMemberWrapper{
		public String call_list_Id {get;set;}	//8
		public String salesforce_contact_id {get;set;}	//3806
        public String connect_Id {get;set;}
        public String id {get;set;}
        public String Salesforce_Id {get;set;}
        public Boolean isDelete {get;set;}
        public String target_owner {get;set;}

	    public callListMemberWrapper parse(String json){
            return (callListMemberWrapper) System.JSON.deserialize(json, callListMemberWrapper.class);
        }
        public callListMemberWrapper[] parseList(String json){
            return (callListMemberWrapper[]) System.JSON.deserialize(json, List<callListMemberWrapper>.class);
        }
	}

    public class callListWrapper{
        public String id {get;set;}	//8
        public String Name {get;set;}	//3806
        public String Salesforce_Id {get;set;}

        public callListWrapper parse(String json){
            return (callListWrapper) System.JSON.deserialize(json, callListWrapper.class);
        }
        public callListWrapper[] parseList(String json){
            return (callListWrapper[]) System.JSON.deserialize(json, List<callListWrapper>.class);
        }
    }
}
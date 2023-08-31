/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 03-13-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class PhoneHelper {
    public PhoneHelper(String objectName) {
        this.objectName = objectName;
        this.setup();
    }

    private String objectName;

    private Map<String, Schema.SObjectField> fieldsMap;

    public List<String> phoneFields = new List<String>();
    public Set<String> phoneLabels = new Set<String>();
    public Set<String> phoneApiNames = new Set<String>();

    public Map<String, String> labelApiMap = new Map<String, String>();
    public Map<String, String> apiLabelMap = new Map<String, String>();

    public String[] phoneApiNameList = new List<String>();


    public void setup() {
        if(this.objectName == 'Lead'){
            fieldsMap = Lead.SObjectType.getDescribe().fields.getMap();
        } else if (this.objectName == 'Contact') {
            fieldsMap = Contact.SObjectType.getDescribe().fields.getMap();
        } else if(this.objectName == 'Account'){
            fieldsMap = Account.SObjectType.getDescribe().fields.getMap();
        }
        for (String fieldName : fieldsMap.keySet()) {
            Schema.SObjectField field = fieldsMap.get(fieldName);
            Schema.DescribeFieldResult fieldDesc = field.getDescribe();

            if (fieldDesc.getType() == Schema.DisplayType.Phone) {
                phoneLabels.add(fieldDesc.getLabel());
                phoneApiNames.add(fieldDesc.getName());

                labelApiMap.put(fieldDesc.getLabel(), fieldDesc.getName());
                apiLabelMap.put(fieldDesc.getName(), fieldDesc.getLabel());
            }
        }
        phoneApiNameList.addAll(phoneApiNames);
    }

    public class PhoneWrapper {
        public String Phone_Number;
        public String Type;
        public String Salesforce_Contact_Id;
        public final String Integration = 'Salesforce';
    }
}
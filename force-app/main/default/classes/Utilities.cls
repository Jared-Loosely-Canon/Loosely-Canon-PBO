/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 05-26-2023
 * @last modified by  : Jared Simpson
**/
public with sharing class Utilities {
    public static Set<String> getFields(Schema.DescribeSObjectResult describeResult) {
        Set<String> fields = new Set<String>();
        List<Schema.SObjectField> sObjectFields = describeResult.fields.getMap().values();
        for (Schema.SObjectField field : sObjectFields) {
            if(field.getDescribe().isAccessible())
            fields.add(field.getDescribe().getName());
        }
        return fields;
    }

    public static String queryAllFields (Schema.DescribeSObjectResult describeResult, String name) {
        Set<String> fields = getFields(describeResult);
        String query = 'SELECT ';
        for (String field : fields) {
            query += field + ', ';
        }
        query = query.removeEnd(', ');
        // query += ' FROM ' + name;

        return query;
    }

    public static String queryWhereClause(String custom){
        String whereClause = ' WHERE ' + custom;
        return whereClause;
    }
}
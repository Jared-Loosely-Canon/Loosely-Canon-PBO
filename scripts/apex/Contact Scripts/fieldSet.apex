Map<String, Schema.FieldSet> FsMap = Schema.SObjectType.Lead.fieldSets.getMap();
System.debug('FsMap: ' + FsMap);

List<Schema.FieldSetMember> fields = 
    Schema.SObjectType.Lead.fieldSets.getMap().get('Phone_Fields').getFields();
System.debug('fields: ' + fields);

for (Schema.FieldSetMember field : fields) {
    System.debug('field: ' + field.getSObjectField());
}
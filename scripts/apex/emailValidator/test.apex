Lead[] leads = [SELECT Id, Email FROM Lead WHERE Email != null];
SObject[] obj = new List<SObject>();
for(Lead l : leads) {
    SObject o = (SObject) l;
    obj.add(o);
}
System.debug('obj: ' + obj);
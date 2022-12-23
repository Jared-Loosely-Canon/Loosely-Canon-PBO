Map<Id, Scheduled_Text__c> scheduledTexts = new Map<Id, Scheduled_Text__c>([SELECT
    Id,
    Cadence__c,
    OwnerId,
    Name,
    Text_Template__c,
    Cadence__r.Campaign__c,
    Cadence__r.Contact__c,
    Cadence__r.Lead__c,
    Cadence__r.Opportunity__c
FROM
    Scheduled_Text__c]);
Set<Id> textTemplateIds = new Set<Id>();
for(Scheduled_Text__c st: scheduledTexts.values()) {
    textTemplateIds.add(st.Text_Template__c);
}
Map<Id, Text_Template__c> textTemplates = new Map<Id, Text_Template__c>([SELECT Id, Name, Text_Message__c FROM Text_Template__c WHERE Id IN :textTemplateIds]);
MergeTextTemplateService mttService = new MergeTextTemplateService(scheduledTexts, textTemplates);
Integer days = 30;
Integer i = 0;

canon_app__Task_Template_List__c taskTemplateList = new canon_app__Task_Template_List__c();
taskTemplateList.Name = 'Engaging Lead Task Template List';

canon_app__Text_Template_List__c textTemplateList = new canon_app__Text_Template_List__c();
textTemplateList.Name = 'Engaging Lead Text Template List';

canon_app__Email_Template_List__c emailTemplateList = new canon_app__Email_Template_List__c();
emailTemplateList.Name = 'Engaging Lead Email Template List';


insert taskTemplateList;
insert textTemplateList;
insert emailTemplateList;


canon_app__Cadence_Template__c[] newTemplates = new List<canon_app__Cadence_Template__c>();
canon_app__Cadence_Template__c newTemplate = new canon_app__Cadence_Template__c();
newTemplate.Name = 'Engaging Lead Cadence Template';
newTemplate.canon_app__Email_Template_List__c = emailTemplateList.Id;
newTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
newTemplate.canon_app__Text_Template_List__c = textTemplateList.Id;
// newTemplate.canon_app__Next_Cadence_Template__c = 
newTemplates.add(newTemplate);

insert newTemplates;

// canon_app__Task_Template_List__c taskTemplateList = [SELECT Id FROM canon_app__Task_Template_List__c WHERE Name = 'Engaging Lead Task Template List' LIMIT 1];
canon_app__Task_Template__c[] taskTemplates = new List<canon_app__Task_Template__c>();
canon_app__Text_Template__c[] textTemplates = new List<canon_app__Text_Template__c>();
canon_app__Email_Scheduled_Template__c[] emailTemplates = new List<canon_app__Email_Scheduled_Template__c>();

while (i < days) {
    canon_app__Task_Template__c taskTemplate = new canon_app__Task_Template__c();
    taskTemplate.Name = 'Engaging Lead Task Template ' + i;
    taskTemplate.canon_app__Task_Template_List__c = taskTemplateList.id;
    taskTemplate.canon_app__Subject__c = 'Engaging Lead Day ' + i;
    Time timeOrg =  Time.newInstance(10, 0, 0, 0);
    taskTemplate.canon_app__Due_Time__c = timeOrg;
    taskTemplate.canon_app__Days_Until_Due__c = i;
    taskTemplate.canon_app__Description__c = 'Check if you should engage this lead. If so, send a text, email, and/or call.';
    if(i < 7){
        i+=2;
    } else if (i < 14) {
        i+=3;
    } else{
        i+=4;
    }
    taskTemplates.add(taskTemplate);
}

insert taskTemplates;
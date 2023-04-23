Integer days = 5;
Integer daysHardHit = 3;
Integer i = 0;

canon_app__Task_Template_List__c taskTemplateList = new canon_app__Task_Template_List__c();
taskTemplateList.Name = 'New Lead Task Template List';

canon_app__Text_Template_List__c textTemplateList = new canon_app__Text_Template_List__c();
textTemplateList.Name = 'New Lead Text Template List';

canon_app__Email_Template_List__c emailTemplateList = new canon_app__Email_Template_List__c();
emailTemplateList.Name = 'New Lead Email Template List';


insert taskTemplateList;
insert textTemplateList;
insert emailTemplateList;


canon_app__Cadence_Template__c[] newTemplates = new List<canon_app__Cadence_Template__c>();
canon_app__Cadence_Template__c newTemplate = new canon_app__Cadence_Template__c();
newTemplate.Name = 'New Lead Cadence Template';
newTemplate.canon_app__Email_Template_List__c = emailTemplateList.Id;
newTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
newTemplate.canon_app__Text_Template_List__c = textTemplateList.Id;
// newTemplate.canon_app__Next_Cadence_Template__c = 
newTemplates.add(newTemplate);

insert newTemplates;

canon_app__Task_Template__c[] taskTemplates = new List<canon_app__Task_Template__c>();
canon_app__Text_Template__c[] textTemplates = new List<canon_app__Text_Template__c>();
canon_app__Email_Scheduled_Template__c[] emailTemplates = new List<canon_app__Email_Scheduled_Template__c>();

while (i < daysHardHit) {
    canon_app__Task_Template__c taskTemplate = new canon_app__Task_Template__c();
    taskTemplate.Name = 'New Lead Task Template ' + i;
    taskTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
    taskTemplate.canon_app__Subject__c = 'Call New Lead Day ' + i + ' Morning';
    Time timeOrg =  Time.newInstance(9, 0, 0, 0);
    taskTemplate.canon_app__Due_Time__c = timeOrg;
    taskTemplate.canon_app__Days_Until_Due__c = i;
    taskTemplate.canon_app__Description__c = 'Make Contact with this brand new lead ASAP! Call Twice, leave a voicemail, and send a text message.';

    taskTemplates.add(taskTemplate);

    taskTemplate = new canon_app__Task_Template__c();
    taskTemplate.Name = 'New Lead Task Template ' + i;
    taskTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
    taskTemplate.canon_app__Subject__c = 'Call New Lead Day ' + i + ' Midday';
    timeOrg =  Time.newInstance(11, 0, 0, 0);
    taskTemplate.canon_app__Due_Time__c = timeOrg;
    taskTemplate.canon_app__Days_Until_Due__c = i;
    taskTemplate.canon_app__Description__c = 'Make Contact with this brand new lead ASAP! Call Twice';

    taskTemplates.add(taskTemplate);

    taskTemplate = new canon_app__Task_Template__c();
    taskTemplate.Name = 'New Lead Task Template ' + i;
    taskTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
    taskTemplate.canon_app__Subject__c = 'Call New Lead Day ' + i + ' Afternoon';
    timeOrg =  Time.newInstance(14, 0, 0, 0);
    taskTemplate.canon_app__Due_Time__c = timeOrg;
    taskTemplate.canon_app__Days_Until_Due__c = i;
    taskTemplate.canon_app__Description__c = 'Make Contact with this brand new lead ASAP! Call Twice, send a text message, and send an email.';

    taskTemplates.add(taskTemplate);
    i++;
}

while (i < days) {
    canon_app__Task_Template__c taskTemplate = new canon_app__Task_Template__c();
    taskTemplate.Name = 'New Lead Task Template ' + i;
    taskTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
    taskTemplate.canon_app__Subject__c = 'Call New Lead Day ' + i + ' Morning';
    Time timeOrg =  Time.newInstance(10, 0, 0, 0);
    taskTemplate.canon_app__Due_Time__c = timeOrg;
    taskTemplate.canon_app__Days_Until_Due__c = i;
    taskTemplate.canon_app__Description__c = 'Make Contact with this brand new lead ASAP! Call Once, and send a text message saying you will try again later today or if there is a good time to talk.';

    taskTemplates.add(taskTemplate);

    taskTemplate = new canon_app__Task_Template__c();
    taskTemplate.Name = 'New Lead Task Template ' + i;
    taskTemplate.canon_app__Task_Template_List__c = taskTemplateList.Id;
    taskTemplate.canon_app__Subject__c = 'Call New Lead Day ' + i + ' Midday';
    timeOrg =  Time.newInstance(15, 0, 0, 0);
    taskTemplate.canon_app__Due_Time__c = timeOrg;
    taskTemplate.canon_app__Days_Until_Due__c = i;
    taskTemplate.canon_app__Description__c = 'Make Contact with this brand new lead ASAP! Call Twice';

    taskTemplates.add(taskTemplate);
    i++;
}

insert taskTemplates;
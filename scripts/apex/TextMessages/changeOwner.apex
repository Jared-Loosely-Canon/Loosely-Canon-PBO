canon_app__Text_Message__c[] texts = [SELECT Id, OwnerId FROM canon_app__Text_Message__c];
for(canon_app__Text_Message__c text : texts) {
    text.OwnerId = UserInfo.getUserId();
}
update texts;
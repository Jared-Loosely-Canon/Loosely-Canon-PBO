canon_app__Canon_Log__c[] logs = [SELECT
    Id
FROM
    canon_app__Canon_Log__c];

delete logs;
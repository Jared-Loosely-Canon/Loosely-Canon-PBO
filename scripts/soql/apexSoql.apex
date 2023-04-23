Datetime sync = Datetime.now();
canon_app__Scheduled_Text__c[] scheduledTexts = [SELECT canon_app__Cadence__c, canon_app__Cadence__r.canon_app__Campaign__c, canon_app__Cadence__r.canon_app__Campaign__r.OwnerId, 
            canon_app__Cadence__r.OwnerId, 
            canon_app__Cadence__r.canon_app__Contact__c, canon_app__Cadence__r.canon_app__Contact__r.OwnerId, canon_app__Cadence__r.canon_app__Account__r.OwnerId, canon_app__Cadence__r.canon_app__Account__c,
            canon_app__Cadence__r.Id, canon_app__Cadence__r.canon_app__Lead__c, canon_app__Cadence__r.canon_app__Lead__r.OwnerId, canon_app__Cadence__r.canon_app__Opportunity__c, 
            canon_app__Cadence__r.canon_app__Opportunity__r.OwnerId, canon_app__Lead__c, canon_app__Lead__r.OwnerId, canon_app__Contact__c, canon_app__Contact__r.OwnerId,
            canon_app__Cadence__r.canon_app__Status__c, canon_app__Completed__c, Id, canon_app__Sent__c, canon_app__Scheduled_Date_Time__c, 
            canon_app__Text_Template__c, canon_app__Time_to_Send__c, canon_app__Text_Template__r.Id, 
            canon_app__Text_Template__r.canon_app__Text_Message__c, OwnerId, canon_app__Account__c, canon_app__Account__r.OwnerId, 
            canon_app__Additional_Ids__c FROM canon_app__Scheduled_Text__c 
            WHERE canon_app__Scheduled_Date_Time__c <= :sync AND canon_app__Sent__c = false AND canon_app__Completed__c = false 
            AND 
                ((canon_app__Cadence__c != null AND canon_app__Cadence__r.canon_app__Status__c = 'In Progress' 
                    AND (canon_app__Cadence__r.canon_app__Lead__r.canon_app__Do_Not_Contact__c = false AND canon_app__Cadence__r.canon_app__Contact__r.canon_app__Do_Not_Contact__c = false 
                    AND canon_app__Cadence__r.canon_app__Lead__r.canon_app__Do_Not_Contact__c = false 
                    AND canon_app__Cadence__r.canon_app__Contact__r.canon_app__Do_Not_Contact__c = false
                    AND (canon_app__Cadence__r.canon_app__Marketing_Cadence__c = False 
                            OR (canon_app__Cadence__r.canon_app__Marketing_Cadence__c = true 
                                AND (canon_app__Cadence__r.canon_app__Lead__r.canon_app__Text_Marketing_Opt_In__c = true OR canon_app__Cadence__r.canon_app__Contact__r.canon_app__Text_Marketing_Opt_In__c = true)
                            )
                        )
                    ))
                OR  (canon_app__Lead__c != null AND canon_app__Lead__r.canon_app__Do_Not_Contact__c = false AND canon_app__Lead__r.canon_app__Do_Not_Contact__c = false) 
                        OR (canon_app__Contact__c != null AND canon_app__Contact__r.canon_app__Do_Not_Contact__c = false AND canon_app__Contact__r.canon_app__Do_Not_Contact__c = false)
                    )
            ORDER BY canon_app__Scheduled_Date_Time__c ASC];

System.debug('Scheduled Texts: ' + scheduledTexts.size());

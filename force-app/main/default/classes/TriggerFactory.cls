/**
 * @description       : 
 * @author            : Jared Simpson
 * @group             : 
 * @last modified on  : 02-02-2023
 * @last modified by  : Jared Simpson
**/
public abstract class TriggerFactory {
    protected List<SObject> oldRecords;
    protected List<SObject> newRecords;
    protected Map<Id, SObject> oldRecordsMap;
    protected Map<Id, SObject> newRecordsMap;

    // Event handling contexts
    public virtual void beforeInsert() { }
    public virtual void afterInsert() { }
    public virtual void beforeUpdate() { }
    public virtual void afterUpdate() { }
    public virtual void beforeDelete() { }
    public virtual void afterDelete() { }
    public virtual void afterUndelete() { }

    public static void run(String className) {
        TriggerFactory instance = newTriggerInstance(className);
        // TriggerFactory instance = newTriggerInstance();

        if (Trigger.isBefore && Trigger.isInsert) {
            instance.beforeInsert();
        } else if (Trigger.isAfter && Trigger.isInsert) {
            instance.afterInsert();
        } else if (Trigger.isBefore && Trigger.isUpdate) {
            instance.beforeUpdate();
        } else if (Trigger.isAfter && Trigger.isUpdate) {
            instance.afterUpdate();
        } else if (Trigger.isBefore && Trigger.isDelete) {
            instance.beforeDelete();
        } else if (Trigger.isAfter && Trigger.isDelete) {
            instance.afterDelete();
        } else if (Trigger.isAfter && Trigger.isUndelete) {
            instance.afterUndelete();
        }
    }

    public static TriggerFactory newTriggerInstance(String className) {
        return (TriggerFactory) Type.forName(className).newInstance();
    }
}

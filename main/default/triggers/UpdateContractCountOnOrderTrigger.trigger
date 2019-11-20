trigger UpdateContractCountOnOrderTrigger on Contract (after update, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) { 
            UpdateContractCountOnOrderHandler  objContractCountHandler = new UpdateContractCountOnOrderHandler(); 
            objContractCountHandler.updateContractCount(Trigger.New);
        }
        if (Trigger.isDelete) { 
            UpdateContractCountOnOrderHandler  objContractCountHandler = new UpdateContractCountOnOrderHandler(); 
            objContractCountHandler.updateContractCount(Trigger.Old);
        }
    }
}
schema CrossplaneConditionTypes:
    $type: "Ready" | "Synced" | "Unknown"

schema UpjetConditionTypes:
    $type: "AsyncOperation" | "LastAsyncOperation"

schema CrossplaneManagedResourceCondition:
    """
    Conditions that may Apply to a Crossplane Managed Resource

    Attributes
    ----------
    lastTransitionTime : str, default is Undefined, required
        LastTransitionTime is the last time this condition transitioned from one status to another.
    message : str, default is Undefined, optional
        A Message containing details about this condition's last transition from one status to another, if any.
    reason : str, default is Undefined, required
        A Reason for this condition's last transition from one status to another.
    status : str, default is Undefined, required
        Status of this condition; is it currently True, False, or Unknown?
    $type : str, default is Undefined, required
        Type of this condition. At most one of each condition type may apply to a resource at any point in time.
    """
    lastTransitionTime: str
    message?: str
    reason?: str
    status?: str
    $type: CrossplaneConditionTypes.type | UpjetConditionTypes.type

# Helpers for Conditions
# allConditionsTrue checks if all conditions are True
allConditionsTrue = lambda conditions: [CrossplaneManagedResourceCondition] -> bool {
    all_true([len(conditions) > 0] + [c.status == "True" for c in conditions])
}
# Is the condition present and True? 
conditionTrue = lambda conditions: [CrossplaneManagedResourceCondition], type -> bool {
    any_true([c.status == "True" and c.type == type for c in conditions])
}
# getCondition returns a Condition. 
getCondition = lambda conditions: [any], type: str -> any {
    _c = [c for c in conditions if c.type == type]
    _c[0] if any_true(_c) else {}
}
# hasCondition returns true if the Condition type is defined
hasCondition = lambda conditions: [CrossplaneManagedResourceCondition], type: str -> bool {
    any_true([c for c in conditions if c.type == type])
}

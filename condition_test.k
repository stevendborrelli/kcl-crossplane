test_crossplaneConditionTypes = lambda {
    a = CrossplaneConditionTypes {
        type: "Ready"
    }
    assert a.type == 'Ready'
}

test_allConditionsTrue = lambda {
    empty: [CrossplaneManagedResourceCondition] = []
    assert allConditionsTrue(empty) == False

    allTrue: [CrossplaneManagedResourceCondition] = [
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Available "
            reason: "ReconcileSuccess"
            status: "True"
            type: "Synced"
        }
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Success"
            reason: "LastAsyncOperation"
            status: "True"
            type: "Ready"
        }
    ]
    assert allConditionsTrue(allTrue) == True
}

test_allConditionsNotTrue = lambda {
    allNotTrue: [CrossplaneManagedResourceCondition] = [
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Available "
            reason: "ReconcileSuccess"
            status: "False"
            type: "Ready"
        }
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Success"
            reason: "LastAsyncOperation"
            status: "True"
            type: "Synced"
        }
    ]
    assert allConditionsTrue(allNotTrue) == False
}

test_conditionTrue = lambda {
    true: [CrossplaneManagedResourceCondition] = [
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Available "
            reason: "ReconcileSuccess"
            status: "False"
            type: "Ready"
        }
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Success"
            reason: "LastAsyncOperation"
            status: "True"
            type: "Synced"
        }
    ]
    assert conditionTrue(true, "Synced") == True
    assert conditionTrue(true, "Ready") == False
}
test_getConditions = lambda {
    conditions: [any] = [
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Available "
            reason: "ReconcileSuccess"
            status: "False"
            type: "Ready"
        }
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Success"
            reason: "LastAsyncOperation"
            status: "True"
            type: "Synced"
        }
    ]

    assert getCondition(conditions, "Synced") == {
        lastTransitionTime: "2024-12-14T17:53:56Z"
        message: "Success"
        reason: "LastAsyncOperation"
        status: "True"
        type: "Synced"
    }

    assert getCondition(conditions, "Unknown") == {}
}

test_hasCondition = lambda {
    conditions: [CrossplaneManagedResourceCondition] = [
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Available "
            reason: "ReconcileSuccess"
            status: "False"
            type: "Ready"
        }
        {
            lastTransitionTime: "2024-12-14T17:53:56Z"
            message: "Success"
            reason: "LastAsyncOperation"
            status: "True"
            type: "Synced"
        }
    ]
    assert hasCondition(conditions, "Synced") == True
    assert hasCondition(conditions, "Bad") == False
}

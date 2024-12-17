import .condition

schema ManagedResource:
    connection_details: any
    spec: any
    status: any

resourceReady = lambda conditions -> bool {
    condition.conditionTrue(conditions, "Ready")
}

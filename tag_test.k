test_listTagsToMapTags = lambda {
    tags = [
        {
            key: "key1"
            value: "value1"
        }
        {
            key: "key2"
            value: "value2"
        }
    ]
    assert listTagsToMapTags(tags) == {'key1': 'value1', 'key2': 'value2'}
}

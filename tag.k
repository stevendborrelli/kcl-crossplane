# listTagsToMapTags takes tags of the format
# tags:
# - key: key1
#   value: value1
# - key: key2
#   value: value2
# 
# and converts them to a map:
# tags:
#   key1: value1
#   key2: value2
listTagsToMapTags = lambda tags -> {str:str} {
    {i.key = i.value for i in tags}
}

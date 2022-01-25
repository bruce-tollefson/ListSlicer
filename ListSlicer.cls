/**@description - slices a list without looping */
public class ListSlicer {
    /**
     * @description - slices an Integer list without looping
     * @param objList - an Integer list
     * @param startSlicePoint - the integer value where the list should be split
     * @return List<Integer>
     */
    public static List<Integer> splitList(List<Integer> intList, Integer startSlicePoint) {
        checkSize(intList.size(), startSlicePoint);
        String listStr = String.join(intList,';');//will need to change if List has ';' in it
        List<String> intListStr = listStr.split(';',startSlicePoint);
        return (List<Integer>)JSON.deserialize(JSON.serialize(intListStr[startSlicePoint-1].split(';')), List<Integer>.class);
    }

    /**
     * @description - slices a String list without looping
     * @param objList - a String list
     * @param startSlicePoint - the integer value where the list should be split
     * @return List<String> - at the slice point
     */
    public static List<String> splitList(List<String> strList, Integer startSlicePoint) {
        checkSize(strList.size(), startSlicePoint);
        String listStr = String.join(strList,';');//will need to change if List has ';' in it
        List<String> strListStr = listStr.split(';',startSlicePoint);
        return (List<String>)JSON.deserialize(JSON.serialize(strListStr[startSlicePoint-1].split(';')), List<String>.class);
    }

    /**
     * @description - slices an sObject list without looping
     * @param List<sObject> sObjList - an sObject list
     * @param Integer startSlicePoint - the integer value where the list should be split
     * @return List<sObject>
     */
    public static List<sObject> splitList(List<sObject> sObjList, Integer startSlicePoint) {
        checkSize(sObjList.size(), startSlicePoint);
        String sObjectListStr = JSON.serialize(sObjList);
        String sObjSplit = JSON.serialize(sObjectListStr.split('\\},\\{',startSlicePoint));
        String sObjReplace = sObjSplit.replace('\\','');
        return (List<sObject>)JSON.deserialize(sObjReplace.substring(2,sObjReplace.length()-2).replace('""', '"').replace('"{','{').replace('}"','}'), List<sObject>.class);
    }

    /**
     * @description - slices an Object list without looping
     * @param List<Object> objList - an Object list
     * @param startSlicePoint - the integer value where the list should be split
     * @return List<Object>
     */
    public static List<Object> splitList(List<Object> objList, Integer startSlicePoint) {
        checkSize(objList.size(), startSlicePoint);
        String listStr = String.join(objList,';');//will need to change if List has ';' in it
        List<String> objListStr = listStr.split(';',startSlicePoint);
        return (List<Object>)JSON.deserializeUntyped(JSON.serialize(objListStr[startSlicePoint-1].split(';')));
    }

    /**
     * @description - checks to make sure we will not get an index out of bounds error
     * @param Integer listSize - an Integer list
     * @param Integer slicePoint - the integer value where the list should be split
     */
    private static void checkSize(Integer integer1, Integer integer2){
        if(integer1 < integer2) throw new ListSlicerException('The List size: '+integer1+' has to be greater than '+integer2);
    }

    public class ListSlicerException extends Exception{}
}

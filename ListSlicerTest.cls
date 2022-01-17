@isTest
public class ListSlicerTest {

    @TestSetup
    static void testSetup(){
        insert new Account(name='Test', type='Prospect');
        insert new Account(name='Test2', type='Prospect');
        insert new Account(name='Test3', type='Prospect');
    }

    @isTest
    public static void listSlicerIntegerTest() {
        List<Integer> intList = new List<Integer>{9,5,8,8,6,3,1,2,7};
        Test.startTest();
        intList = ListSlicer.splitList(intList, 5);
        Test.stopTest();
        system.assertEquals(new List<Integer>{6,3,1,2,7},intList);
    }
    
    @isTest
    public static void listSlicerIntegerTestCheckException() {
        List<Integer> intList = new List<Integer>{9,5,8,8,6,3,1,2,7};
        Test.startTest();
        Boolean error = false;
        try{
        	intList = ListSlicer.splitList(intList, 10);//should error
        }catch(Exception e){
            error = true;
        }
        Test.stopTest();
        system.assert(error);
    }

    @isTest
    public static void listSlicerStringTest() {
        List<String> stringList = new List<String>{'9','5','8','8','6','3','1','2','7'};
        Test.startTest();
        stringList = ListSlicer.splitList(stringList, 5);
        Test.stopTest();
        system.assertEquals(new List<String>{'6','3','1','2','7'},stringList);
    }

    @isTest
    public static void listSlicerObjectTest() {
        List<Object> objectList = new List<Object>{'9','5','8','8','6','3','1','2','7'};
        Test.startTest();
        objectList = ListSlicer.splitList(objectList, 5);
        Test.stopTest();
        system.assertEquals(new List<Object>{'6','3','1','2','7'},objectList);
    }

    @isTest
    public static void listSlicersObjectTest() {
        List<Account> actList = [Select Id, Name, Type from Account];
        List<Account> actExpectedList = actList.deepClone(true, true, true);
        actExpectedList.remove(0);
        Test.startTest();
        actList = (List<Account>)ListSlicer.splitList(actList, 2);
        Test.stopTest();
        system.assertEquals(actExpectedList,actList);
    }

    @isTest
    public static void listSlicersObjectInsertTest() {//making sure the structure is good for inserting objects
        List<Account> actList = new List<Account>{new Account(name='Test2', type='Prospect'), new Account(name='Test3', type='Prospect')};
        Test.startTest();
        actList = (List<Account>)ListSlicer.splitList(actList, 2);
        insert actList;
        Test.stopTest();
        system.assert(actList[0].Id != null);
    }
}
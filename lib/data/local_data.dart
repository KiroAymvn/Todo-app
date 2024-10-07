import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";
Database ?database;

//CRUD-->CREATE READ UPDATE DELETE

/*
فكرة الdata base اكنها جدول .. كل حاجة ليها id lojgt لكن باقي الحجات اللي جوا ممكن تكون متشابه او غير متشابه
 */
/*
1.create data base
ا.اول حاجة بنعمل فايل للdatabase و نجيب المسار
2.open data base
ا.لما الكود يشاغل هنشوف لما يفتح الdata base لو لقي موجود داتا بيس هيكمل عادي شغله
لو ملقاش يبقي هيخش علي الخطوة اللي بعدها و هي انه يخلق داتا بيس

طيب قفلنا و فتحنا تاني
لقي انه موجود داتا بيس يبقي خلاص مش هبخلق تاني داتا بيس و يشتغل علي اللي موجود


الكود عندي اول ما بنزله من pub dev بيكون كدا
الجدول اللي عملتع في الاول ناوي اسميه x و بكدا اي كلمه test هغيرها الي x
و ترجع تتكتب في x.db


'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'
id :ده الرقم لكل جزء
name:ده متغير بيتغير حسب البرنامج
value: ده متغير بيتغير حسب البرنامج
num :ده متغير بيتغير حسب البرنامج
TEXT,INTGER,REAL:دول باراميترز حسيب كل متغير يعني في اللي بياخد تكست او انتجر ... الخ و لو حابب اعرف كل واحده بجبها من موقغ
 */

//CREATE
createDataBase()async {
  var databasesPath = await getDatabasesPath();
  print("$databasesPath **********************************");
  String path = join(databasesPath, "Task.db");
  print(path);

// open the database
  database = await openDatabase(path, version: 1,
      //create data base
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date  TEXT,status TEXT)').then((value){
              print("table created");
        });
      },onOpen: (database){
    print("hello table");
    getDataBase(database);
    insertDataBase();

      }

      );


}
/*
insertDataBase
لفتح فنكشن و ادخل المتغيرات اللي انا عاي اغيرها كل مره
و جوا بكتب الكود ده
 */

//READ
insertDataBase({
 String ?title,
 String ?date,
 String ?time,
  String?status,
})
{

  database?.transaction((txn)async{
    await txn.rawInsert('INSERT INTO Task(title,date,time,status) VALUES("$title", "$date","$time","notDone")').then((value){
      print("$value is inserted successfully");
      getDataBase(database!);
    }).catchError((error){
      print(error);
    });
  });

}


/*
updateDataBase

هنا الdata بتتغيرعند الid , طيب ايه اللي بيتغير الname,date,time
و لذلك بدخلهم كا متغيرات
و جوا الفنكشن بكتب الكود ده
 */

//UPDATE
updateDataBase({
  String ?title,
  String ?date,
  String ?time,
  int ?id,
})
 {
database?.rawUpdate('UPDATE Task SET title = ?, date = ?,time=? WHERE id = ?',
    [title, date, time,id]).then((value){
      print("$value is updated");
      getDataBase(database!);
});
}
updateStatus({
  String ?status,
  int ?id,
})
{
  database?.rawUpdate('UPDATE Task SET status? WHERE id = ?',
      [status]).then((value){
    print("$value status is updated");
    getDataBase(database!);

  });
}

//DELETE

deleteDataBase({int ?id,}){

  database?.rawDelete('DELETE FROM Task WHERE id = ?', [id]).then((value){
    print("$value is deleted");
    getDataBase(database!);
  });
}



/*
الفنكشن دي معناها ان اي حاجة تحصل في اللي فنكشنز اللي فاتت تضاف في اللبست سواء add,update,delete,create
 */
List<Map> taskList=[];
List<Map>doneList=[];
getDataBase(Database dataBase){
  database?.rawQuery('SELECT * FROM Task').then((value){
    for(Map<String,Object?>element in value)
      {
        taskList.add(element);
        if(element["status"]=="Done")
          {
            doneList.add(element);
          }
      }

    
  }).catchError((error){
    print(error);
  });

}



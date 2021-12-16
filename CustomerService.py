import mysql.connector
from mysql.connector import errorcode

try:
  cnx = mysql.connector.connect(user='pmb_appuser',
                                password='r@nd0mP@%%!',
                                host='127.0.0.1',
                                database='cutomerservice')
  cursor = cnx.cursor()                             
except mysql.connector.Error as err:
  if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    print("Something is wrong with your user name or password")
  elif err.errno == errorcode.ER_BAD_DB_ERROR:
    print("Database does not exist")
  else:
    print(err)
else:
  print("Database connection Success")  
  
  query = ("Select q.QuestionName,qt.hitcount from  Pmb_Questions q inner join Pmb_QuestionTally qt on qt.QuestionID = q.QuestionID where qt.Insertdate <= NOW()")
  cursor.execute(query)
  results = cursor.fetchall()
  print(results)
cnx.close()
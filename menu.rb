###################################################
# Author    : Mr. Jake Rodriguez Pomperada,MAED-IT
# Tools     : Ruby Version 2.6.3 and Notepad++
# Date      : May 14, 2019   Tuesday
# Location  : Bacolod City,Negros Occidental
# Website   : http://www,jakerpomperada.com
# Email     : jakerpomperada@gmail.com
###################################################

require 'mysql'

class MysqlDatabase
  def initialize(server,database,username,password)
    @svr = server
    @db = database
    @usr = username
    @pwd = password
  end

  def connect
    mysql = Mysql.connect(@svr, @usr, @pwd, @db)
    mysql.close()
  end

  def create_data(fname,lname,course,email)
    mysql = Mysql.connect(@svr, @usr, @pwd, @db)
	stmt = mysql.prepare('INSERT INTO students(firstname,lastname,course,email) VALUES (?,?,?,?)')
    stmt.execute fname,lname,course,email
	print "\n\n"
	print "\tRecord has been saved in the database."
	print "\n\n"
    mysql.close()
  end

  def read_data
    mysql = Mysql.connect(@svr, @usr, @pwd, @db)
    print("\n\n")
	print("\t----------------------------------------")   
	print("\n")
    print("\t\tVIEW ALL STUDENTS RECORDS")
	print("\n")
    print("\t----------------------------------------")
	print("\n\n")
	print("\tID \tLASTNAME \tFIRSTNAME \tCOURSE \t\tEMAIL")
    print("\n\n")
    results = mysql.query('SELECT id,lastname,firstname,course,email FROM students ORDER BY lastname ASC')
    results.each do | id,lastname,firstname,course,email|
      print("\t#{id}\t#{lastname}\t#{firstname} \t#{course}\t#{email}\n")
    end
    mysql.close()
  end

  def update_data(id,fname,lname,course,email)
    mysql = Mysql.connect(@svr, @usr, @pwd, @db)
	print("\n")
    print("\tUpdationg Student Record ID No. #{id}")
    stmt = mysql.prepare('UPDATE students SET firstname=?,lastname=?,course=?,email=? WHERE id=?')
    stmt.execute fname,lname,course,email,id
    print "\n\n"
	print "\tRecord has been updated in the database."
	print "\n\n"
    mysql.close()
  end

  def delete_data(id)
    mysql = Mysql.connect(@svr, @usr, @pwd, @db)
	print("\n")
    print("\tDeleting Student Record ID No.#{id}")
    stmt = mysql.prepare('DELETE FROM students  WHERE id=?')
    stmt.execute id
    print "\n\n"
	print "\tRecord has been deleted in the database."
	print "\n\n"
    mysql.close()
  end
    
  
end

def menu
 
loop do

print "\n\n"
print "\t===== STUDENT INFORMATION SYSTEM IN RUBY AND MYSQL =====\n"
print "\t\t  AUTHOR: JAKE RODRIGUEZ POMPERADA"
print "\n\n"
print "\t[1] ADD    STUDENT RECORD\n"
print "\t[2] UPDATE STUDENT RECORD\n"
print "\t[3] VIEW   STUDENT RECORD\n"
print "\t[4] DELETE STUDENT RECORD\n"
print "\t[5] QUIT PROGRAM"
print "\n\n"
print "\tSELECT YOUR CHOICE :=> "
input = gets.strip

    case input
    when "1"
	     print "\n\n"
         print "\tADD STUDENT RECORD"
		 print "\n\n"
		 print "\tGive Student First Name     : "
         fname = gets.chomp
		 print "\tGive Student Last Name      : "
         lname = gets.chomp
		 print "\tGive Student Course         : "
         course = gets.chomp
		 print "\tGive Student Email Address  : "
         email = gets.chomp
		 db = MysqlDatabase.new('127.0.0.1','school','root','')
		 db.create_data(fname.upcase,lname.upcase,course.upcase,email.downcase)
		
    when "2"
         print "\n\n"
         print "\tUPDATE STUDENT RECORD"
		 print "\n\n"
		 print "\tGive Student ID Number     : "
         id = gets;
		 id = id.to_i;
		 print "\tGive Student First Name     : "
         fname = gets.chomp
		 print "\tGive Student Last Name      : "
         lname = gets.chomp
		 print "\tGive Student Course         : "
         course = gets.chomp
		 print "\tGive Student Email Address  : "
         email = gets.chomp
		 db = MysqlDatabase.new('127.0.0.1','school','root','')
		 db.update_data(id,fname.upcase,lname.upcase,course.upcase,email.downcase)
    when "3"
	    db = MysqlDatabase.new('127.0.0.1','school','root','')
        db.read_data()
    when "4"
         print "\n\n"
         print "\tDELETE STUDENT RECORD"
		 print "\n\n"
		 print "\tGive Student ID Number     : "
         id = gets;
		 id = id.to_i;
		 db = MysqlDatabase.new('127.0.0.1','school','root','')
         db.delete_data(id)
		 
    when "5"
	     print("\n\n")
		 print("\tTHANK YOU FOR USING THIS PROGRAM")
	     print("\n\n")
         return
      else
	    print("\n")
        print("\tInvalid option: #{input}. Try Again.")
		print("\n")
    end
 end
end

menu

# End of Code


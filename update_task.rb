#!/usr/bin/env ruby
# encoding: UTF-8
require 'sqlite3'
require 'cgi'
require 'cgi/session'
cgi = CGI.new
session = CGI::Session.new(cgi)

begin

session['user'] = (session['user'] || 1) #のちのちいじる必要ある。固有のユーザIDを付加したい。
print cgi.header("text/html; charset=utf-8")

db = SQLite3::Database.new("Indepedence.db")

done_task = cgi["done_task"] #今のところ複数のタスクを同時に消化させる機能はついてない。ひとつづつ。
p done_task

db.transaction(){
  #[[]]の形で取り出される
  task_inquestion = db.execute("SELECT * FROM Sequence WHERE task_id = ?;", done_task).first
  case task_inquestion[1]
  when 0 then #毎日習慣.JST+9 hours + 24hours
    db.execute("UPDATE Sequence SET next_time = datetime('now', '+33 hours'), num_th = ? WHERE task_id = ?;", (task_inquestion[3].to_i + 1).to_s, done_task)
  when 1 then #毎週習慣JST + 9hours + 24*7hours. daysにはしづらい。
    db.execute("UPDATE Sequence SET next_time = datetime('now', '+177 hours'), num_th = ? WHERE task_id = ?;", (task_inquestion[3].to_i + 1).to_s, done_task)
  when 2 then #毎月習慣
    db.execute("UPDATE Sequence SET next_time = datetime('now', '+1 months'), num_th = ? WHERE task_id = ?;", (task_inquestion[3].to_i + 1).to_s, done_task)
  else #忘却曲線に沿った習慣
    #未実装
  end

  new_task_inquestion = db.execute("SELECT * FROM Sequence WHERE task_id = ?;", done_task)
  new_task_inquestion = new_task_inquestion[0]
}

print <<EOF
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
<head>
<body>
thanks.<br>
<br>
Your task has been updated.<br>
<br>
#{new_task_inquestion}
<br>
<br>
<a href= "http://cgi.u.tsukuba.ac.jp/~s1811433/local_only/wp/view_task.rb" >View tasks</a>
</body>
</html>

EOF
session.close
rescue => ex
  puts ex.message
  puts ex.backtrace
end

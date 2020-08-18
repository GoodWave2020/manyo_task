## テーブルスキーマ

### Userモデル
テーブル名  |データ型  
--|--
id  |integer  
name  |string  
login_id |string  
password_digest  |string  

### Taskモデル
テーブル名  |データ型  
--|--
id  |integer  
name  |string
priority  |integer  
dead_line  |datetime  
status  |integer  
content  |text  
user_id  |integer  

### Labelモデル
テーブル名  |データ型  
--|--
id  |integer  
task_id  |integer
user_id  |integer 

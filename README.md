## テーブルスキーマ

### Userモデル
テーブル名  |データ型  
--|--
id  |integer  
name  |string  
email |string  
password_digest  |string  

### Taskモデル
テーブル名  |データ型  
--|--
id  |integer  
name  |string
priority  |integer  
dead_line  |datetime  
status  |string  
content  |text  
user_id  |integer  

### Labelモデル
テーブル名  |データ型  
--|--
id  |integer  
name  |string

### Labellingモデル
テーブル名  |データ型  
--|--
id  |integer  
task_id  |integer
label_id  |integer

## herokuデプロイ手順
1. アプリのディレクトリに移動
2. herokuにログインしていなければ`heroku login`を実行、ブラウザでパスワード入力
3. `$ heroku create`
4. `$ rails assets:precompile RAILS_ENV=production`
5. `$ git push heroku master`
6. `$ heroku run rails db:migrate`

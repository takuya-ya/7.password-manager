#!/bin/bash

password_manager_input()
{
    echo 'パスワードマネージャーへようこそ!'
    echo 'サービス名を入力して下さい : '
    read service
    echo 'ユーザー名を入力してください : '
    read user
    echo 'パスワードを入力してください : '
    read pass
}

validate_input()
{
    if [ -z "$service" ]; then
            echo 'サービス名が入力されていません'
    fi

    if [ -z "$user" ]; then
            echo 'ユーザー名が入力されていません'
    fi

    if [ -z "$password" ]; then
            echo 'パスワードが入力されていません'
    fi
}

password_manager_input
validate_input

printf 'Thank you\033[31m!\033[0m\n'




# バリデーション処理
# save_login_data
# #入力をファイルへリダイレクトして保存
# echo ${service}:${user}:${pass} >> login_data.text
# #エラー処理

<< COMMENTOUT
ステップ1
パスワードを保存する処理を、シェルスクリプトで作成します。

以下の情報を保存できるようにします。この情報はファイルに保存してください。

サービス名
ユーザー名
パスワード
シェルスクリプトを実行すると、以下が表示されます。

パスワードマネージャーへようこそ！
サービス名を入力してください：
ユーザー名を入力してください：
パスワードを入力してください：
# 入力が完了したら
Thank you!
サービス名、ユーザー名、パスワードの入力が求められ、入力された情報を "サービス名:ユーザー名:パスワード" という形式でファイルに保存します。シェルスクリプトを実行するたびに入力された情報はファイルに追記されるようにしてください。
COMMENTOUT

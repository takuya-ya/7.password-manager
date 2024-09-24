#!/bin/bash

password_manager_input()
{
    echo 'パスワードマネージャーへようこそ!'
    echo 'サービス名を入力して下さい : '
    read service_name
    echo 'ユーザー名を入力してください : '
    read user_name
    echo 'パスワードを入力してください : '
    read password
}

declare -A errors=([service_name_error]='' [user_name_error]='' [password_error]='')
validate_input()
{
    if [ -z "$service_name" ]; then
        errors[service_name_error]='サービス名が入力されていません'
    fi

    if [ -z "$user_name" ]; then
        errors[user_name_error]='ユーザー名が入力されていません'
    fi

    if [ -z "$password" ]; then
        errors[password_error]='パスワードが入力されていません'
    fi
}

display_errors()
{
    for error in "${errors[@]}"; do
     if [ -n "$error" ]; then
        printf "%s\n" "${error}"
        fi
    done
}

save_login_data() {
    echo "${service_name}:${user_name}:${password}" >> keep_login_data.txt
}

password_manager_input
validate_input
display_errors
save_login_data
printf 'Thank you\033[31m!\033[0m\n'

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

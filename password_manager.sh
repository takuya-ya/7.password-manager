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

declare -A errors=([service_error]='' [user_error]='' [pass_error]='')
validate_input()
{
    if [ -z "$service" ]; then
        errors[service_error]='サービス名が入力されていません'
    fi

    if [ -z "$user" ]; then
        errors[user_error]='ユーザー名が入力されていません'
    fi

    if [ -z "$pass" ]; then
        errors[pass_error]='パスワードが入力されていません'
    fi
}

count_and_display_errors()
{
    error_num=0
    for error in "${errors[@]}"; do
        if [ -n "$error" ]; then
            ((error_num++))
        fi
    done

    if [ "$error_num" -ne 0 ]; then
        printf "%s\n" "${errors[@]}"
    else
        printf 'Thank you\033[31m!\033[0m\n'
    fi
}

password_manager_input
validate_input
count_and_display_errors

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

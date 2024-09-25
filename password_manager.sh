#!/bin/bash

add_password()
{
    echo 'パスワードマネージャーへようこそ!'
    echo 'サービス名を入力して下さい : '
    read service_name
    echo 'ユーザー名を入力してください : '
    read user_name
    echo 'パスワードを入力してください : '
    read password
    echo
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
    error_keys=(service_name_error user_name_error password_error)
}

display_errors()
{
    for key in "${error_keys[@]}"; do
        if [ -n "${errors["${key}"]}" ]; then
            printf "%s\n" "${errors["${key}"]}"
            error_status=true
        fi
    done
}

save_login_data() {
    echo "${service_name}:${user_name}:${password}" >> keep_login_data.txt
}

get_password() {
#     # Get Password が入力された場合
# サービス名を入力してください：
# ## サービス名が保存されていなかった場合
# そのサービスは登録されていません。
# ## サービス名が保存されていた場合
# サービス名：hoge
# ユーザー名：fuga
# パスワード：piyo
    echo 'サービス名を入力して下さい：'
    read input_service_name
    # 区切り文字で分割し、先頭ブロック（サービス名）を検索する方法もある
    grep "^${input_service_name}" keep_login_data.txt
    echo
}

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read menu

    if [ "${menu}" = "a" ]; then
        add_password
        validate_input
        display_errors
        if [ -z "${error_status}" ]; then
            save_login_data
            echo 'パスワードの追加は成功しました。'
            echo
        fi
    elif [  "${menu}" = "g" ]; then
        get_password
    elif [ "${menu}" = "e" ]; then
        printf 'Thank you\033[31m!\033[0m\n'
        exit
    else
        echo '入力が間違えています。Add Password/Get Password/Exit から入力してください。'
        echo
    fi
done

<< COMMENTOUT

選択肢の関数作成
テスト

Add Password が入力されると、サービス名、ユーザー名、パスワードの入力が求められ、入力された情報をファイルに保存します。
 Get Password が入力されると、サービス名の入力が求められ、入力されたサービスのサービス名、ユーザー名、パスワードが表示されます。
▼アウトプット

# Add Password が入力された場合
サービス名を入力してください：
ユーザー名を入力してください：
パスワードを入力してください：

パスワードの追加は成功しました。
次の選択肢から入力してください(Add Password/Get Password/Exit)：


COMMENTOUT

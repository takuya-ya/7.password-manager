#!/bin/bash

add_password()
{
    echo -n 'サービス名を入力して下さい : '
    read service_name
    echo -n 'ユーザー名を入力してください : '
    read user_name
    echo -n 'パスワードを入力してください : '
    read -s password
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
    echo -n 'サービス名を入力して下さい：'
    read input_service_name

    if [ -z "${input_service_name}" ]; then
        echo -e "サービス名が入力されていません。\n"
        return
    fi

    user_information=$( grep "^${input_service_name}" keep_login_data.txt | awk -F ':' '{print $1,$2,$3}')
    echo "サービス名：${user_information[@]}"

    if [ -z "${user_information}" ]; then
        echo -e "そのサービスは登録されていません。\n"
        return
    fi

    read -a user_information <<< "${user_information}"
    echo "サービス名：${user_information[0]}"
    echo "ユーザー名：${user_information[1]}"
    echo "パスワード：${user_information[2]}"

    echo
}

while true; do
    echo "パスワードマネージャーへようこそ！"
    echo -n "次の選択肢から入力してください(Add Password/Get Password/Exit):"
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

COMMENTOUT

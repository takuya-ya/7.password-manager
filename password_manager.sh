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
            #間違った入力がある場合、trueを代入。後の関数でtrueの有無により、入力を保存するかを分岐する。
            # error_keysの配列の要素数をカウントして入力ミスがあるかどうかを確認するようにした方がういい。errorstatusに何回もtrueを代入するのは無駄。
            error_status=true
        fi
    done
}

save_login_data() {
    echo "${service_name}:${user_name}:${password}" >> keep_login_data.txt
}

encrypt_file() {
   gpg --symmetric --yes --output encrypted_data.gpg keep_ogin_data.txt 2>> error_log.txt
    if [ $? -eq 0 ]; then
        echo 'パスワードの追加は成功しました。'
        rm keep_login_data.txt
        echo
    else
        echo 'ファイルの暗号化に失敗しました。'
        echo
    return
    fi
    # 登録サービスの重複を確認
    #暗号化されているか確認
    #  gpg -d  encrypted_data.gpg > keep_login_data.txt
}

get_password() {
    # パスワードをファイルを元のファイルを残して復元
     gpg -d  encrypted_data.gpg > keep_login_data.txt
    # echo $?
    echo -n 'サービス名を入力して下さい：'
    read input_service_name

    if [ -z "${input_service_name}" ]; then
        echo -e "サービス名が入力されていません。\n"
        return
    fi
    # 登録データを呼び出し、awkで空白に区切って変数に代入
    user_information=$( grep "^${input_service_name}" keep_login_data.txt | awk -F ':' '{print $1,$2,$3}')

    if [ -z "${user_information}" ]; then
        echo -e "そのサービスは登録されていません。\n"
        return
    fi
    echo "${user_information}"
    # 配列として変数に読み込み、インデントを呼び出して登録情報を出力
    read -a user_information <<< "${user_information}"
    echo "サービス名：${user_information[0]}"
    echo "ユーザー名：${user_information[1]}"
    echo "パスワード：${user_information[2]}"
    # 復元したファイルを削除
    rm keep_login_data.txt

    echo
}

echo "パスワードマネージャーへようこそ！"
while true; do
    echo -n "次の選択肢から入力してください(Add Password/Get Password/Exit):"
    read menu

    if [ "${menu}" = "a" ]; then
        add_password
        validate_input
        display_errors
        # error_statusでなく、errorsの配列の有無で入力ミスを確認に変更すること
        if [ -z "${error_status}" ]; then
            save_login_data
            encrypt_file
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
Add Password が入力された場合、サービス名、ユーザー名、パスワードをファイルに保存した後にファイルを暗号化します

暗号化されたファイルを開いて、パスワードが読み取れないことを確認してください

Get Password が入力された場合、暗号化されたファイルを復号化して（元の状態に戻して）サービス名、ユーザー名、パスワードを表示します。なおその際に、ファイルそのものは暗号化された状態を維持してください（Get Password後にファイルを開いてもファイルは暗号化されています）
COMMENTOUT

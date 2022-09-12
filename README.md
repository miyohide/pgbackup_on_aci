# これは何か

PostgreSQLに対してpg_dumpをAzure Container Instanceを使って実行するためのTerraformスクリプトです。詳細は以下のブログ記事を参照してください。

- https://miyohide.hatenablog.com/entry/2022/08/28/160922
- https://miyohide.hatenablog.com/entry/2022/09/11/115434

# 使い方

## PostgreSQLやStorageアカウントを作成する

1. `cd 01_prepare`を実行して`01_prepare`に移動します。
2. `terraform init`を実行します。
3. `terraform plan -out main.tfplan`を実行します。
    - PostgreSQLのAdminユーザとパスワードを設定する必要があります。任意の値を設定してください。
4. `terraform apply main.tfplan`を実行します。

## Azure Container Instanceを作成する

5. `cd ../02_exec`を実行して、`02_exec`に移動します。
6. `terraform init`を実行します。
7. `terraform plan`を実行します。
8. `terraform apply`を実行します。

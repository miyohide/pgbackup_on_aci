variable "prefix" {
  type        = string
  default     = "miyohide"
  description = "全てのリソースにつける接頭辞"
}

variable "location" {
  type        = string
  default     = "japaneast"
  description = "リソースのリージョン"
}

variable "postgresql_admin" {
  type        = string
  description = "PostgreSQLのAdmin User"
}

variable "postgresql_password" {
  type        = string
  description = "PostgreSQLのAdmin Userのパスワード"
}

variable "postgresql_database" {
  type        = string
  default     = "testdb"
  description = "PostgreSQLのデータベース名"
}

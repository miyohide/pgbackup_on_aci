variable "prefix" {
  type        = string
  default     = "miyohide"
  description = "全てのリソースにつける接頭辞"
}

variable "postgresql_database" {
  type        = string
  default     = "testdb"
  description = "PostgreSQLのデータベース名"
}

variable "postgresql_name" {
  type        = string
  description = "PostgreSQLの名前"
}

variable "fileshare_name" {
  type        = string
  default     = "aci-share"
  description = "Azure File Shareの名前"
}

terraform {
  backend "s3" {
    endpoints = {
      s3 =       "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gnvrgj455dg0ds6pc8/etnsus8jp1nk0hqgtbot"
    }
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
  }
}
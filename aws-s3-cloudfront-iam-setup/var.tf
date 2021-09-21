variable "stag_bucket_assets_name" {
    description = "client-project-assets-staging"
    type = string
    default = "client-project-assets-staging"
}

variable "prod_bucket_assets_name" {
    description = "client-project-assets-production"
    type = string
    default = "client-project-assets-production"
}

variable "stag_bucket_storage_name" {
    description = "client-project-staging"
    type = string
    default = "client-project-staging"
}

variable "prod_bucket_storage_name" {
    description = "client-project-production"
    type = string
    default = "client-project-production"
}


variable "tags" {
    description = "tag for items"
    type = string
    default = "client-project"
}

variable "acl_value" {
    default = "private"
}

variable "staging_origin_id" {
    description = "client-project-assets-staging"
    type = string
    default = "client-project-assets-staging"
}

variable "production_origin_id" {
    description = "client-project-assets-staging"
    type = string
    default = "client-project-assets-staging"
}
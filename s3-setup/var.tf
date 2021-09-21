variable "stag_bucket_name" {
    description = "client-project-assets-staging"
    type = string
    default = "client-project-assets-staging"
}

variable "prod_bucket_name" {
    description = "client-project-assets-production"
    type = string
    default = "client-project-assets-production"
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
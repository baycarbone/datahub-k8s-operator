# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "model_uuid" {
  description = "UUID of the (machine) Juju model to deploy the data platform into."
  type        = string
}

variable "kafka_broker" {
  description = "Defines the Apache Kafka broker application configuration"
  type = object({
    app_name    = optional(string, "kafka-broker")
    channel     = optional(string, "4/stable")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number, null)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 3)
    storage     = optional(map(string), {})
  })
  default = {}
}

variable "kafka_controller" {
  description = "Defines the Apache Kafka KRaft controller application configuration"
  type = object({
    app_name    = optional(string, "kafka-controller")
    channel     = optional(string, "4/stable")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number, null)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 3)
    storage     = optional(map(string), {})
  })
  default = {}

  validation {
    condition     = var.kafka_controller.units == 0 || var.kafka_controller.units % 2 != 0
    error_message = "The number of Apache Kafka KRaft controllers must be odd (e.g., 1, 3, 5, ...)."
  }
}

variable "kafka_connect" {
  description = "Defines the Kafka Connect application configuration"
  type = object({
    app_name    = optional(string, "kafka-connect")
    channel     = optional(string, "latest/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number, null)
    base        = optional(string, "ubuntu@22.04")
    units       = optional(number, 1)
  })
  default = {}
}

variable "kafka_karapace" {
  description = "Defines the Karapace application configuration"
  type = object({
    app_name    = optional(string, "karapace")
    channel     = optional(string, "latest/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number, null)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 1)
  })
  default = {}
}

variable "kafka_ui" {
  description = "Defines the Kafbat Kafka UI application configuration"
  type = object({
    app_name    = optional(string, "kafka-ui")
    channel     = optional(string, "latest/edge")
    config      = optional(map(string), {})
    constraints = optional(string, "arch=amd64")
    resources   = optional(map(string), {})
    revision    = optional(number, null)
    base        = optional(string, "ubuntu@24.04")
    units       = optional(number, 1)
  })
  default = {}
}

variable "kafka_profile" {
  description = "The deployment profile to use, either 'production' or 'testing'"
  type        = string
  default     = "testing"
}

variable "opensearch" {
  description = "Configuration for the OpenSearch charm."
  type = object({
    app_name           = optional(string, "opensearch")
    channel            = optional(string, "2/stable")
    revision           = optional(number)
    base               = optional(string, "ubuntu@22.04")
    constraints        = optional(string, "arch=amd64")
    config             = optional(map(string), {})
    storage_directives = optional(map(string), {})
    units              = optional(number, 2)
  })
  default = {}
}

variable "postgresql" {
  description = "Configuration for the PostgreSQL charm."
  type = object({
    app_name           = optional(string, "postgresql-k8s")
    channel            = optional(string, "14/stable")
    revision           = optional(number)
    base               = optional(string, "ubuntu@22.04")
    constraints        = optional(string, "")
    config             = optional(map(string), {})
    storage_directives = optional(map(string), { pgdata = "10G" })
    units              = optional(number, 1)
    resources          = optional(map(string), {})
  })
  default = {}
}

variable "self_signed_certificates" {
  description = "Configuration for the self-signed-certificates charm (TLS for OpenSearch)."
  type = object({
    app_name    = optional(string, "self-signed-certificates")
    channel     = optional(string, "1/stable")
    revision    = optional(number)
    base        = optional(string, "ubuntu@24.04")
    constraints = optional(string, "arch=amd64")
    config      = optional(map(string), {})
    units       = optional(number, 1)
  })
  default = {}
}
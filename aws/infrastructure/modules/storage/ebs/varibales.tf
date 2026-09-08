variable "ebs_volumes" {

  description = "Map of EBS volumes"

  type = map(object({

    availability_zone = string
    size = number
    type = optional(string, "gp3")
    encrypted = optional(bool, true)
    kms_key_id = optional(string)
    snapshot_id = optional(string)
    iops = optional(number)
    throughput = optional(number)
    tags = optional(map(string), {})

  }))

}

variable "tags" {

  description = "Common Tags"
  type = map(string)
  default = {}

}

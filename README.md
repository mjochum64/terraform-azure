Terraform-Azure
===

## How to use
(TBD)

### Installation
(TBD)

### Usage
````sh
$ terraform init
$ terraform plan -out tf.plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.foo will be created
  + resource "null_resource" "foo" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────

Saved the plan to: tf.plan

To perform exactly these actions, run the following command to apply:
    terraform apply "tf.plan"
```

## Generating a plan in markdown

```sh
terraform show -json tf.plan | terraform-j2md > plan.md
```



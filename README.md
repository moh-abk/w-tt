# w-tt

## Public Website Infrastructure;

### Technologies/Tools used;

- AWS (Cloud Provider)
- Terraform (IaC)
- GitHub Actions (CI/CD)

### Project Layout

```shell
.
├── LICENSE
├── README.md
├── tech-test                               # public website contents
│   ├── error.html
│   ├── index.html
│   ├── news
│   │   ├── article_1.html
│   │   └── article_2.html
│   └── people.html
├── terraform                               # terraform code
│   ├── infrastructure
│   │   └── aws
│   │       ├── 166486374934
│   │       │   └── stack
│   │       │       ├── 00-genesis          # terraform bootstrap infrastructure
│   │       │       └── 01-public-website   # terraform website infrastructure
│   │       ├── _terraform_cmds
│   │       └── terraform.sh                # terraform wrapper script
│   └── modules                             # terraform modules
│       └── aws
│           ├── tfm-aws-acm
│           ├── tfm-aws-cloudfront
│           ├── tfm-aws-s3-bucket
│           └── tfm-s3-remote-state
├── terraform-config                        # terraform config
│   └── aws
│       └── vars
│           ├── 166486374934
│           └── common.tfvars.json
└── terraform-docs.yml
```

### Running Locally

```shell
export AWS_PROFILE=admin

./terraform.sh ACCOUNT_ID ENVIRONMENT REGION COMPONENT COMMAND [EXTRA_TERRAFORM_PARAMS]

account_id: Account ID to provision on
region: Deployment region
commands: get plan apply plan_destroy destroy import console rm_state output show_state list_state move_state 
```

### Tasks completed

- [x] The site should be served to the public.
- [x] Add a custom error document.
- [x] Automation of testing & deployment of infrastructure.

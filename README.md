# tg-stack-mock-test

Minimal Terragrunt Stack for testing how env0 handles `mock_outputs`, saved plans and
`ENV0_TERRAGRUNT_RUN_ALL_SKIP_PLAN`. Uses only `terraform_data`, so it needs no cloud credentials.

Chain: `vpc` -> `subnet` -> `rtb`. `subnet` and `rtb` have `mock_outputs` for `init`, `validate`, `plan`.
Each unit stores local state; set `STATE_DIR` to a persistent path if needed.

Working directory for an env0 Terragrunt template: `live`, with run-all enabled.

## Cases to try
1. First deploy, approval required, no skip-plan: plan shows `mock-vpc-id-12345`; check what apply does.
2. First deploy with `ENV0_TERRAGRUNT_RUN_ALL_SKIP_PLAN=true` (auto-approve), then remove it and redeploy.
3. Layered apply: `ENV0_TERRAGRUNT_RUN_ALL_INCLUDE_DIRS=.terragrunt-stack/vpc`, then add `subnet`, then `rtb`.

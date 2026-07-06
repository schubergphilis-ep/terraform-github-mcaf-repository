# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [6.0.3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v6.0.2...v6.0.3) (2026-06-12)


### 🐛 Fixes

* rewrite plaintext_value argument on github_actions_environment_secret as it is deprecated ([#114](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/114)) ([5a47853](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/5a4785311f34027954ac0761373e727339070b13))

## [6.0.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v6.0.1...v6.0.2) (2026-06-10)


### 🐛 Fixes

* order dependabot security updates after vulnerability alerts and  solve deprecation ([#113](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/113)) ([9039b74](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/9039b749cd2fb1015c213a2660c5ccf5fac76c70))

## [6.0.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v6.0.0...v6.0.1) (2026-06-08)


### 🐛 Fixes

* plaintext_value argument is deprecated ([#112](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/112)) ([d9a4c9f](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/d9a4c9fbcc75fdd7dc78c2349ec5742f9a2df35e))

## [6.0.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v5.1.1...v6.0.0) (2026-05-19)


### ⚠ BREAKING CHANGES

* migrate pages to the dedicated github_repository_pages resource ([#110](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/110))

### 🚀 Features

* migrate pages to the dedicated github_repository_pages resource ([#110](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/110)) ([121744f](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/121744f34f522dfa236cb7d272111dc6095851e1))

## [5.1.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v5.1.0...v5.1.1) (2026-04-20)


### 🐛 Fixes

* var.workflow_permissions condition errors out when null ([#109](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/109)) ([5ceaa92](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/5ceaa9265254581c8bd254bf1e9b6330d03bc3e9))

## [5.1.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v5.0.0...v5.1.0) (2026-04-17)


### 🚀 Features

* options to enrich commit messages set on managed or unmanaged files ([#107](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/107)) ([dd430ec](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/dd430ec15401375802faf1a745e67ef07ae56778))
* option to enable discussions on the repository ([#108](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/108)) ([2ae59f3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/2ae59f3c52ed2aedc655644dfc9e08b94289ac3e))

## [5.0.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.8.0...v5.0.0) (2026-04-09)


### ⚠ BREAKING CHANGES

* remove deprecated attribute and thus variable ([#106](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/106))

### 🐛 Fixes

* remove deprecated attribute and thus variable ([#106](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/106)) ([2b654f5](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/2b654f5dbafb60d67a63c0f24d342afa1877021e))

## [4.8.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.7.1...v4.8.0) (2026-04-09)


### 🚀 Features

* add support for github_workflow_repository_permissions ([#104](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/104)) ([d30ba77](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/d30ba779a49272345dfdf845b0011a0c83f7d966))

## [4.7.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.7.0...v4.7.1) (2026-04-09)


### 🐛 Fixes

* always set commit message and title ([#105](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/105)) ([5f8b50b](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/5f8b50bcbaff9fdd22026e1f42f74ff5218552b9))

## [4.7.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.6.0...v4.7.0) (2026-03-04)


### 🚀 Features

* Support creating a forked repository ([#103](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/103)) ([efcc991](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/efcc991c15345dc14ff9312e93c3f3cb10a6b82e))

## [4.6.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.5.0...v4.6.0) (2026-02-26)


### 🚀 Features

* add support for defining custom properties ([#102](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/102)) ([fb26339](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/fb2633948d0920838458fd1f31accbac1f7d8b3c))

## [4.5.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.4.0...v4.5.0) (2026-02-16)


### 🚀 Features

* Updates GitHub provider and pages validation ([#101](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/101)) ([a4df7de](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/a4df7deb17f7e4e2e150503c4f15521e86e484a4))

## [4.4.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.3.0...v4.4.0) (2026-02-09)


### 🚀 Features

* Add support for custom autolink references ([#100](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/100)) ([6c041a2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/6c041a235718ed0f25243aac87e5e5d183d5fce4))

## [4.3.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.2.0...v4.3.0) (2026-01-27)


### 🚀 Features

* add support for github pages 'workflow' build type ([#99](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/99)) ([9325368](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/932536852388b7ce4e7635b72b9b0d4c9e0219df))

## [4.2.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.1.0...v4.2.0) (2025-12-30)


### 🚀 Features

* add support for github pages ([#98](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/98)) ([914f66c](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/914f66c21c438a5bfd70577ecec7fc3354aba7ae))

## [4.1.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v4.0.0...v4.1.0) (2025-11-28)


### 🚀 Features

* add support for associating github apps with the repository ([#97](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/97)) ([6685f7a](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/6685f7a408fe1f6597a07d7c4e2a4c1599cd3186))

## [4.0.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v3.0.0...v4.0.0) (2025-09-02)


### ⚠ BREAKING CHANGES

* Remove `path` from `var.repository_files` settings object ([#93](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/93))
* Remove computable values from `var.deployment_policy` ([#94](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/94))

### 🐛 Fixes

* Remove `path` from `var.repository_files` settings object ([#93](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/93)) ([5e6d87d](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/5e6d87dcdb582fedcbe9891c5981842ae54f943c))
* Remove computable values from `var.deployment_policy` ([#94](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/94)) ([9b32ac7](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/9b32ac7077fa5dfe0fdf71da2a8914e85a3691ee))
* Configure `overwrite_on_create` using variable ([#92](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/92)) ([b0ecd9b](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/b0ecd9baa186c17fe16923ef0b8b1f0f5071ac75))

## [3.0.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v2.2.0...v3.0.0) (2025-07-17)


### ⚠ BREAKING CHANGES

* move environment configuration to dedicated submodule ([#90](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/90))

### 🚀 Features

* move environment configuration to dedicated submodule ([#90](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/90)) ([a0518e1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/a0518e19d3f5a471ca7be01f0c81426b6c31aabb))
* Add `var.merge_strategy` to select merge strategy ([#89](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/89)) ([0afc2e0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/0afc2e0a74379022be908698ecd1f37aa608b173))

### 🐛 Fixes

* Handle null inputs better ([#91](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/91)) ([ac257c2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/ac257c285424b4f6b3e9724e5312898c3769f7f7))

## [2.2.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v2.1.1...v2.2.0) (2025-06-20)


### 🚀 Features

* Add support for require_last_push_approval ([#87](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/87)) ([fa6d041](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/fa6d041a20aaac278da7d48786557ab642e56a8f))

## [2.1.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v2.1.0...v2.1.1) (2025-06-10)


### 🐛 Fixes

* Ensure you do not enable dependabot when your vulnerability alerts are not ([#86](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/86)) ([75d4325](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/75d43256e1c1349edeb2843059bd9942a5b0343d))

## [2.1.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v2.0.0...v2.1.0) (2025-05-20)


### 🚀 Features

* Add Dependabot Security Updates support ([#84](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/84)) ([2bf31ed](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/2bf31edc5d60aa3f692cc990d41c42b0dff83d60))

### 🐛 Fixes

* Set `var.vulnerability_alerts` default to true ([#85](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/85)) ([eac57b3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/eac57b360b18b79adcd36a7fd8c4da606a55689f))

## [2.0.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.5.3...v2.0.0) (2025-05-09)


### ⚠ BREAKING CHANGES

* Update `github_repository` fields and behaviour ([#83](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/83))
* Cannot create team and repo in same run ([#81](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/81))
* Cannot create team and repo in same run ([#81](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/81))

### 🚀 Features

* Update `github_repository` fields and behaviour ([#83](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/83)) ([df79f4d](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/df79f4d144807d7fbdd9439804cbbc27334582ba))
* Support unmanaged files ([#82](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/82)) ([d0ac59b](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/d0ac59b98ade07f9b41f54c8bbbbc501b7622996))

### 🐛 Fixes

* Cannot create team and repo in same run ([#81](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/81)) ([3afae40](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/3afae40237a363a1817c62839bc430025a467fb8))
* Cannot create team and repo in same run ([#81](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/81)) ([3afae40](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/3afae40237a363a1817c62839bc430025a467fb8))

## [1.5.3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.5.2...v1.5.3) (2025-03-06)


### 🐛 Fixes

* deal properly with the default branch protection object ([#79](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/79)) ([ab86253](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/ab86253fa65bd11e79994bb7c9a17d216c3dc8cd))

## [1.5.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.5.1...v1.5.2) (2025-02-04)


### 🐛 Fixes

* Update actor to match current value for Tag Protection ([#78](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/78)) ([02842b8](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/02842b8478c739c895f1c84251ca5cfa2c1bc314))

## [1.5.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.5.0...v1.5.1) (2024-11-22)


### 🐛 Fixes

* bug: template is added every plan ([#77](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/77)) ([6a0674e](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/6a0674ef935b412bcc8dc60f28b939956e0cd9a8))

## [1.5.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.4.0...v1.5.0) (2024-11-18)


### 🚀 Features

* allow pull_request_bypassers for automated PR's ([#76](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/76)) ([1022605](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/1022605ae988c0311e91ae4a9e3d48c15e09fc1c))

### 🐛 Fixes

* Examples protected branches, add missing branch_protection map ([#74](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/74)) ([4ece37a](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/4ece37a791e476e7e1511a9acbaacb86d55abbfa))

## [1.4.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.3.0...v1.4.0) (2024-10-22)


### 🚀 Features

* Add option to disable force push branch protection ([#72](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/72)) ([4f4066e](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/4f4066e6da3fdfdba285515ec2c079d229486f42))

### 🐛 Fixes

* Update the examples for master/main protected ([#73](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/73)) ([716561e](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/716561e36e202f4e42117166d9eca8e4facd4e3b))

## [1.3.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.2.2...v1.3.0) (2024-09-20)


### 🚀 Features

* add archive_on_destroy argument to the github_repository resource ([#71](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/71)) ([b8fde25](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/b8fde25f2f3b3643cd954b135f70147c3b29f222))

## [1.2.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.2.1...v1.2.2) (2024-09-04)


### 🐛 Fixes

* Fix tag protection refactor ([#70](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/70)) ([c2ffffb](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/c2ffffbd1b6bd670a4495417be1aff6a2f7bd4b7))

## [1.2.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.2.0...v1.2.1) (2024-09-04)


### 🐛 Fixes

* Refactor tag protection resources ([#69](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/69)) ([73b3b18](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/73b3b186ca060f4995dd65e9362c0d268e287082))

## [1.2.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.1.1...v1.2.0) (2024-08-12)


### 🚀 Features

* Add Squash merge commit message/title ([#68](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/68)) ([c6d446c](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/c6d446c08ea6998bea53d1ec04ebc69b3b129631))

## [1.1.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.1.0...v1.1.1) (2024-05-10)


### 🐛 Fixes

* bug: remove duplicate restrict_pushes ([#66](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/66)) ([dfbd68e](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/dfbd68e6561d83b3bc742d01b7db8a8e7915d6e9))

## [1.1.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v1.0.0...v1.1.0) (2024-05-10)


### 🚀 Features

* environment variables & branch_pattern support ([#65](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/65)) ([18d095d](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/18d095d7078f6baa20494765d4122a87528fe153))

## [1.0.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.12.0...v1.0.0) (2024-05-07)


### ⚠ BREAKING CHANGES

* Upgrade to GitHub provider v6.0 ([#62](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/62))

### 🚀 Features

* breaking: create and set branch configuration using `var.branches` ([#61](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/61)) ([40b63b5](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/40b63b5d3fe24e50df38d8d7f105138bd6c82e0f))
* Upgrade to GitHub provider v6.0 ([#62](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/62)) ([7720789](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/7720789a1588e77cd5c444d5c2299cf725bb656a))

## [0.12.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.11.0...v0.12.0) (2024-03-27)

## [0.11.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.10.0...v0.11.0) (2024-03-26)


### 🚀 Features

* feat : Add homepage_url support ([#64](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/64)) ([c98274a](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/c98274a543c7d9ce1416ceac713c6ef8a3364b41))

## [0.10.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.9.0...v0.10.0) (2023-10-06)


### 🚀 Features

* Add tag protection support ([#58](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/58)) ([f604915](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/f6049159b0708e7831f9a0e75854582306bb070d))

### 🐛 Fixes

* Support managing files in non-default branches ([#59](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/59)) ([0ae1c38](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/0ae1c38413422fb7f7efb2e285dcc2646b8871cf))

## [0.9.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.8.0...v0.9.0) (2023-08-24)


### 🚀 Features

* Use foreach for team permissions ([#56](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/56)) ([419b023](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/419b02362c673f2bc48ebcad6b0216e0d4d107bc))

## [0.8.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.7.0...v0.8.0) (2023-08-18)

## [0.7.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.6.0...v0.7.0) (2023-07-07)


### 🚀 Features

* enhancement: introduce optional variables in the environment var and improve the way we create github environments ([#54](https://github.com/schubergphilis/terraform-github-mcaf-repository/pull/54)) ([ac31835](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/commit/ac31835af60e3c4ebc2d850fa21ef43550d75d6a))

## [0.6.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.5.4...v0.6.0) (2023-06-16)

## [0.5.4](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.5.3...v0.5.4) (2023-05-25)

## [0.5.3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.5.2...v0.5.3) (2023-05-10)

## [0.5.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.5.1...v0.5.2) (2023-05-02)

## [0.5.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.5.0...v0.5.1) (2023-02-09)

## [0.5.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.4.2...v0.5.0) (2022-03-11)

## [0.4.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.4.1...v0.4.2) (2022-02-04)

## [0.4.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.4.0...v0.4.1) (2021-12-10)

## [0.4.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.10...v0.4.0) (2021-12-09)

## [0.3.10](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.9...v0.3.10) (2021-12-08)

## [0.3.9](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.7...v0.3.9) (2021-09-29)

## [0.3.7](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.8...v0.3.7) (2021-09-24)

## [0.3.8](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.6...v0.3.8) (2021-09-24)

## [0.3.6](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.5...v0.3.6) (2021-09-16)

## [0.3.5](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.4...v0.3.5) (2021-04-30)

## [0.3.4](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.3...v0.3.4) (2021-04-13)

## [0.3.3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.2...v0.3.3) (2021-04-12)

## [0.3.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.1...v0.3.2) (2020-12-03)

## [0.3.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.3.0...v0.3.1) (2020-11-19)

## [0.3.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.2.0...v0.3.0) (2020-11-03)

## [0.2.0](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.7...v0.2.0) (2020-10-29)

## [0.1.7](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.6...v0.1.7) (2020-10-13)

## [0.1.6](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.5...v0.1.6) (2020-09-15)

## [0.1.5](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.4...v0.1.5) (2020-08-24)

## [0.1.4](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.3...v0.1.4) (2020-08-11)

## [0.1.3](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.2...v0.1.3) (2020-04-07)

## [0.1.2](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.1...v0.1.2) (2020-03-31)

## [0.1.1](https://github.com/schubergphilis-ep/terraform-github-mcaf-repository/compare/v0.1.0...v0.1.1) (2020-03-13)

## 0.1.0 (2020-02-10)


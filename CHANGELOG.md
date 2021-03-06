## [Unreleased](https://github.com/frugan-it/docker-bitnami-apache/compare/v1.1.0...HEAD)

### Commits

- Code refactoring [`5909eb5`](https://github.com/frugan-it/docker-bitnami-apache/commit/5909eb5bcfa069e60276d7400b19e2914b0c8d7d)
- Added entrypoint [`e8def5e`](https://github.com/frugan-it/docker-bitnami-apache/commit/e8def5e612a285709fc17c67f3a597051b3bb041)
- Added mod_pagespeed [`86aa570`](https://github.com/frugan-it/docker-bitnami-apache/commit/86aa57093775d891a2b18cc5ec5551682c24515a)
- deploy [`5329377`](https://github.com/frugan-it/docker-bitnami-apache/commit/5329377440f42d38791a6487728c983cbb92e38a)
- Added remoteip_module, security3, unique_id_module [`c6eee1b`](https://github.com/frugan-it/docker-bitnami-apache/commit/c6eee1b0e07bffa127f284a388a5900079a7b8fc)
- Added mod_evasive [`79ef8bf`](https://github.com/frugan-it/docker-bitnami-apache/commit/79ef8bf4dffee0aa626ec33cdcac7ddc02510199)
- Moved export APACHE_ARGUMENTS to Dockerfile [`20b7f4a`](https://github.com/frugan-it/docker-bitnami-apache/commit/20b7f4aecbfbd58850d5536d5325226c9cf99436)
- Attempt to fix modsecurity log file [`cbdacdf`](https://github.com/frugan-it/docker-bitnami-apache/commit/cbdacdff3f399e93039e984a1654148531dcf8c8)
- Added mod_ldap and mod_evasive [`fabcb7c`](https://github.com/frugan-it/docker-bitnami-apache/commit/fabcb7c5c02432065dafe755f2bbd42db5b78c82)
- Added /pagespeed admin page [`0caf812`](https://github.com/frugan-it/docker-bitnami-apache/commit/0caf8127cfc74e11eb2760527eb8c6b69753669e)
- Updated pagespeed require group [`7f7c872`](https://github.com/frugan-it/docker-bitnami-apache/commit/7f7c8723bcb892bb97c9b7d73d601f481099f2f2)
- Attempt to update entrypoint [`06e9af7`](https://github.com/frugan-it/docker-bitnami-apache/commit/06e9af7aabf0df2bac27af5562cf8217e69712c1)
- Added tabs [`bdc5aed`](https://github.com/frugan-it/docker-bitnami-apache/commit/bdc5aed39ab617f8d3c3e708e2a00075e780e1a5)
- Fixed mod_evasive build [`c0e89f3`](https://github.com/frugan-it/docker-bitnami-apache/commit/c0e89f3fe72a5240f07ecab1d8b348a3277fe508)
- Typo [`5ea0b45`](https://github.com/frugan-it/docker-bitnami-apache/commit/5ea0b45e28c4f986e3ead64d2b6560ead2866857)
- Fixed mod_evasive [`b7c131e`](https://github.com/frugan-it/docker-bitnami-apache/commit/b7c131e48e84dcfdc817520cd570de651e73fd34)
- Restored pagespeed filters [`fe7d101`](https://github.com/frugan-it/docker-bitnami-apache/commit/fe7d101644cdad4875f959641e8c1dcd427f96c8)
- Typo [`1b80908`](https://github.com/frugan-it/docker-bitnami-apache/commit/1b809080fea1a2cc1852ecf365777cc342261942)
- Added IfModule [`bd16910`](https://github.com/frugan-it/docker-bitnami-apache/commit/bd16910bb97b71a52d0b84f24213d4faa2ac7851)
- Deploy [`9da62e5`](https://github.com/frugan-it/docker-bitnami-apache/commit/9da62e5a389b462650e1382e3c55c8bdccb34f5a)
- Updated pagespeed configuration [`45083ca`](https://github.com/frugan-it/docker-bitnami-apache/commit/45083ca44c73b06443609ce782e337e16b3d9709)
- Updated Dockerfile [`4fbee8a`](https://github.com/frugan-it/docker-bitnami-apache/commit/4fbee8a1b36d1ddc625d5b8a8518397fc29967fe)
- Updated CHANGELOG [`452050e`](https://github.com/frugan-it/docker-bitnami-apache/commit/452050ee15e6d23528a7441d48df32b072bed0d7)
- Attempt to fix mod_evasive [`6050d79`](https://github.com/frugan-it/docker-bitnami-apache/commit/6050d796be07004c0b5e95ff1c1173aedfb28aef)
- Redirect modsec_audit.log to /dev/stdout [`4996e96`](https://github.com/frugan-it/docker-bitnami-apache/commit/4996e967e15cfae962e5dae2588aa81d934e10fc)
- Added ModPagespeedRewriteLevel PassThrough [`f122ac1`](https://github.com/frugan-it/docker-bitnami-apache/commit/f122ac130a7346204437718e80849980dd17a3fa)
- Disabled mpm_prefork_module and enabled mpm_event_module https://community.bitnami.com/t/unable-to-enable-http-2-support/67229/7 [`903d2b4`](https://github.com/frugan-it/docker-bitnami-apache/commit/903d2b4f407a13038ae57cde501bee67f47fbfc8)
- Typo [`85dbcc1`](https://github.com/frugan-it/docker-bitnami-apache/commit/85dbcc129e3388eb371eafd15f7d118756ffe1fc)
- Attempt to fix "command returned a non-zero code 1" [`770267a`](https://github.com/frugan-it/docker-bitnami-apache/commit/770267af7e46b29264983e9c6a7b94c7c65f64a9)
- modsec_audit.log perms [`dc764d1`](https://github.com/frugan-it/docker-bitnami-apache/commit/dc764d13c326af69afdc55f40ccaf85e7d239940)
- Typo [`f2ee3af`](https://github.com/frugan-it/docker-bitnami-apache/commit/f2ee3af1933d9f60565ead16e03b767f86867d54)
- Attempt to use bash in entrypoint [`0d478e9`](https://github.com/frugan-it/docker-bitnami-apache/commit/0d478e99e3de3b394c3ea34d44f9e55a92c2c48a)
- Typo [`5bd05ca`](https://github.com/frugan-it/docker-bitnami-apache/commit/5bd05ca842d0b089ea7a2701992a6ddbe18cb2d4)
- Typo [`4951148`](https://github.com/frugan-it/docker-bitnami-apache/commit/4951148007cfddb7da7b21570f930f46b292a6cc)
- Updated README [`2eb0017`](https://github.com/frugan-it/docker-bitnami-apache/commit/2eb00178c208871d66fced08ba704ccddb465fe4)
- deploy [`2e57daf`](https://github.com/frugan-it/docker-bitnami-apache/commit/2e57daf0b9b66d9c00d6f4165bfa2a9ea0941852)
- Attempt to use only insert_ga filter [`766ed8f`](https://github.com/frugan-it/docker-bitnami-apache/commit/766ed8f6c4e34645e4b179c8f1f073cb03e0c190)
- Merge tag 'v1.1.0' into develop [`33a7c06`](https://github.com/frugan-it/docker-bitnami-apache/commit/33a7c06921291aceb5486327e30049990c09b98d)

## [v1.1.0](https://github.com/frugan-it/docker-bitnami-apache/compare/v1.0.0...v1.1.0) - 2020-02-05

### Commits

- Updated README [`b5df917`](https://github.com/frugan-it/docker-bitnami-apache/commit/b5df9172c3b46ca7dd768702b2cd6c9f179be223)
- Updated ARG and ENV variables [`92478b8`](https://github.com/frugan-it/docker-bitnami-apache/commit/92478b82d06874261e8873c67790f3ab5f40450d)

## v1.0.0 - 2020-01-04

### Commits

- Initial commit [`0c9cce6`](https://github.com/frugan-it/docker-bitnami-apache/commit/0c9cce6c73e071796f873c7f0f74be3e2361abfc)

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Generated by [`auto-changelog`](https://github.com/CookPete/auto-changelog).

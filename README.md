devenv
======

A base development environment

config.json
===========

Example `config.json` file:

```json
{
    "git": {
        "user": {
            "name": "James Allen",
            "email": "code@james-allen.co.uk"
        }
    },
    "proxy": {
        "useSystemProxy": true
    },
    "npm": {
        "useSystemProxy": true,
        "registry": "http://mynpmregistry.org/"
    }
}
```

TODOs
=====

- [x] Configure using a json file
- [ ] Test different configurations


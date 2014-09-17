# devenv

A base development environment

## config.json

You can specify a config file to use, or it will default to `config.json`. The options supported are:

option               | required | comments
-------------------- |:--------:|---------
git.user.name        | yes      |  
git.user.email       | yes      |  
syncedFolders        | no       | An array of `{source, dest}`
proxy.useSystemProxy | no       |
npm.useSystemProxy   | no       |
npm.registry         | no       | Use if you host your own (internal) npm registry
hosts                | no       | An array of `{ip, names}` where `names` is an array of string

### Example `config.json`

```json
{
    "git": {
        "user": {
            "name": "James Allen",
            "email": "someone@somewhere.com"
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

## TODOs

- [x] Configure using a json file
- [x] Add SyncedFolders to config
- [x] Add Host entries to config
- [ ] Test different configurations


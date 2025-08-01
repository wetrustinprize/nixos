![wakatime](https://wakatime.com/badge/user/62406d74-62af-473b-beac-7c728aadb90d/project/e89757e4-b98b-400d-a463-c2a5f3d3a2c3.svg?style=flat-square)

---

<div align="center">
    <img width="40%" src="nyx.webp"/>
    <div width="40%">
        <h1>Prize's <strong>NixOS</strong></h1>
        <p>Welcome to my gigantic NixOS configuration repo.</p>
    </div>
</div>

---

```
.
├── hosts/
│   └── <hostname>/ # per machine nixos config
├── users/
│   └── <username>/ # per user home-manager config
│       ├── hosts/
│       │   └── <hostname>/ # per machine additional user config
│       └── modules/
└── utils/
```

The structure of the repository follow as above, this NixOS repository holds all my machines _(that uses nixos)_ and uses [home-manager](https://github.com/nix-community/home-manager) to configure the users packages and configurations.

Feel free to use this repository as a template for your own or take any piece of it to use in your configuration.

<div align="center">
    <img width="40%" src="nyx.webp"/>
    <div width="40%">
        <h1>Prize's <strong>NixOS</strong></h1>
        <p>Welcome to my gigantic NixOS configuration repo.</p>
    </div>
</div>

This is the 3rd iteration of my NixOS configuration, but now this will be the last one. _(I hope)_

Currently using [flake-parts](https://flake.parts/) for organizing in modules (semi-dendritic pattern?), here are some
guides so I don't ever forget how to use it _lol_.

---

# First password

Here we are using [sops-nix](https://github.com/Mic92/sops-nix) for secrets handling, this includes the `wetrustinprize`
user password; it only changes the correct password when the `.age` key is provided, if no key is present the password
defaults to `change-me`.

# flake-file

The flake uses [flake-file](https://flake-file.oeiuwq.com/) to organize the inputs, everytime there is a new input in a
module this must be run to update the `flake.nix` file with the correct inputs and flatten it:

```shell
$ nix run .#write-flakes
```

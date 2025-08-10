# Nix Config

## Secrets

Create `secrets.nix` from the `secrets.example.nix` template and add your values.

## Initial Setup

```bash
$ nix run nix-darwin -- switch --flake .
```

## Build System

```bash
$ darwin-rebuild switch --flake .
```

## Update Dependencies

```bash
$ nix flake update
$ darwin-rebuild switch --flake .
```

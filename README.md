# Nix Config

## Secrets

Create `secrets.nix` from the `secrets.example.nix` template and add your
values.

Nix flakes require all files referenced by the flake to be tracked in Git. The
`pre-commit` hook prevents accidentally committing `secrets.nix`:

```bash
$ cp pre-commit .git/hooks/pre-commit
```

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

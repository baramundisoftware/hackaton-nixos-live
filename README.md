# Hackaton Custom NixOS Live Linux

Whether for setup, backup, recovery, forensics, wiping, or just for surfing, your own customized live Linux, whether as an ISO or USB stick, quickly becomes a useful companion in everyday IT life. This hackathon will show you how easy it is to create your own image with NixOS(-generators).

This repository provides a sample configuration for the Hackerkiste event taking place on 25.10.2024. No active maintenance.

## Run Virtual Machine (Linux)

```console
> $(nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-24.05 -I nixos-config=./configuration.nix --no-out-link)/bin/run-nixos-vm -smp 4 -m 2048
```

## Connect to QEMU VNC

```console
> nix-shell -p tigervnc --command "vncviewer localhost:5900"
```

## Build ISO (Linux and WSL)

```console
> nix-shell -p nixos-generators --command 'cp $(nixos-generate -c configuration.nix -I nixpkgs=channel:nixos-24.05 -f iso) nixos-custom.iso'
```

## Run ISO on NixOS
```console
> nix-shell -p qemu --command 'qemu-kvm -cdrom ./nixos-custom.iso -m 2048 -smp 4 -device virtio-vga'
```


# ISO

```bash
cd debian
lb clean
lb config
qemu-system-x86_64 -enable-kvm -cpu host -m 2048 -smp 4 -drive media=cdrom,format=raw,file=live-image-amd64.iso -boot d
```


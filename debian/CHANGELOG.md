# Changelog

- VirtualBox Guest Additions autoinstall when needed
- Packages added: arandr, gdb, clang-format, strace, ltrace, libcriterion-dev, jq, cryptsetup-initramfs
- Update docker-compose to docker compose v2
- Support for LVM and LUKS (read [Encryption (LUKS)](./README.md) for LUKS fix)
- No more implicit location on grub install
- GPG key creation
- Fix for `apt upgrade` crashing on raspi-firmware error (observed on kernel update from 6.1.0-26-amd64 to 6.1.0-28-amd64)

&nbsp;

### **Reconstruct ISO with**

- Windows

```cmd
type nucleus-amd64_part* > nucleus-amd64.iso
certutil -hashfile nucleus-amd64.iso SHA256
:: <checksum placeholder>
```

- Linux

```bash
cat nucleus-amd64_part* > nucleus-amd64.iso
sha256sum -c nucleus.sha256
# <checksum placeholder>
```

### Passwords

- Normal install : `pass`
- Live boot : `live`


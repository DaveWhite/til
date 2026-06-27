# NVIDIA Open Module Modprobe Config

When switching to the NVIDIA open kernel module (the `nvidia-open` driver), some modprobe settings left over from the proprietary driver era become wrong or irrelevant — and one is actively harmful if you're on a desktop GPU.

## The stale settings

On CachyOS, `/usr/lib/modprobe.d/nvidia.conf` contained:

```
options nvidia NVreg_UsePageAttributeTable=1
options nvidia NVreg_DynamicPowerManagement=0x02
```

- `NVreg_UsePageAttributeTable=1` — ignored by the open module entirely (it manages this itself). Harmless, just noisy.
- `NVreg_DynamicPowerManagement=0x02` — **this one matters**. It's intended for Turing-era mobile GPUs (laptops). On a desktop Ada GPU like the RTX 4080 Super, it's the wrong value.

## The fix

Rather than editing files under `/usr/lib/` (which get overwritten on package updates), create an override in `/etc/modprobe.d/`:

```bash
sudo tee /etc/modprobe.d/nvidia-override.conf <<'EOF'
# Override stale settings from /usr/lib/modprobe.d/nvidia.conf
# DynamicPowerManagement=0x02 is for Turing mobile only; not applicable on desktop Ada
options nvidia NVreg_DynamicPowerManagement=0x01
EOF
```

Then rebuild the initramfs and reboot:

```bash
sudo mkinitcpio -P
sudo reboot
```

## Also: remove libva-nvidia-driver

If you're getting VA-API decode errors in Chromium or Firefox (visible in `about:gpu` or in the terminal when launching the browser), remove `libva-nvidia-driver`:

```bash
sudo pacman -R libva-nvidia-driver
```

This package attempts to bridge NVIDIA and VA-API but conflicts with how the open module handles hardware video decode. Removing it clears the errors.

## Xid 69 / Xid 32 on Wayland

The open kernel module can also produce **Xid 69 (MMU fault) and Xid 32 (GPU channel errors)** if a GPU benchmark (like glmark2) and a GPU-accelerated browser (like Chromium) are competing for the GPU simultaneously under Wayland. The symptom is kwin_wayland freezing, requiring a hard reset. Don't run GPU stress tools and a hardware-accelerated browser at the same time.

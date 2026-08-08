<h2 align="center">OrangeFox Recovery Device Tree for Daria Bond II (hormoz)</h2>

<p align="center">
  <i>The Daria Bond II (codename <b>"hormoz"</b>) is a flagship-tier smartphone from Daria.</i>
</p>

---

## Device Specifications

| Item | Details |
| --- | --- |
| **SoC** | MediaTek Dimensity 8350 (mt6897) |
| **CPU** | Octa-core (1×3.35 GHz + 3×3.2 GHz + 4×2.2 GHz) |
| **GPU** | Mali-G615 |
| **Memory** | 12 GB LPDDR5X |
| **Storage** | 512 GB UFS 4.0 |
| **Display** | 6.67" AMOLED, 1220 × 2712, 120 Hz |
| **Rear Camera** | 50 MP + 8 MP + 8 MP |
| **Front Camera** | 50 MP |
| **Battery** | 5000 mAh |
| **Shipped Android Version** | 14 (DariaOS 5.0) |
| **Partition Layout** | A/B (Virtual A/B), dynamic partitions, recovery in `vendor_boot` |
| **TEE** | Trustonic (Kinibi) |

---

## Status

Current build status: **Stable**

**Working**
- [x] Touchscreen
- [x] Display / brightness
- [x] Kernel module loading (vendor_boot DLKM)
- [x] ADB sideload
- [x] Backup / restore
- [x] Fastbootd
- [x] ADB sideload
- [x] Backup / restore
- [x] Fastbootd
- [x] Battery information
- [x] MTP
- [x] USB OTG

**Not working**
- [ ] Decryption (crypto is disabled in this tree by design)
- [ ] Vibrator (no vendor vibrator HAL shipped yet)
---

## Building

Full OrangeFox compile guide: https://wiki.orangefox.tech/en/dev/building

Clone this tree to `device/daria/hormoz`, then:


**Sync manifest ofrp-14.1**
```bash
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 14.1 --path ~/fox_14.1
```

```bash
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch twrp_hormoz-ap2a-eng
m vendorbootimage
```

The output is `vendor_boot.img` — this device has no dedicated `recovery`
partition, so flash with:

```bash
fastboot flash vendor_boot vendor_boot.img
```

---

### Copyright

```
  /*
  *  Copyright (C) 2026 The OrangeFox Recovery Project
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  */
```

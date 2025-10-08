# TWRP Teste para Moto G54 (cancunf)

Este projeto contém os arquivos necessários para compilar uma versão de teste do TWRP para o **Motorola Moto G54** (codinome **cancunf**).

- Essa e apenas uma continuação para o projeto final

> ⚠️ Requer Ubuntu 20.04 ou superior (ou Debian baseado)

---

## 🔧 Requisitos

### Pacotes necessários:

```bash
sudo apt update && sudo apt install -y \
  bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf \
  imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool \
  libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush \
  rsync schedtool squashfs-tools xsltproc zip zlib1g-dev openjdk-8-jdk \
  python-is-python3 repo

crie a sua pasta
mkdir -p ~/twrp-cancunf && cd ~/twrp-cancunf

inicie o repo na sua pasta
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

# Sincronizar
repo sync -j$(nproc) --force-sync

export ALLOW_MISSING_DEPENDENCIES=true
lunch omni_cancunf-eng
mka b -j$

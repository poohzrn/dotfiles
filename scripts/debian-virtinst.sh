#!/bin/bash -e

WORKDIR=`dirname $0`
CONFIG_FILE=$WORKDIR/config.sh
[ -f $CONFIG_FILE ] && source $CONFIG_FILE

SUPPORTED="(testing|Debian8.5)"
ARCH=amd64
SITE=${DEBIAN_SITE:-http://dk.archive.ubuntu.com/debian/}
DISKIMG_DIR=${DISKIMG_DIR:-$HOME/images}
ISO_DIR=${UBUNTU_ISO_DIR:-$HOME/iso/}
NTPSERVER=${NTPSERVER:-dk.pool.ntp.org}

#Defaults: 
USERNAME=linux
# Unless password is specified NAME is used for password by default
#PASSWORD=
NUM_CPU=1
MEMORY=4096
DISKSIZE=10G
DISKFORMAT=qcow2

# You can use the following keyword
# %ISO_DIR%
# %ARCH%
# %RELEASE_NAME% : precise, quantal, ....
# %RELEASE_VERSION% : 12.04, 12.10, ....
# %RELEASE_FULLVER% (including minor version for LTS) : 12.04.3, 10.04.4
ISO_LOCATION_FORMAT_DEFAULT=%ISO_DIR%/%RELEASE_FULLVER%-%ARCH%.iso
ISO_LOCATION_FORMAT=${ISO_LOCATION_FORMAT:-$ISO_LOCATION_FORMAT_DEFAULT}

function usage() {
    cat <<EOF
Usage: $0 [options] NAME RELEASE

Options:
  -a ARCH       : VM architecture: x86_64, i386 (default: $ARCH)
  -c NUM_CPU    : VM number of CPU (default: $NUM_CPU)
  -m MEMORY     : VM memory size [MB] (default: $MEMORY)
  -f DISKFORMAT : QEMU image format: qcow2, raw (default: $DISKFORMAT)
  -s DISKSIZE   : QEMU image size, e.g., 50G (default: $DISKSIZE)
  -u USERNAME   : Username of the default user (default: $USERNAME)
  -p PASSWORD   : Password for the default user (default: $PASSWORD)
  -P            : Do not use preseed.cfg

Configurations:
  DISKIMG_DIR=$DISKIMG_DIR
  SITE=$SITE
  PROXY=$PROXY
  ISO_DIR=$ISO_DIR
  ISO_LOCATION_FORMAT=$ISO_LOCATION_FORMAT
EOF
    exit 1
}

while getopts "a:c:m:f:s:u:p:Ph" OPT; do
    case $OPT in
        a) ARCH=$OPTARG
           if [ "$ARCH" != "i386" -a "$ARCH" != "amd64" ]; then
               echo "Arch must be either amd64 or i386."
               exit 1
           fi
           ;;
        c) NUM_CPU=$OPTARG; ;;
        m) MEMORY=$OPTARG; ;;
        f) DISKFORMAT=$OPTARG
           if [ "$DISKFORMAT" != "qcow2" -a "$DISKFORMAT" != "raw" ]; then
               echo "Disk format must be either qcow2 or raw."
               exit 1
           fi
           ;;
        s) DISKSIZE=$OPTARG; ;;
        u) USERNAME=$OPTARG; ;;
        p) PASSWORD=$OPTARG; ;;
        P) NO_PRESEED=true; ;;
        ?) usage
           ;;
    esac
done
shift `expr $OPTIND - 1`

if [ -z "$1" ]; then
    echo "Name must be specified!"
    usage
    exit 1
fi

if [ -z "$2" ]; then
    echo "release must be specified! $SUPPORTED"
    echo "Usage: $0 [options] NAME RELEASE"
    exit 1
fi

NAME=$1
DISK=$DISKIMG_DIR/$NAME.img

if [ -z "$PASSWORD" ]; then
    PASSWORD=$NAME
fi

RELEASE_NAME=$2
if [[ ! "$RELEASE_NAME" =~ $SUPPORTED ]]; then
    echo "Release '$RELEASE_NAME' is not supported."
    echo "$SUPPORTED must be specified"
    exit 2
fi

if [ "$ARCH" == "amd64" ]; then
    VIRT_ARCH=x86_64
else
    VIRT_ARCH=i386
fi
case "$RELEASE_NAME" in
  testing)
    RELEASE_FULLVER=debian8
    ;;
  Debian8.5)
    RELEASE_FULLVER=debian8
    ;;
esac
if [ -z "$OS_VARIANT" ]; then
  OS_VARIANT=${RELEASE_FULLVER}
fi

LOCATION=$SITE/dists/$RELEASE_NAME/main/installer-$ARCH/
if [ -n "$RELEASE_FULLVER" ]; then
    RELEASE_VERSION=`echo $RELEASE_FULLVER | cut -d . -f 1-2`
    ISO_LOCATION=`echo $ISO_LOCATION_FORMAT | sed \
                      -e "s|%ISO_DIR%|$ISO_DIR|g" \
                      -e "s|%ARCH%|$ARCH|g" \
                      -e "s|%RELEASE_NAME%|$RELEASE_NAME|g" \
                      -e "s|%RELEASE_VERSION%|$RELEASE_VERSION|g" \
                      -e "s|%RELEASE_FULLVER%|$RELEASE_FULLVER|g" \
                 `
    if [ -f $ISO_LOCATION ]; then
        LOCATION=$ISO_LOCATION
    fi
fi

function create_disk() {
    if [ ! -f $DISK ]; then
        qemu-img create -f $DISKFORMAT $DISK $DISKSIZE
    fi
}

function virtinst_without_preseed() {
    sudo virt-install \
        --name $NAME \
        --os-type linux \
        --os-variant debian${RELEASE_NAME} \
        --virt-type kvm \
        --connect=qemu:///system \
        --vcpus $NUM_CPU \
        --ram $MEMORY \
        --arch $VIRT_ARCH \
        --serial pty \
        --console pty \
        --disk=$DISK,format=qcow2,bus=virtio \
        --nographics \
        --location $LOCATION \
        --extra-args "console=ttyS0,115200" \
        --network network=default,model=virtio
}

create_disk
virtinst_without_preseed

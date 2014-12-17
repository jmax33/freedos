#!/bin/bash

#######################################
# create usb bootable with freedos OS #
#######################################




USB_DISK='/dev/'$1
FREE_DOS_IMG='FreeDOS-1.1-memstick-2-2048M.img'
FREE_DOS_BZ2=$FREE_DOS_IMG'.bz2'
GET_FREE_DOS='http://ftp.chtaube.eu/pub/FreeDOS/bootable-usb/'$FREE_DOS_BZ2

RSP_YES='yes'

echo 'creating img to '$USB_DISK ' ' $#

if [ -e $USB_DISK ] &&  [ $# -eq 1 ]
then
  if [ ! -e $FREE_DOS_IMG ]
  then
    if [ ! -e $FREE_DOS_BZ2 ]
    then
      wget $GET_FREE_DOS
    fi
    bunzip2 $FREE_DOS_BZ2
  fi
  echo 'copy '$FREE_DOS_IMG' to '$USB_DISK' '$RSP_YES' or no'
  read rsp
  if [ $rsp = $RSP_YES ]
  then
    dd if=$FREE_DOS_IMG of=$USB_DISK bs=512k
    sync
  fi
else
  echo $USB_DISK ' missed'
fi

#!/bin/bash
sudo vmware-modconfig --console --install-all
sudo modprobe vmmon
sudo modprobe vmw_vmci
systemctl start vmware
vmware &

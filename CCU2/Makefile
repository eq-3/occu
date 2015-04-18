BUILDROOT_VERSION=2012.08

all:
	@echo "Usage: "
	@echo "\tmake updateConfig | compile | clean "

updateConfig:
	cp templates/Image-eQ-3-SDK.config buildroot-$(BUILDROOT_VERSION)/.config 

clean:
	rm -rf buildroot-$(BUILDROOT_VERSION)/output

compile:
	make -C buildroot-$(BUILDROOT_VERSION)

create_firmware_update:
	rm -rf work/update
	mkdir work/update
	cp work/buildroot-2012.08/output/images/rootfs.ubi work/update
	cp work/buildroot-2012.08/output/images/uImage work/update
	cp ../../Source/update_script work/update
	cd work/update; tar zcvf ../firmware_update.tar.gz *


HomeMatic-Open-Central-Control-Unit-SDK (HM-OCCU-SDK)

Content
=======

- CPU Support
- Binary Packages
- CCU2 Toolchain 
- Support
- Version History

CPU Support
===========

The HM-OCCU-SDK contains several binary packages for different CPU
architectures. 
The CPU architectures are tested on the following hardware:

subfolder arm-gnueabihf: 
- Raspberry Pi 
- Cubietruck (Cubian)

subfolder X86_32:
- Debian Wheezy

subfolder mips:
- vu+ solo² with vti Image

The script install.sh in the cpu specific subfolder copies all binary packages
to /opt/hm. 
This script is just an example and can be enhanced by the community. Some Linux
distributions like OpenELEC have a readonly root filesystem, so the
installation script must be changed (replace /opt/hm by /storage/hm).

Further CPU specific information can be found in the CPU architecture specific
subfolder.

Binary Packages
=============== 
Each CPU subfolder contains the following binary packages:

- subfolder packages-eQ-3/RFD: Radio Frequency Daemon 
- subfolder packages-eQ-3/HS485D: (wired) HS485 Daemon
- subfolder packages-eQ-3/WebUI: pre-alpha many CCU2 specific functions must be replaced
- subfolder packages/lighttpd: preconfigured HTTP daemon

CCU2 Toolchain
==============
With the CCU2 toolchain it is possible to compile C/C++ programms and build
installable CCU2 add-ons. 
It is also possible to build CCU2 images with additional software, e.g. the
Email add-on, which can be installed as normal CCU2 updates. A tutorial on how
to create a customized CCU2 Image will be published after the "HomeMatic User
Treffen 2015" (April 18th/19th 2015).

Support
=======
The HM-OCCU-SDK is provided free of charge. If you want any commercial support
pleace contact support@eq-3.de.

Version History
===============

2015-04-02: Version 1.0.0
- First initial version, no change history.

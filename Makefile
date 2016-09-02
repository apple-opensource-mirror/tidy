##
# Makefile for tidy
##

# Project info
Project               = tidy
UserType              = Administrator
ToolType              = Libraries

# It's a GNU Source project
include $(MAKEFILEPATH)/CoreOS/ReleaseControl/Common.make

#Install_Target = install-strip
lazy_install_source:: shadow_source

install::
	RANLIB=ranlib CFLAGS="$(CFLAGS) -fno-common" runinst_prefix="$(DSTROOT)/usr" devinst_prefix="$(DSTROOT)/usr" $(MAKE) -C "$(OBJROOT)/$(Project)/build/gmake" install devinst_prefix="$(DSTROOT)/usr" runinst_prefix="$(DSTROOT)/usr"
	$(CC) $(CFLAGS) -dynamiclib -o "$(DSTROOT)/usr/lib/libtidy.A.dylib" "$(DSTROOT)/usr/lib/libtidy.a" -install_name "/usr/lib/libtidy.A.dylib" -all_load -exported_symbols_list "tidy.exp" -compatibility_version 1.0.0 -current_version 1.0.0
	strip "$(DSTROOT)/usr/bin/tab2space"
	strip "$(DSTROOT)/usr/bin/tidy"
	strip -x "$(DSTROOT)/usr/lib/libtidy.A.dylib"
	ln -s "libtidy.A.dylib" "$(DSTROOT)/usr/lib/libtidy.dylib"
	rm -f "$(DSTROOT)/usr/lib/libtidy.a"


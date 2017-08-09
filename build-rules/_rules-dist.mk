# For no binary, only library case, not needed
#
#	    if  [ ! -f $(SYSROOT_LIB)/lib$(COMP_LIB_NAME).a ] && \
#	        [ ! -f $(SYSROOT_LIB)/lib$(COMP_LIB_NAME).so ]; then \
#	        $(call Build_CompLib, FORCE) \
#	    fi; \
#

final-out: sub-mods
	$(TOP_Q) \
	if [ -f $(STAMP_PRJ_CFG) ]; then true; else \
	    rm -rf $(DIST_DIR); \
	    mkdir -p $(DIST_DIR) $(FINAL_DIR); \
	    for i in bin lib include; do \
	        if [ -d $(OUTPUT_DIR)/usr/$${i} ]; then \
	            cp -rf $(OUTPUT_DIR)/usr/$${i} $(FINAL_DIR); \
	        fi; \
	    done; \
	fi

	$(TOP_Q)$(STRIP) $(FINAL_DIR)/bin/*
	$(TOP_Q)$(STRIP) --strip-debug $(FINAL_DIR)/lib/*

	$(TOP_Q)$(call $(POST_FINAL_OUT_HOOK))

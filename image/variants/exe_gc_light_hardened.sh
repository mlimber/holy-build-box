source /hbb/activate_func.sh
activate_holy_build_box /hbb_exe_gc_light_hardened \
	"-ffunction-sections -fdata-sections -fPIE" \
	"-static-libstdc++ -Wl,--gc-sections -pie -Wl,-z,relro" \
	"-ffunction-sections -fdata-sections -fPIE" \
	"-ffunction-sections -fdata-sections -fPIC" \
	"-static-libstdc++"

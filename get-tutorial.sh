curl -SL https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_low_res_mandatory.tar.gz | tar -xz --strip-components 1 -C WPS_GEOG
curl -SL https://www2.mmm.ucar.edu/wrf/TUTORIAL_DATA/colorado_march16.new.tar.gz | tar -xz --strip-components 1 -C wrfinput
curl -SL http://www2.mmm.ucar.edu/wrf/src/namelists_v4.0.2.tar.gz | tar -xz --strip-components 1 -C wrfinput
curl -SL http://www2.mmm.ucar.edu/wrf/TUTORIAL_DATA/WRF_NCL_scripts.tar.gz | tar -xzC .

STARFM-modeling results
---------------------------------------------------------------------------------------------------------------------------------------------------
Simulated daily NDVI time-series at 30m pixel resolution
 
data used:
- 
	Landsat (p194r024) for 2011112 2011120 2011128 2011160 2011168 2011208 2011232 2011272 2011288 2011296
- 
	MODIS (h18v03) daily surface reflectance (MOD09GQ, 250m) for 2011 were adjusted to nadir BRDF-adjusted 

	reflectance using MCD43A1(BRDF parameters, 500m).
	cloud and cloud shadows in Landsat and MODIS were excluded according data quality flags


Landsat and MODIS data pairs (mostly clear) used in data fusion:
	
2011112

        2011128

	2011208 (composited with 2011232)
	
2011272

	2011288

        (file "inpair.194024.txt" shows the prediction pair used for each day based on the higher correlation
between two near dates)


subset area (see ENVI header file)
upper left corner (630000.0, 5750000.0)
UTM zone 32
pixel resolution: 30m
lines: 2000
columns:2500


STARFM results:
plndsr_250.194024.2011*.ndvi.bin: fused MODIS-Landsat NDVI (computed from fused band3 and band4)

sub_lndsr.194024.2011*.ndvi.bin: original Landsat NDVI

NDVI_194024.2011.meta
(ENVI metadata file that combines the fused and original Landsat NDVI)

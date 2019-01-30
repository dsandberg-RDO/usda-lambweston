SELECT        
CONVERT(NVARCHAR(2), m.Farm_Region) + '_' + CONVERT(NVARCHAR(3), m.Farm_ID) + '_' + CONVERT(NVARCHAR(10), f.Field_ID) + '_' + CONVERT(NVARCHAR(10), a.Truck_Agro_ID) AS FarmFieldUSDAInspectionID, 
a.agro_crop_year AS CropYear, 
m.Farm_ID AS FarmID, 
dbo.fnFarmName(a.Field_ID) FarmName, 
a.Field_ID AS FieldID, 
f.Fld_Number AS FieldNumber, 
dbo.fnFieldName(a.Field_ID) AS Field, 
lics.Crop_Variety_ID AS VarietyID, 
dbo.fnVarietyName(lics.Crop_Variety_ID) AS Variety, 
a.Processor_ID AS ProcessorID, a
.Contract_Number AS ContractNumber, 
a.Truck_Agro_ID AS InspectionID, 
a.Report_number AS ReportNumber, 
a.Deliver_Date AS DeliveryDate, 
a.Net_sample_weight_lbs AS BinSampleWeight, 
a.Graded_weight_lbs AS InspectedWeight, 
early.price_per_cwt AS EarlyPrice, 
a.US1_10_above_lbs + a.US2_10oz_lbs AS TenOuncePounds, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4') THEN ten.price_per_cwt 
				 ELSE 0 
			END 
	WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN ten.price_per_cwt 
				 ELSE 0 
			END 
	WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN ten.price_per_cwt 
				 ELSE 0 
			END 
	WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN ten.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN twelve.price_per_cwt 
			ELSE 0 
	END 
END AS TenIncentive, 
a.US1_6_9oz_lbs + a.US1_7_9oz_lbs + a.US1_10_above_lbs + a.US2_6_9oz_lbs + a.US2_7_9oz_lbs + a.US2_10oz_lbs AS SixOuncePounds, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN six.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN six.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN six.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN six.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN 
						CASE WHEN a.report_number IN ('101411') THEN 0.65 
							 ELSE six.price_per_cwt 
						END 
				 ELSE 0 
			END 
	END AS SixIncentive, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN six.price_simplot 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN six.price_simplot 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN six.price_simplot 
				 ELSE 0 
			END 
	WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN six.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN 
						CASE WHEN a.report_number IN ('101411') THEN 0.65 
							 ELSE six.price_simplot 
						END 
				 ELSE 0 
			END 
END AS SixIncentive_Simplot, 

a.US1_7_9oz_lbs + a.US1_10_above_lbs + a.US2_7_9oz_lbs + a.US2_10oz_lbs AS SevenOuncePounds, 

CASE WHEN a.agro_crop_year IN (2012) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
END AS SevenIncentive, 
a.Bruise_Free_cnt AS BruiseFreeCount, 
a.Bruise_Free_cnt + a.Bruised_cnt AS BruiseFreeSampleCount, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN bf.price_per_cwt END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN bf.price_per_cwt END 
	WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN bf.price_per_cwt END 
	WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN bf.price_per_cwt END 
END AS BruiseFreeIncentive,
a.Rock_lbs + a.DVFM_lbs + ISNULL(a.DVFM_VegMat_lbs, 0) AS DRVFMPounds, 
CASE WHEN a.agro_crop_year IN (2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4') THEN dfm.price_per_cwt 
				 WHEN a.contract_number IN ('5') THEN 0 
				 WHEN a.contract_number IN ('3') THEN dfm2.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN dfm.price_per_cwt END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN dfm.price_per_cwt END 
	WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN dfm.price_per_cwt END 
	WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN dfm.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN 
						CASE WHEN report_number IN ('101411') THEN 0.25 ELSE dfm.price_per_cwt END 
			END 
END AS DRVFMIncentive, 
CASE WHEN a.agro_crop_year IN (2017, 2018) THEN Isnull(a.late_blight_lbs, 0) + Isnull(a.freeze_lbs, 0) + Isnull(a.green_lbs, 0) + Isnull(a.insect_lbs, 0) + Isnull(a.insectother_lbs, 0) + 
												Isnull(a.other_lbs, 0) + Isnull(a.pink_eye_lbs, 0) + Isnull(a.pinkrot_lbs, 0) + Isnull(a.pit_scab_lbs, 0) + Isnull(a.soft_rot_lbs, 0) + 
												Isnull(a.sun_burn_lbs, 0) + Isnull(a.unusable_lbs, 0) + Isnull(a.wireworm_lbs, 0) + Isnull(a.discolored_lbs, 0) + 
												Isnull(a.hollow_lbs, 0) 
	 WHEN a.agro_crop_year = 2016 THEN Isnull(a.unusable_lbs, 0) 
	 ELSE Isnull(a.soft_rot_lbs, 0) + Isnull(a.freeze_lbs, 0) + Isnull(a.pink_eye_lbs, 0) + Isnull(a.hollow_lbs, 0) + Isnull(a.discolored_lbs, 0) + 
		  Isnull(a.pit_scab_lbs, 0) + Isnull(a.unusable_lbs, 0) + Isnull(a.late_blight_lbs, 0) + Isnull(a.insect_lbs, 0) + Isnull(a.ring_rot, 0) + 
		  Isnull(a.surface_scab, 0) 
END AS UnusablePounds, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN uu.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN uu.price_per_cwt END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN uu.price_per_cwt 
			END 
	WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN uu.price_per_cwt 
			END 
END AS UnusableIncentive, 
a.US1_min_lbs + a.US1_2_4oz_lbs + a.US1_6_9oz_lbs + a.US1_7_9oz_lbs + a.US1_10_above_lbs AS USDA1Pounds, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN U1.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN u1.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN u1.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN u1.price_per_cwt 
				 ELSE 0 
			END 
END AS USDA1Incentive, 
CASE WHEN a.specific_gravity > 0 THEN a.specific_gravity 
	 ELSE NULL 
END AS SpecificGravity, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4') THEN sg.price_per_cwt 
				 WHEN a.contract_number IN ('3', '5') THEN sg2.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN sg.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN sg.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '7') THEN sg.price_per_cwt 
				 WHEN a.contract_number IN ('3', '5') THEN sg2.price_per_cwt 
			END 
END AS SpecificGravityIncentive, 
a.Fungicide AS FungicidePounds, 
CASE WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN fung.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN fung.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN fung.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN fung.price_per_cwt 
			END 
END AS FungicideDisincentive, 

/* 9/20/2018 - Drew Sandberg */
/* Correcting 2018 soft rot pounds to include pink rot pounds */
CASE WHEN a.agro_crop_year IN (2018) THEN a.Soft_Rot_lbs + a.PinkRot_lbs
	 ELSE a.Soft_Rot_lbs + a.Ring_Rot
END AS SoftRotPounds, 



CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN rot.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN rot.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN rot.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN rot.price_per_cwt 
			END 
END AS SoftRotDisincentive, 
a.Rock_lbs AS RockPounds, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN rock.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN rock.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN rock.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN rock.price_per_cwt 
			END 
END AS RockDisincentive, 
ISNULL(a.RFM_percent, 0) AS RockFM, 
ISNULL(a.CFM_percent, 0) AS CornFM, 
ISNULL(a.WFM_percent, 0) AS WoodFM, 
ISNULL(a.OFM_percent, 0) AS OtherFM, 
ISNULL(BinRockFM.price_per_cwt, 0) AS BinRockDisincentive, 
ISNULL(BinCornFM.price_per_cwt, 0) AS BinCornDisincentive, 
ISNULL(BinWoodFM.price_per_cwt, 0) AS BinWoodDisincentive, 
ISNULL(BinOtherFM.price_per_cwt, 0) AS BinOtherDisincentive, 
a.DVFM_lbs AS DirtPounds, 
ISNULL(a.DVFM_VegMat_lbs, 0) AS VegetativeMatterPounds, 
a.PinkRot_lbs AS PinkRotPounds, 
a.Dry_Rot_lbs AS DryRotPounds, 
a.Pink_Eye_lbs AS PinkEyePounds, 
a.Undersize_lbs AS UndersizePounds, 
a.Late_Blight_lbs AS LateBlightPounds, 
a.Pit_Scab_lbs AS PitScabPounds, 
a.Surface_Scab AS SurfaceScabPounds, 
a.Wireworm_lbs AS WirewormPounds, 
a.Hollow_lbs AS HollowHeartPounds, 
a.discolored_lbs AS DiscoloredPounds, 
a.Freeze_lbs AS FreezePounds, 
a.Sun_Burn_lbs AS SunburnPounds, 
a.Green_lbs AS GreenPounds, 
a.Fry_0_strip AS FryStripColorZero, 
SUM(t.FirstNetPounds) / 100 AS FirstNetCWT, 
CASE WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('3', '5') THEN 
						CASE WHEN a.deliver_date = '2011-08-01' THEN base.base_price + 3.54 
							 WHEN a.deliver_date = '2011-08-02' THEN base.base_price + 3.42 
							 WHEN a.deliver_date = '2011-08-03' THEN base.base_price + 3.305 
							 WHEN a.deliver_date = '2011-08-04' THEN base.base_price + 3.185 
							 WHEN a.deliver_date = '2011-08-05' THEN base.base_price + 3.07 
							 WHEN a.deliver_date = '2011-08-06' THEN base.base_price + 2.95 
							 WHEN a.deliver_date = '2011-08-07' THEN base.base_price + 2.835 
							 WHEN a.deliver_date = '2011-08-08' THEN base.base_price + 2.715 
							 WHEN a.deliver_date = '2011-08-09' THEN base.base_price + 2.60 
							 WHEN a.deliver_date = '2011-08-10' THEN base.base_price + 2.48 
							 WHEN a.deliver_date = '2011-08-11' THEN base.base_price + 2.365 
							 WHEN a.deliver_date = '2011-08-12' THEN base.base_price + 2.245 
							 WHEN a.deliver_date = '2011-08-13' THEN base.base_price + 2.13 
							 WHEN a.deliver_date = '2011-08-14' THEN base.base_price + 2.01 
							 WHEN a.deliver_date = '2011-08-15' THEN base.base_price + 1.895 
							 WHEN a.deliver_date = '2011-08-16' THEN base.base_price + 1.775 
							 WHEN a.deliver_date = '2011-08-17' THEN base.base_price + 1.66 
							 WHEN a.deliver_date = '2011-08-18' THEN base.base_price + 1.54 
							 WHEN a.deliver_date = '2011-08-19' THEN base.base_price + 1.425 
							 WHEN a.deliver_date = '2011-08-20' THEN base.base_price + 1.305 
							 WHEN a.deliver_date = '2011-08-21' THEN base.base_price + 1.19 
							 WHEN a.deliver_date = '2011-08-22' THEN base.base_price + 1.095 
							 WHEN a.deliver_date = '2011-08-23' THEN base.base_price + 1.005 
							 WHEN a.deliver_date = '2011-08-24' THEN base.base_price + 0.91 
							 WHEN a.deliver_date = '2011-08-25' THEN base.base_price + 0.82 
							 WHEN a.deliver_date = '2011-08-26' THEN base.base_price + 0.725 
							 WHEN a.deliver_date = '2011-08-27' THEN base.base_price + 0.635 
							 WHEN a.deliver_date = '2011-08-28' THEN base.base_price + 0.54 
							 WHEN a.deliver_date = '2011-08-29' THEN base.base_price + 0.45 
							 WHEN a.deliver_date = '2011-08-30' THEN base.base_price + 0.355 
							 WHEN a.deliver_date = '2011-08-31' THEN base.base_price + 0.265 
							 WHEN a.deliver_date = '2011-09-01' THEN base.base_price + 0.17 
							 WHEN a.deliver_date = '2011-09-02' THEN base.base_price + 0.13 
							 WHEN a.deliver_date = '2011-09-03' THEN base.base_price + 0.085 
							 WHEN a.deliver_date = '2011-09-04' THEN base.base_price + 0.045 
							 ELSE base.base_price 
						END 
				WHEN a.contract_number IN ('4') THEN 
						CASE WHEN a.deliver_date = '2011-08-11' THEN base.base_price + 2.88 
							 WHEN a.deliver_date = '2011-08-12' THEN base.base_price + 2.63 
							 WHEN a.deliver_date = '2011-08-13' THEN base.base_price + 2.38 
							 WHEN a.deliver_date = '2011-08-14' THEN base.base_price + 2.13 
							 WHEN a.deliver_date = '2011-08-15' THEN base.base_price + 1.8 
							 WHEN a.deliver_date = '2011-08-16' THEN base.base_price + 1.73 
							 WHEN a.deliver_date = '2011-08-17' THEN base.base_price + 1.57 
							 WHEN a.deliver_date = '2011-08-18' THEN base.base_price + 1.39 
							 WHEN a.deliver_date = '2011-08-19' THEN base.base_price + 1.20 
							 WHEN a.deliver_date = '2011-08-20' THEN base.base_price + 1.01 
							 WHEN a.deliver_date = '2011-08-21' THEN base.base_price + 0.82 
							 WHEN a.deliver_date = '2011-08-22' THEN base.base_price + 0.75 
							 WHEN a.deliver_date = '2011-08-23' THEN base.base_price + 0.68 
							 WHEN a.deliver_date = '2011-08-24' THEN base.base_price + 0.62 
							 WHEN a.deliver_date = '2011-08-25' THEN base.base_price + 0.50 
							 WHEN a.deliver_date = '2011-08-26' THEN base.base_price + 0.46 
							 WHEN a.deliver_date = '2011-08-27' THEN base.base_price + 0.34 
							 WHEN a.deliver_date = '2011-08-28' THEN base.base_price + 0.18 
							 WHEN a.deliver_date = '2011-08-29' THEN base.base_price + 0.14 
							 WHEN a.deliver_date = '2011-08-30' THEN base.base_price + 0.09 
							 WHEN a.deliver_date = '2011-08-31' THEN base.base_price + 0.04 
							 WHEN a.deliver_date = '2011-09-01' THEN base.base_price + 0 
							 WHEN a.deliver_date = '2011-09-02' THEN base.base_price + 0.13 
							 WHEN a.deliver_date = '2011-09-03' THEN base.base_price + 0.085 
							 WHEN a.deliver_date = '2011-09-04' THEN base.base_price + 0.045 
							 ELSE base.base_price 
						END 
				ELSE base.base_price 
		END 
	ELSE base.base_price 
END AS BasePrice

FROM	dbo.vPBI_Summary_Truck_Load_Weight AS t 
			RIGHT OUTER JOIN dbo.Truck_Agronomic_Info AS a 
				ON t.CropYear = a.agro_crop_year 
				AND t.ReportNumber = a.Report_number 
				AND t.ReportNumber = a.Report_number 
				AND t.ContractNumber = a.Contract_Number 
			INNER JOIN dbo.field_info AS f 
				ON f.Field_ID = a.Field_ID 
			INNER JOIN dbo.Farm_Info AS m 
				ON m.Farm_ID = f.Farm_ID 
			INNER JOIN dbo.land_info_crop_schedule AS lics 
				ON lics.Land_Crop_year = a.agro_crop_year 
				AND lics.Field_ID = a.Field_ID 
			LEFT OUTER JOIN dbo.Lookup_ag_over_6 AS six 
				ON six.processor = CASE WHEN (a.agro_crop_year = 2011 AND a.contract_number IN ('4')) THEN 2046 
										ELSE a.processor_id 
								   END 
				AND six.crop_year = a.agro_crop_year 
				AND six.value = ROUND(ROUND((a.US1_6_9oz_lbs + a.US1_7_9oz_lbs + a.US1_10_above_lbs + a.US2_6_9oz_lbs + a.US2_7_9oz_lbs + a.US2_10oz_lbs) / a.Graded_weight_lbs * 100, 2), 0) 
			LEFT OUTER JOIN dbo.Lookup_ag_7_oz AS seven 
				ON seven.processor = a.Processor_ID 
				AND seven.crop_year = a.agro_crop_year 
				AND seven.value = ROUND((a.US1_7_9oz_lbs + a.US1_10_above_lbs + a.US2_7_9oz_lbs + a.US2_10oz_lbs) / a.Graded_weight_lbs * 100, 0) 
			LEFT OUTER JOIN dbo.Lookup_ag_over_10 AS ten 
				ON ten.processor = a.Processor_ID 
				AND ten.crop_year = a.agro_crop_year 
				AND ten.value = ROUND((a.US1_10_above_lbs + a.US2_10oz_lbs) / a.Graded_weight_lbs * 100, 0) 
			LEFT OUTER JOIN dbo.Lookup_ag_12_greater AS twelve 
				ON twelve.processor = 2046 
				AND twelve.crop_year = a.agro_crop_year 
				AND twelve.value = ROUND((a.US1_10_above_lbs + a.US2_10oz_lbs) / a.Graded_weight_lbs * 100, 0) 
            LEFT OUTER JOIN dbo.Lookup_ag_bruisefree AS bf 
				ON bf.processor = a.Processor_ID 
				AND bf.crop_year = a.agro_crop_year 
				AND bf.value = CASE WHEN Isnull(a.bruise_free_cnt, 0) = 0 AND Isnull(a.bruised_cnt, 0) = 0 THEN 0 
									ELSE Round((a.bruise_free_cnt / (a.bruise_free_cnt + a.bruised_cnt)) * 100, 0) 
								END 
			LEFT OUTER JOIN dbo.Lookup_ag_unusable AS uu 
				ON uu.crop_year = a.agro_crop_year 
				AND uu.processor = a.Processor_ID 
				AND uu.value = CASE WHEN a.agro_crop_year IN (2017, 2018) THEN Round(((Isnull(a.late_blight_lbs, 0) + Isnull(a.freeze_lbs, 0) + Isnull(a.green_lbs, 0) + 
																					   Isnull(a.insect_lbs, 0) + Isnull(a.insectother_lbs, 0) + Isnull(a.other_lbs, 0) + 
																					   Isnull(a.pink_eye_lbs, 0) + Isnull(a.pinkrot_lbs, 0) + Isnull(a.pit_scab_lbs, 0) + 
																					   Isnull(a.soft_rot_lbs, 0) + Isnull(a.sun_burn_lbs, 0) + Isnull(a.unusable_lbs, 0) + 
																					   Isnull(a.wireworm_lbs, 0) + Isnull(a.discolored_lbs, 0) + Isnull(a.hollow_lbs, 0)) 
																					   / a.graded_weight_lbs) * 100, 0) 
									WHEN a.agro_crop_year = 2016 THEN Round(((Isnull(a.unusable_lbs, 0) / a.graded_weight_lbs) * 100), 0) 
									ELSE Round(((Isnull(a.soft_rot_lbs, 0) + Isnull(a.freeze_lbs, 0) + Isnull(a.pink_eye_lbs, 0) + Isnull(a.hollow_lbs, 0) + 
												 Isnull(a.discolored_lbs, 0) + Isnull(a.pit_scab_lbs, 0) + Isnull(a.unusable_lbs, 0) + Isnull(a.late_blight_lbs, 0) + 
												 Isnull(a.insect_lbs, 0) + Isnull(a.ring_rot, 0) + Isnull(a.surface_scab, 0)) / a.graded_weight_lbs) * 100, 0) 
								END 
			LEFT OUTER JOIN dbo.Lookup_ag_one AS u1 
				ON u1.crop_year = a.agro_crop_year 
				AND u1.processor = a.Processor_ID 
				AND u1.value = ROUND((a.US1_min_lbs + a.US1_2_4oz_lbs + a.US1_6_9oz_lbs + a.US1_7_9oz_lbs + a.US1_10_above_lbs) / a.Graded_weight_lbs * 100, 0) 
			LEFT OUTER JOIN dbo.Lookup_ag_fm AS dfm 
				ON dfm.processor = CASE WHEN (a.agro_crop_year = 2011 AND a.contract_number IN ('4')) THEN 2046 
										ELSE a.processor_id 
								   END 
				AND dfm.crop_year = a.agro_crop_year 
				AND dfm.value = ROUND((ISNULL(a.Rock_lbs, 0) + ISNULL(a.DVFM_lbs, 0) + ISNULL(a.DVFM_VegMat_lbs, 0)) / a.Net_sample_weight_lbs * 100, 0) 
			LEFT OUTER JOIN dbo.Lookup_ag_fm_2 AS dfm2 
				ON dfm2.processor = a.Processor_ID 
				AND dfm2.crop_year = a.agro_crop_year 
				AND dfm2.value = ROUND((ISNULL(a.Rock_lbs, 0) + ISNULL(a.DVFM_lbs, 0) + ISNULL(a.DVFM_VegMat_lbs, 0)) / a.Net_sample_weight_lbs * 100, 0) 
			LEFT OUTER JOIN dbo.Lookup_ag_rock AS rock 
				ON rock.processor = a.Processor_ID 
				AND rock.crop_year = a.agro_crop_year 
				AND rock.value = CASE WHEN Round((((Isnull(a.rock_lbs, 0) / a.net_sample_weight_lbs) * 100) - 1) / 0.5, 0, 1) < 0 THEN 0 
									  ELSE Round((((Isnull(a.rock_lbs, 0) / a.net_sample_weight_lbs) * 100) - 1) / 0.5, 0, 1) 
								 END 
			LEFT OUTER JOIN dbo.Lookup_ag_specific_gravity AS sg 
				ON sg.processor = CASE WHEN (a.agro_crop_year = 2011 AND a.contract_number IN ('4')) THEN 2046 
									   ELSE a.processor_id 
								  END 
				AND sg.crop_year = a.agro_crop_year 
				AND sg.value = ROUND(a.Specific_Gravity - 1, 3) * 1000 
			LEFT OUTER JOIN dbo.Lookup_ag_specific_gravity_2 AS sg2 
				ON sg2.processor = a.Processor_ID 
				AND sg2.crop_year = a.agro_crop_year 
				AND sg2.value = ROUND(a.Specific_Gravity - 1, 3) * 1000 
			LEFT OUTER JOIN dbo.Lookup_ag_soft_rot AS rot 
				ON rot.processor = a.Processor_ID 
				AND rot.crop_year = a.agro_crop_year 
				AND a.Contract_Number IN ('1', '2', '4', '5') 
				AND rot.value = CASE WHEN a.agro_crop_year IN (2018) THEN 
											/* 9/20/2018 - Drew Sandberg */
											/* Correcting 2018 soft rot pounds to include pink rot pounds */
											CASE WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) >= 1
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 2
													  THEN 1
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 2
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 2.5
													  THEN 2
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 2.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 3
													  THEN 2.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 3
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 3.5
													  THEN 3
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 3.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 4
													  THEN 3.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 4
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 4.5
													  THEN 4
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 4.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 5
													  THEN 4.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 5.5
													  THEN 5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 5.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 6
													  THEN 5.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 6
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 6.5
													  THEN 6
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 6.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 7
													  THEN 6.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 7
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 7.5
													  THEN 7
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 7.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 8
													  THEN 7.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 8
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 8.5
													  THEN 8
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 8.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 9
													  THEN 8.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 9
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 9.5
													  THEN 9
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 9.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 10
													  THEN 9.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 10
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 10.5
													  THEN 10
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 10.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 11
													  THEN 10.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 11
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 11.5
													  THEN 11
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 11.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 12
													  THEN 11.5
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 12
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 12.5
													  THEN 12
												 WHEN Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) > 12.5
											          AND Round((((a.soft_rot_lbs + a.PinkRot_lbs) / a.graded_weight_lbs) * 100), 3) <= 13
													  THEN 12.5
											END 
									 WHEN a.agro_crop_year IN (2017, 2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2006, 2005, 2004) THEN 
											CASE WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) < 2 
														THEN Round((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)), 0, 1) 
												 WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) = 2 
														THEN Round((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)) - 1, 0, 1) 
												 WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) > 2 
												  AND Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) < 5 
														THEN Round(((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)) - 1.01) / 0.5, 0, 1) 
												 WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) >= 5 
														THEN Round((((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)) - 5.01) / 0.5) + 8, 0, 1) 
											END 
									WHEN a.agro_crop_year IN (2003) THEN 
											CASE WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) < 2 
														THEN Round((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)), 0, 1) 
												 WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) = 2 
														THEN Round((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)) - 1, 0, 1) 
												 WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) > 2 
												  AND Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) < 5 
														THEN Round(((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)) - 1.01) / 0.5, 0, 1) 
												WHEN Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3) >= 5 
														THEN Round((((Round((((a.soft_rot_lbs + a.ring_rot) / a.graded_weight_lbs) * 100), 3)) - 5.01) / 0.5) + 7, 0, 1) 
											END 
								END 
			LEFT OUTER JOIN dbo.Lookup_ag_early_dig AS early 
				ON early.crop_year = a.agro_crop_year 
				AND early.processor = a.Processor_ID 
				AND early.value = a.Deliver_Date 
				AND a.Contract_Number = '3' 
			LEFT OUTER JOIN dbo.Lookup_ag_CFM AS BinCornFM 
				ON BinCornFM.crop_year = a.agro_crop_year 
				AND BinCornFM.processor = a.Processor_ID 
				AND BinCornFM.value = ROUND(a.CFM_percent * 100, 1) 
			LEFT OUTER JOIN dbo.Lookup_ag_WFM AS BinWoodFM 
				ON BinWoodFM.crop_year = a.agro_crop_year 
				AND BinWoodFM.processor = a.Processor_ID 
				AND BinWoodFM.value = ROUND(a.WFM_percent * 100, 1) 
			LEFT OUTER JOIN dbo.Lookup_ag_RFM AS BinRockFM 
				ON BinRockFM.crop_year = a.agro_crop_year 
				AND BinRockFM.processor = a.Processor_ID 
				AND BinRockFM.value = ROUND(a.RFM_percent * 100, 1) 
			LEFT OUTER JOIN dbo.Lookup_ag_OFM AS BinOtherFM 
				ON BinOtherFM.crop_year = a.agro_crop_year 
				AND BinOtherFM.processor = a.Processor_ID 
				AND BinOtherFM.value = ROUND(a.OFM_percent * 100, 1) 
			LEFT OUTER JOIN dbo.Truck_Contract_Info AS base 
				ON base.Contract_Number = a.Contract_Number 
				AND base.agro_crop_year = a.agro_crop_year 
				AND base.Processor_ID = a.Processor_ID 
			LEFT OUTER JOIN dbo.Lookup_ag_fung AS fung 
				ON fung.crop_year = a.agro_crop_year 
				AND fung.processor = a.Processor_ID 
				AND fung.value = a.Fungicide

WHERE   (a.Processor_ID = 2001) 
		AND (a.agro_crop_year > 2003)

GROUP BY CONVERT(NVARCHAR(2), m.Farm_Region) + '_' + CONVERT(NVARCHAR(3), m.Farm_ID) + '_' + CONVERT(NVARCHAR(10), f.Field_ID) + '_' + CONVERT(NVARCHAR(10), a.Truck_Agro_ID), 
a.agro_crop_year, 
m.Farm_ID, 
dbo.fnFarmName(a.Field_ID), 
a.Field_ID, 
f.Fld_Number, 
dbo.fnFieldName(a.Field_ID), 
lics.Crop_Variety_ID, 
dbo.fnVarietyName(lics.Crop_Variety_ID), 
lics.Harvest_acres, 
a.Processor_ID, 
a.Contract_Number, 
a.Truck_Agro_ID, 
a.Report_number, 
a.Deliver_Date, 
a.Net_sample_weight_lbs, 
a.Graded_weight_lbs, 
early.price_per_cwt, 
a.US1_10_above_lbs + a.US2_10oz_lbs, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4') THEN ten.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN ten.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN ten.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN ten.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN twelve.price_per_cwt ELSE 0 
			END 
END, 
a.US1_6_9oz_lbs + a.US1_7_9oz_lbs + a.US1_10_above_lbs + a.US2_6_9oz_lbs + a.US2_7_9oz_lbs + a.US2_10oz_lbs, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN six.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN six.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN six.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN six.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN 
						CASE WHEN a.report_number IN ('101411') THEN 0.65 
							 ELSE six.price_per_cwt 
						END 
				 ELSE 0 
			END 
END,
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN six.price_simplot 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN six.price_simplot 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN six.price_simplot 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN six.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN 
						CASE WHEN a.report_number IN ('101411') THEN 0.65 
							 ELSE six.price_simplot 
						END 
				 ELSE 0 
			END 
END, 
a.US1_7_9oz_lbs + a.US1_10_above_lbs + a.US2_7_9oz_lbs + a.US2_10oz_lbs, 
CASE WHEN a.agro_crop_year IN (2012) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN seven.price_per_cwt 
				 ELSE 0 
			END 
END, 
a.Bruise_Free_cnt, a.Bruise_Free_cnt + a.Bruised_cnt, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN bf.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1','2') THEN bf.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN bf.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN bf.price_per_cwt 
			END 
END, 
a.Rock_lbs + a.DVFM_lbs + ISNULL(a.DVFM_VegMat_lbs, 0), 
CASE WHEN a.agro_crop_year IN (2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4') THEN dfm.price_per_cwt 
				 WHEN a.contract_number IN ('5') THEN 0 
				 WHEN a.contract_number IN ('3') THEN dfm2.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN dfm.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN dfm.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN dfm.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN dfm.price_per_cwt 
				 WHEN a.contract_number IN ('4') THEN 
						CASE WHEN report_number IN ('101411') THEN 0.25 
							 ELSE dfm.price_per_cwt 
						END 
			END 
END, 
CASE WHEN a.agro_crop_year IN (2017, 2018) THEN Isnull(a.late_blight_lbs, 0) + Isnull(a.freeze_lbs, 0) + Isnull(a.green_lbs, 0) + Isnull(a.insect_lbs, 0) + 
												Isnull(a.insectother_lbs, 0) + Isnull(a.other_lbs, 0) + Isnull(a.pink_eye_lbs, 0) + Isnull(a.pinkrot_lbs, 0) + 
												Isnull(a.pit_scab_lbs, 0) + Isnull(a.soft_rot_lbs, 0) + Isnull(a.sun_burn_lbs, 0) + Isnull(a.unusable_lbs, 0) + 
												Isnull(a.wireworm_lbs, 0) + Isnull(a.discolored_lbs, 0) + Isnull(a.hollow_lbs, 0) 
	WHEN a.agro_crop_year = 2016 THEN Isnull(a.unusable_lbs, 0) 
	ELSE Isnull(a.soft_rot_lbs, 0) + Isnull(a.freeze_lbs, 0) + Isnull(a.pink_eye_lbs, 0) + Isnull(a.hollow_lbs, 0) + Isnull(a.discolored_lbs, 0) + Isnull(a.pit_scab_lbs, 0) + 
		 Isnull(a.unusable_lbs, 0) + Isnull(a.late_blight_lbs, 0) + Isnull(a.insect_lbs, 0) + Isnull(a.ring_rot, 0) + Isnull(a.surface_scab, 0) 
END, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN uu.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN uu.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN uu.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN uu.price_per_cwt 
			END 
END,
a.US1_min_lbs + a.US1_2_4oz_lbs + a.US1_6_9oz_lbs + a.US1_7_9oz_lbs + a.US1_10_above_lbs, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN U1.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN u1.price_per_cwt 
				 ELSE 0 
			END 
	WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN u1.price_per_cwt 
				 ELSE 0 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN u1.price_per_cwt 
				 ELSE 0 
			END 
END, 
CASE WHEN a.specific_gravity > 0 THEN a.specific_gravity 
	 ELSE NULL 
END, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4') THEN sg.price_per_cwt 
				 WHEN a.contract_number IN ('3', '5') THEN sg2.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN sg.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN sg.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '7') THEN sg.price_per_cwt 
				 WHEN a.contract_number IN ('3', '5') THEN sg2.price_per_cwt 
			END 
END, 
a.Fungicide, 
CASE WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN fung.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN fung.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '5', '7') THEN fung.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN fung.price_per_cwt 
			END 
END, 

/* 9/20/2018 - Drew Sandberg */
/* Correcting 2018 soft rot pounds to include pink rot pounds */
CASE WHEN a.agro_crop_year IN (2018) THEN a.Soft_Rot_lbs + a.PinkRot_lbs
	 ELSE a.Soft_Rot_lbs + a.Ring_Rot
END,

CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '4', '5') THEN rot.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003,2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1', '2') THEN rot.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN rot.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN rot.price_per_cwt 
			END
END, 
a.Rock_lbs, 
CASE WHEN a.agro_crop_year IN (2012, 2013, 2014, 2015, 2016, 2017, 2018) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3', '4', '5') THEN rock.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2003, 2004, 2005, 2006, 2007, 2008, 2009) THEN 
			CASE WHEN a.contract_number IN ('1','2') THEN rock.price_per_cwt 
			END 
	 WHEN a.agro_crop_year IN (2010) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '3') THEN rock.price_per_cwt 
			END 
	WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('1', '2', '7') THEN rock.price_per_cwt 
			END 
END, 
ISNULL(a.RFM_percent, 0), 
ISNULL(a.CFM_percent, 0), 
ISNULL(a.WFM_percent, 0), 
ISNULL(a.OFM_percent, 0), 
ISNULL(BinRockFM.price_per_cwt, 0), 
ISNULL(BinCornFM.price_per_cwt, 0), 
ISNULL(BinWoodFM.price_per_cwt, 0), 
ISNULL(BinOtherFM.price_per_cwt, 0), 
a.DVFM_lbs, 
ISNULL(a.DVFM_VegMat_lbs, 0), a.PinkRot_lbs, 
a.Dry_Rot_lbs, 
a.Pink_Eye_lbs, 
a.Undersize_lbs, 
a.Late_Blight_lbs, 
a.Pit_Scab_lbs, 
a.Surface_Scab, 
a.Wireworm_lbs, 
a.Hollow_lbs, 
a.discolored_lbs, 
a.Freeze_lbs, 
a.Sun_Burn_lbs, 
a.Green_lbs, 
a.Fry_0_strip, 
CASE WHEN a.agro_crop_year IN (2011) THEN 
			CASE WHEN a.contract_number IN ('3', '5') THEN 
						CASE WHEN a.deliver_date = '2011-08-01' THEN base.base_price + 3.54 
							 WHEN a.deliver_date = '2011-08-02' THEN base.base_price + 3.42 
							 WHEN a.deliver_date = '2011-08-03' THEN base.base_price + 3.305 
							 WHEN a.deliver_date = '2011-08-04' THEN base.base_price + 3.185 
							 WHEN a.deliver_date = '2011-08-05' THEN base.base_price + 3.07 
							 WHEN a.deliver_date = '2011-08-06' THEN base.base_price + 2.95 
							 WHEN a.deliver_date = '2011-08-07' THEN base.base_price + 2.835 
							 WHEN a.deliver_date = '2011-08-08' THEN base.base_price + 2.715 
							 WHEN a.deliver_date = '2011-08-09' THEN base.base_price + 2.60 
							 WHEN a.deliver_date = '2011-08-10' THEN base.base_price + 2.48 
							 WHEN a.deliver_date = '2011-08-11' THEN base.base_price + 2.365 
							 WHEN a.deliver_date = '2011-08-12' THEN base.base_price + 2.245 
							 WHEN a.deliver_date = '2011-08-13' THEN base.base_price + 2.13 
							 WHEN a.deliver_date = '2011-08-14' THEN base.base_price + 2.01 
							 WHEN a.deliver_date = '2011-08-15' THEN base.base_price + 1.895 
							 WHEN a.deliver_date = '2011-08-16' THEN base.base_price + 1.775 
							 WHEN a.deliver_date = '2011-08-17' THEN base.base_price + 1.66 
							 WHEN a.deliver_date = '2011-08-18' THEN base.base_price + 1.54 
							 WHEN a.deliver_date = '2011-08-19' THEN base.base_price + 1.425 
							 WHEN a.deliver_date = '2011-08-20' THEN base.base_price + 1.305 
							 WHEN a.deliver_date = '2011-08-21' THEN base.base_price + 1.19 
							 WHEN a.deliver_date = '2011-08-22' THEN base.base_price + 1.095 
							 WHEN a.deliver_date = '2011-08-23' THEN base.base_price + 1.005 
							 WHEN a.deliver_date = '2011-08-24' THEN base.base_price + 0.91 
							 WHEN a.deliver_date = '2011-08-25' THEN base.base_price + 0.82 
							 WHEN a.deliver_date = '2011-08-26' THEN base.base_price + 0.725 
							 WHEN a.deliver_date = '2011-08-27' THEN base.base_price + 0.635 
							 WHEN a.deliver_date = '2011-08-28' THEN base.base_price + 0.54 
							 WHEN a.deliver_date = '2011-08-29' THEN base.base_price + 0.45 
							 WHEN a.deliver_date = '2011-08-30' THEN base.base_price + 0.355 
							 WHEN a.deliver_date = '2011-08-31' THEN base.base_price + 0.265 
							 WHEN a.deliver_date = '2011-09-01' THEN base.base_price + 0.17 
							 WHEN a.deliver_date = '2011-09-02' THEN base.base_price + 0.13 
							 WHEN a.deliver_date = '2011-09-03' THEN base.base_price + 0.085 
							 WHEN a.deliver_date = '2011-09-04' THEN base.base_price + 0.045 
							 ELSE base.base_price 
						END 
					WHEN a.contract_number IN ('4') THEN 
							CASE WHEN a.deliver_date = '2011-08-11' THEN base.base_price + 2.88 
								 WHEN a.deliver_date = '2011-08-12' THEN base.base_price + 2.63 
								 WHEN a.deliver_date = '2011-08-13' THEN base.base_price + 2.38 
								 WHEN a.deliver_date = '2011-08-14' THEN base.base_price + 2.13 
								 WHEN a.deliver_date = '2011-08-15' THEN base.base_price + 1.8 
								 WHEN a.deliver_date = '2011-08-16' THEN base.base_price + 1.73 
								 WHEN a.deliver_date = '2011-08-17' THEN base.base_price + 1.57 
								 WHEN a.deliver_date = '2011-08-18' THEN base.base_price + 1.39
								 WHEN a.deliver_date = '2011-08-19' THEN base.base_price + 1.20 
								 WHEN a.deliver_date = '2011-08-20' THEN base.base_price + 1.01 
								 WHEN a.deliver_date = '2011-08-21' THEN base.base_price + 0.82 
								 WHEN a.deliver_date = '2011-08-22' THEN base.base_price + 0.75 
								 WHEN a.deliver_date = '2011-08-23' THEN base.base_price + 0.68 
								 WHEN a.deliver_date = '2011-08-24' THEN base.base_price + 0.62 
								 WHEN a.deliver_date = '2011-08-25' THEN base.base_price + 0.50 
								 WHEN a.deliver_date = '2011-08-26' THEN base.base_price + 0.46 
								 WHEN a.deliver_date = '2011-08-27' THEN base.base_price + 0.34
								 WHEN a.deliver_date = '2011-08-28' THEN base.base_price + 0.18 
								 WHEN a.deliver_date = '2011-08-29' THEN base.base_price + 0.14 
								 WHEN a.deliver_date = '2011-08-30' THEN base.base_price + 0.09 
								 WHEN a.deliver_date = '2011-08-31' THEN base.base_price + 0.04 
								 WHEN a.deliver_date = '2011-09-01' THEN base.base_price + 0 
								 WHEN a.deliver_date = '2011-09-02' THEN base.base_price + 0.13 
								 WHEN a.deliver_date = '2011-09-03' THEN base.base_price + 0.085 
								 WHEN a.deliver_date = '2011-09-04' THEN base.base_price + 0.045 
								 ELSE base.base_price 
							END 
					ELSE base.base_price 
					END 
			ELSE base.base_price 
END
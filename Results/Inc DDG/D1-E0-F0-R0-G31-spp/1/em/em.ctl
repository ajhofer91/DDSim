#V3.24f
#C growth parameters are estimated
#C spawner-recruitment bias adjustment Not tuned For optimality
#_data_and_control_files: ss3.dat // em.ctl
#_SS-V3.24f-safe-Win32;_08/03/2012;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11
1  #_N_Growth_Patterns
1 #_N_Morphs_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
#_Cond 0  #  N recruitment designs goes here if N_GP*nseas*area>1
#_Cond 0  #  placeholder for recruitment interaction request
#_Cond 1 1 1  # example recruitment design element for GP=1, seas=1, area=1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
#
0.5 #_fracfemale 
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
3 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
0 #_Growth_Age_for_L1
25 #_Growth_Age_for_L2 (999 to use as Linf)
1 25 # min and max age for age-specific K
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from wtatage.ss
#_placeholder for empirical age-maturity by growth pattern
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
1 #_env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)
#
#_growth_parms
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 0.05 0.15 0.1 0.1 -1 0.8 -3 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
 -10 45 20.4603 36 0 10 2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 40 90 71.4388 70 0 10 4 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.05 0.25 0.154115 0.15 0 0.8 4 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 -0.0001 0.0001 -1.5314e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_1
 -0.0001 0.0001 4.12732e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_2
 -0.0001 0.0001 -2.61251e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_3
 -0.0001 0.0001 3.1993e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_4
 -0.0001 0.0001 1.58598e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_5
 -0.0001 0.0001 -8.86249e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_6
 -0.0001 0.0001 -3.43104e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_7
 -0.0001 0.0001 1.26836e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_8
 -0.0001 0.0001 2.53756e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_9
 -0.0001 0.0001 -1.04425e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_10
 -0.0001 0.0001 -3.45321e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_11
 -0.0001 0.0001 -5.35865e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_12
 -0.0001 0.0001 2.93985e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_13
 -0.0001 0.0001 -6.99337e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_14
 -0.0001 0.0001 4.55264e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_15
 -0.0001 0.0001 8.01642e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_16
 -0.0001 0.0001 1.62268e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_17
 -0.0001 0.0001 1.29154e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_18
 -0.0001 0.0001 -1.60099e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_19
 -0.0001 0.0001 -1.82616e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_20
 -0.0001 0.0001 -1.29754e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_21
 -0.0001 0.0001 -1.1667e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_22
 -0.0001 0.0001 -8.41913e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_23
 -0.0001 0.0001 -6.66302e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_24
 -0.0001 0.0001 6.74846e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Fem_GP_1_a_25
 0.05 0.25 0.1 0.1 -1 0.8 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.05 0.25 0.1 0.1 -1 0.8 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
 0.05 0.15 0.1 0.1 -1 0.8 -3 0 0 0 0 0 0 0 # NatM_p_1_Mal_GP_1
 1 45 21.542 36 -1 10 -3 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 40 90 69.5516 70 0 10 4 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.05 0.25 0.164055 0.15 0 0.8 4 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 -0.0001 0.0001 3.6937e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_1
 -0.0001 0.0001 5.08951e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_2
 -0.0001 0.0001 1.92229e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_3
 -0.0001 0.0001 5.39755e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_4
 -0.0001 0.0001 -3.98766e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_5
 -0.0001 0.0001 -1.20875e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_6
 -0.0001 0.0001 -2.81884e-005 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_7
 -0.0001 0.0001 7.46963e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_8
 -0.0001 0.0001 -3.86706e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_9
 -0.0001 0.0001 5.51342e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_10
 -0.0001 0.0001 2.88305e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_11
 -0.0001 0.0001 -6.15251e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_12
 -0.0001 0.0001 -2.08218e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_13
 -0.0001 0.0001 1.79151e-006 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_14
 -0.0001 0.0001 7.5477e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_15
 -0.0001 0.0001 3.98265e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_16
 -0.0001 0.0001 1.87365e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_17
 -0.0001 0.0001 1.42156e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_18
 -0.0001 0.0001 2.09482e-007 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_19
 -0.0001 0.0001 -9.57474e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_20
 -0.0001 0.0001 -4.13556e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_21
 -0.0001 0.0001 -5.10419e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_22
 -0.0001 0.0001 -3.51711e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_23
 -0.0001 0.0001 -1.82928e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_24
 -0.0001 0.0001 4.18973e-008 0 -1 3e-007 0 0 0 0 0 0 0 0 # Age_K_Mal_GP_1_a_25
 0.05 0.25 0.1 0.1 -1 0.8 -3 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 0.05 0.25 0.1 0.1 -1 0.8 -3 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
 -3 3 2.44e-006 2.44e-006 -1 0.8 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem
 -3 4 3.34694 3.34694 -1 0.8 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem
 50 60 55 55 -1 0.8 -3 0 0 0 0 0 0 0 # Mat50%_Fem
 -3 3 -0.25 -0.25 -1 0.8 -3 0 0 0 0 0 0 0 # Mat_slope_Fem
 -3 3 1 1 -1 0.8 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem
 -3 3 0 0 -1 0.8 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem
 -3 3 2.44e-006 2.44e-006 -1 0.8 -3 0 0 0 0 0 0 0 # Wtlen_1_Mal
 -3 4 3.34694 3.34694 -1 0.8 -3 0 0 0 0 0 0 0 # Wtlen_2_Mal
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # RecrDist_Seas_1
 0 0 0 0 -1 0 -4 0 0 0 0 0 0 0 # CohortGrowDev
#
#_Cond 0  #custom_MG-env_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters
#
#_Cond 0  #custom_MG-block_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters
#_Cond No MG parm trends 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Cond -4 #_MGparm_Dev_Phase
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm
#_LO HI INIT PRIOR PR_type SD PHASE
 3 31 8.81856 10.3 -1 10 1 # SR_LN(R0)
 0.2 1 0.611609 0.7 1 0.05 4 # SR_BH_steep
 0 2 0.6 0.8 -1 0.8 -4 # SR_sigmaR
 -5 5 0.1 0 -1 1 -3 # SR_envlink
 -5 5 0 0 -1 1 -4 # SR_R1_offset
 0 0 0 0 -1 0 -99 # SR_autocorr
0 #_SR_env_link
0 #_SR_env_target_0=none;1=devs;_2=R0;_3=steepness
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1971 # first year of main recr_devs; early devs can preceed this era
2001 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1900 #_last_early_yr_nobias_adj_in_MPD
 1900 #_first_yr_fullbias_adj_in_MPD
 2001 #_last_yr_fullbias_adj_in_MPD
 2002 #_first_recent_yr_nobias_adj_in_MPD
 1 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#DisplayOnly 0.0370958 # Main_RecrDev_1971
#DisplayOnly 0.0093007 # Main_RecrDev_1972
#DisplayOnly 0.0814297 # Main_RecrDev_1973
#DisplayOnly -0.18337 # Main_RecrDev_1974
#DisplayOnly 0.0162426 # Main_RecrDev_1975
#DisplayOnly 0.725992 # Main_RecrDev_1976
#DisplayOnly -0.0521539 # Main_RecrDev_1977
#DisplayOnly 0.00138816 # Main_RecrDev_1978
#DisplayOnly 0.274102 # Main_RecrDev_1979
#DisplayOnly 0.162254 # Main_RecrDev_1980
#DisplayOnly 0.089887 # Main_RecrDev_1981
#DisplayOnly -0.235341 # Main_RecrDev_1982
#DisplayOnly -0.422995 # Main_RecrDev_1983
#DisplayOnly -0.354737 # Main_RecrDev_1984
#DisplayOnly 0.436585 # Main_RecrDev_1985
#DisplayOnly 0.502413 # Main_RecrDev_1986
#DisplayOnly 0.265004 # Main_RecrDev_1987
#DisplayOnly 0.134752 # Main_RecrDev_1988
#DisplayOnly -0.358889 # Main_RecrDev_1989
#DisplayOnly 0.59754 # Main_RecrDev_1990
#DisplayOnly -0.67585 # Main_RecrDev_1991
#DisplayOnly -0.263834 # Main_RecrDev_1992
#DisplayOnly -0.860812 # Main_RecrDev_1993
#DisplayOnly 0.409985 # Main_RecrDev_1994
#DisplayOnly -0.680432 # Main_RecrDev_1995
#DisplayOnly 0.475285 # Main_RecrDev_1996
#DisplayOnly 1.13411 # Main_RecrDev_1997
#DisplayOnly -0.5514 # Main_RecrDev_1998
#DisplayOnly -0.639756 # Main_RecrDev_1999
#DisplayOnly 0.224547 # Main_RecrDev_2000
#DisplayOnly -0.298351 # Main_RecrDev_2001
#DisplayOnly 0 # ForeRecr_2002
#DisplayOnly 0 # ForeRecr_2003
#DisplayOnly 0 # ForeRecr_2004
#DisplayOnly 0 # ForeRecr_2005
#DisplayOnly 0 # ForeRecr_2006
#DisplayOnly 0 # ForeRecr_2007
#DisplayOnly 0 # ForeRecr_2008
#DisplayOnly 0 # ForeRecr_2009
#DisplayOnly 0 # ForeRecr_2010
#DisplayOnly 0 # ForeRecr_2011
#DisplayOnly 0 # ForeRecr_2012
#DisplayOnly 0 # ForeRecr_2013
#DisplayOnly 0 # ForeRecr_2014
#DisplayOnly 0 # ForeRecr_2015
#DisplayOnly 0 # ForeRecr_2016
#DisplayOnly 0 # ForeRecr_2017
#DisplayOnly 0 # ForeRecr_2018
#DisplayOnly 0 # ForeRecr_2019
#DisplayOnly 0 # ForeRecr_2020
#DisplayOnly 0 # ForeRecr_2021
#DisplayOnly 0 # ForeRecr_2022
#DisplayOnly 0 # ForeRecr_2023
#DisplayOnly 0 # ForeRecr_2024
#DisplayOnly 0 # ForeRecr_2025
#DisplayOnly 0 # ForeRecr_2026
#DisplayOnly 0 # ForeRecr_2027
#DisplayOnly 0 # ForeRecr_2028
#DisplayOnly 0 # ForeRecr_2029
#DisplayOnly 0 # ForeRecr_2030
#DisplayOnly 0 # ForeRecr_2031
#DisplayOnly 0 # ForeRecr_2032
#DisplayOnly 0 # ForeRecr_2033
#DisplayOnly 0 # ForeRecr_2034
#DisplayOnly 0 # ForeRecr_2035
#DisplayOnly 0 # ForeRecr_2036
#DisplayOnly 0 # ForeRecr_2037
#DisplayOnly 0 # ForeRecr_2038
#DisplayOnly 0 # ForeRecr_2039
#DisplayOnly 0 # ForeRecr_2040
#DisplayOnly 0 # ForeRecr_2041
#DisplayOnly 0 # ForeRecr_2042
#DisplayOnly 0 # ForeRecr_2043
#DisplayOnly 0 # ForeRecr_2044
#DisplayOnly 0 # ForeRecr_2045
#DisplayOnly 0 # ForeRecr_2046
#DisplayOnly 0 # ForeRecr_2047
#DisplayOnly 0 # ForeRecr_2048
#DisplayOnly 0 # ForeRecr_2049
#DisplayOnly 0 # ForeRecr_2050
#DisplayOnly 0 # ForeRecr_2051
#DisplayOnly 0 # ForeRecr_2052
#DisplayOnly 0 # ForeRecr_2053
#DisplayOnly 0 # ForeRecr_2054
#DisplayOnly 0 # ForeRecr_2055
#DisplayOnly 0 # ForeRecr_2056
#DisplayOnly 0 # ForeRecr_2057
#DisplayOnly 0 # ForeRecr_2058
#DisplayOnly 0 # ForeRecr_2059
#DisplayOnly 0 # ForeRecr_2060
#DisplayOnly 0 # ForeRecr_2061
#DisplayOnly 0 # ForeRecr_2062
#DisplayOnly 0 # ForeRecr_2063
#DisplayOnly 0 # ForeRecr_2064
#DisplayOnly 0 # ForeRecr_2065
#DisplayOnly 0 # ForeRecr_2066
#DisplayOnly 0 # ForeRecr_2067
#DisplayOnly 0 # ForeRecr_2068
#DisplayOnly 0 # ForeRecr_2069
#DisplayOnly 0 # ForeRecr_2070
#DisplayOnly 0 # ForeRecr_2071
#DisplayOnly 0 # Impl_err_2002
#DisplayOnly 0 # Impl_err_2003
#DisplayOnly 0 # Impl_err_2004
#DisplayOnly 0 # Impl_err_2005
#DisplayOnly 0 # Impl_err_2006
#DisplayOnly 0 # Impl_err_2007
#DisplayOnly 0 # Impl_err_2008
#DisplayOnly 0 # Impl_err_2009
#DisplayOnly 0 # Impl_err_2010
#DisplayOnly 0 # Impl_err_2011
#DisplayOnly 0 # Impl_err_2012
#DisplayOnly 0 # Impl_err_2013
#DisplayOnly 0 # Impl_err_2014
#DisplayOnly 0 # Impl_err_2015
#DisplayOnly 0 # Impl_err_2016
#DisplayOnly 0 # Impl_err_2017
#DisplayOnly 0 # Impl_err_2018
#DisplayOnly 0 # Impl_err_2019
#DisplayOnly 0 # Impl_err_2020
#DisplayOnly 0 # Impl_err_2021
#DisplayOnly 0 # Impl_err_2022
#DisplayOnly 0 # Impl_err_2023
#DisplayOnly 0 # Impl_err_2024
#DisplayOnly 0 # Impl_err_2025
#DisplayOnly 0 # Impl_err_2026
#DisplayOnly 0 # Impl_err_2027
#DisplayOnly 0 # Impl_err_2028
#DisplayOnly 0 # Impl_err_2029
#DisplayOnly 0 # Impl_err_2030
#DisplayOnly 0 # Impl_err_2031
#DisplayOnly 0 # Impl_err_2032
#DisplayOnly 0 # Impl_err_2033
#DisplayOnly 0 # Impl_err_2034
#DisplayOnly 0 # Impl_err_2035
#DisplayOnly 0 # Impl_err_2036
#DisplayOnly 0 # Impl_err_2037
#DisplayOnly 0 # Impl_err_2038
#DisplayOnly 0 # Impl_err_2039
#DisplayOnly 0 # Impl_err_2040
#DisplayOnly 0 # Impl_err_2041
#DisplayOnly 0 # Impl_err_2042
#DisplayOnly 0 # Impl_err_2043
#DisplayOnly 0 # Impl_err_2044
#DisplayOnly 0 # Impl_err_2045
#DisplayOnly 0 # Impl_err_2046
#DisplayOnly 0 # Impl_err_2047
#DisplayOnly 0 # Impl_err_2048
#DisplayOnly 0 # Impl_err_2049
#DisplayOnly 0 # Impl_err_2050
#DisplayOnly 0 # Impl_err_2051
#DisplayOnly 0 # Impl_err_2052
#DisplayOnly 0 # Impl_err_2053
#DisplayOnly 0 # Impl_err_2054
#DisplayOnly 0 # Impl_err_2055
#DisplayOnly 0 # Impl_err_2056
#DisplayOnly 0 # Impl_err_2057
#DisplayOnly 0 # Impl_err_2058
#DisplayOnly 0 # Impl_err_2059
#DisplayOnly 0 # Impl_err_2060
#DisplayOnly 0 # Impl_err_2061
#DisplayOnly 0 # Impl_err_2062
#DisplayOnly 0 # Impl_err_2063
#DisplayOnly 0 # Impl_err_2064
#DisplayOnly 0 # Impl_err_2065
#DisplayOnly 0 # Impl_err_2066
#DisplayOnly 0 # Impl_err_2067
#DisplayOnly 0 # Impl_err_2068
#DisplayOnly 0 # Impl_err_2069
#DisplayOnly 0 # Impl_err_2070
#DisplayOnly 0 # Impl_err_2071
#
#Fishing Mortality info 
0.3 # F ballpark for tuning early phases
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
2.9 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
4  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms
#_LO HI INIT PRIOR PR_type SD PHASE
 0 1 0 0.01 0 99 -1 # InitF_1FISHERY1
#
#_Q_setup
 # Q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
#_for_env-var:_enter_index_of_the_env-var_to_be_linked
#_Den-dep  env-var  extra_se  Q_type
 0 0 0 0 # 1 FISHERY1
 0 0 1 2 # 2 SURVEY1
 0 0 0 2 # 3 SURVEY2
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any)
# LO HI INIT PRIOR PR_type SD PHASE
 0 0.5 0 0.05 1 0 -4 # Q_extraSD_2_SURVEY1
 -7 5 0.508309 0 -1 1 1 # Q_base_2_SURVEY1
 -7 5 -6.63969 0 -1 1 1 # Q_base_3_SURVEY2
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 1 0 0 0 # 1 FISHERY1
 1 0 0 0 # 2 SURVEY1
 0 0 0 0 # 3 SURVEY2
#
#_age_selex_types
#_Pattern ___ Male Special
 11 0 0 0 # 1 FISHERY1
 11 0 0 0 # 2 SURVEY1
 11 0 0 0 # 3 SURVEY2
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 19 80 53.3834 50 1 0.01 2 0 0 0 0 0 0 0 # SizeSel_1P_1_FISHERY1
 0.01 60 18.7988 15 1 0.01 3 0 0 0 0 0 0 0 # SizeSel_1P_2_FISHERY1
 19 70 36.476 30 1 0.01 2 0 0 0 0 0 0 0 # SizeSel_2P_1_SURVEY1
 0.01 60 6.14588 10 1 0.01 3 0 0 0 0 0 0 0 # SizeSel_2P_2_SURVEY1
 0 40 0 5 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_1P_1_FISHERY1
 0 40 40 6 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_1P_2_FISHERY1
 0 40 0 5 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_2P_1_SURVEY1
 0 40 40 6 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_2P_2_SURVEY1
 0 40 0 5 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_3P_1_SURVEY2
 0 40 0 6 -1 99 -1 0 0 0 0 0 0 0 # AgeSel_3P_2_SURVEY2
#_Cond 0 #_custom_sel-env_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns
#_Cond 0 #_custom_sel-blk_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no block usage
#_Cond No selex parm trends 
#_Cond -4 # placeholder for selparm_Dev_Phase
#_Cond 0 #_env/block/dev_adjust_method (1=standard; 2=logistic trans to keep in base parm bounds; 3=standard w/ no bound check)
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
1 #_Variance_adjustments_to_input_values
#_fleet: 1 2 3 
  0 0 0 #_add_to_survey_CV
  0 0 0 #_add_to_discard_stddev
  0 0 0 #_add_to_bodywt_CV
  1 1 1 #_mult_by_lencomp_N
  1 1 1 #_mult_by_agecomp_N
  1 1 1 #_mult_by_size-at-age_N
#
4 #_maxlambdaphase
1 #_sd_offset
#
3 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  sizefreq_method
 1 2 2 1 1
 4 2 2 1 1
 4 2 3 1 1
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  1 1 1 1 #_CPUE/survey:_2
#  1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 #_lencomp:_1
#  1 1 1 1 #_lencomp:_2
#  0 0 0 0 #_lencomp:_3
#  1 1 1 1 #_agecomp:_1
#  1 1 1 1 #_agecomp:_2
#  0 0 0 0 #_agecomp:_3
#  1 1 1 1 #_size-age:_1
#  1 1 1 1 #_size-age:_2
#  0 0 0 0 #_size-age:_3
#  1 1 1 1 #_init_equ_catch
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
1 # (0/1) read specs for more stddev reporting 
 1 1 -1 5 1 5 1 -1 5 # selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 5 15 25 35 43 # vector with selex std bin picks (-1 in first bin to self-generate)
 1 2 14 26 40 # vector with growth std bin picks (-1 in first bin to self-generate)
 1 2 14 26 40 # vector with NatAge std bin picks (-1 in first bin to self-generate)
999


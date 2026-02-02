#V3.30.14.08-safe;_2019_11_08;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.0
#Stock Synthesis (SS) is a work of the U.S. Government and is not subject to copyright protection in the United States.
#Foreign copyrights may apply. See copyright.txt for more information.
#_user_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_user_info_available_at:https://vlab.ncep.noaa.gov/group/stock-synthesis
#_data_and_control_files: _WBFT1_2021_AK_compress_GOM_LL.dat // _WBFT2021_mat_old_alt4_0831F17asymptotic.ctl
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_between/within_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
3 #_Nblock_Patterns
 1 1 1 #_blocks_per_pattern 
# begin and end years of blocks
 1950 2009
 1950 1992
 1950 2008
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to base parm bounds; 3=no bound check)
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: null;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  21-24 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, maturity, fecundity, recruitment distibution, movement 
#
2 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
20 #_reference age for Lorenzen M; read 1P per morph
#
2 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement)_for_L1;linear growth below this
34 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
3 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
#_Age_Maturity by growth pattern
 0 0 0 0 0 0 0 0.01 0.04 0.19 0.56 0.88 0.98 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
3 #_First_Mature_Age
3 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.05 0.3 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 0 50 42.9753 30 10 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 240 350 273.504 284 10 0 3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.2 0.4 0.297306 0.089 0.8 0 3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 -2 0 -1.011 0.58 0.8 0 3 0 0 0 0 0.5 0 0 # Richards_Fem_GP_1
 0.03 0.15 0.09102 0.1 0.8 0 4 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.03 0.15 0.066024 0.1 0.8 0 4 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 1e-008 0.01 1.77054e-005 1.77054e-005 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 2 4 3.00125 3.00125 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 4 15 8.8 8.8 0.8 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -100 -1 -50 -50 0.8 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 1 1 1 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 1 1 1 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs_exp_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-006 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             5            10       6.63736           6.5            10             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.5          0.99      0.562091           0.5          0.05             0          2          0          0          0          0          0          0          0 # SR_BH_steep
           0.2           1.2      0.679511           0.6           0.3             0          3          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             1             0         -4          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1961 # first year of main recr_devs; early devs can preceed this era
2017 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -2 #_recdev_early_phase
 -1 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 0 #_lambda for Fcast_recr_like occurring before endyr+1
 1947.2 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1971.5 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2015.8 #_last_yr_fullbias_adj_in_MPD
 2018 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
 0.8865 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 57 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# Specified recr devs to read
#_Yr Input_value # Final_value
 1961 1.31847 # 1.38015
 1962 -0.315823 # -0.353813
 1963 0.522284 # 0.484866
 1964 -0.445374 # -0.530622
 1965 -0.577139 # -0.601575
 1966 -0.148568 # -0.11286
 1967 -0.324515 # -0.402757
 1968 0.322849 # 0.432197
 1969 0.405385 # 0.269038
 1970 -0.411451 # -0.429831
 1971 -0.0420315 # -0.0176109
 1972 1.23528 # 1.22157
 1973 0.499252 # 0.469194
 1974 -0.343806 # -0.311243
 1975 -0.606393 # -0.59357
 1976 -0.60739 # -0.635745
 1977 -0.924751 # -0.933771
 1978 -0.515515 # -0.545012
 1979 -0.461091 # -0.47783
 1980 -0.847232 # -0.835368
 1981 0.307971 # 0.306837
 1982 -0.0516083 # -0.0679628
 1983 -0.468152 # -0.441908
 1984 0.0182477 # 0.0496577
 1985 -0.311007 # -0.338542
 1986 0.195824 # 0.211415
 1987 -0.462801 # -0.561076
 1988 -0.130535 # -0.100107
 1989 0.91003 # 0.904073
 1990 -0.154131 # -0.149257
 1991 0.383031 # 0.423643
 1992 -1.00487 # -1.03953
 1993 0.299114 # 0.379994
 1994 1.00168 # 1.03038
 1995 -0.576577 # -0.536728
 1996 -0.384618 # -0.279275
 1997 0.117468 # 0.133456
 1998 -0.136495 # -0.0948706
 1999 0.121232 # 0.141562
 2000 0.289178 # 0.330519
 2001 0.27358 # 0.271866
 2002 -0.160788 # -0.0925191
 2003 1.26591 # 1.26234
 2004 -1.0106 # -1.06008
 2005 0.79653 # 0.816822
 2006 -0.42793 # -0.491668
 2007 -0.110031 # -0.0842082
 2008 0.937897 # 0.915172
 2009 0.299025 # 0.293529
 2010 -0.904796 # -0.920697
 2011 0.382105 # 0.391971
 2012 0.0884864 # 0.0572125
 2013 -0.818067 # -0.825774
 2014 -0.121469 # -0.101997
 2015 -0.00302057 # 0.0192603
 2016 0.0831846 # 0.0789535
 2017 0.947843 # 1.05362
#
# all recruitment deviations
#  1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020F 2021F
#  1.38015 -0.353813 0.484866 -0.530622 -0.601575 -0.11286 -0.402757 0.432197 0.269038 -0.429831 -0.0176109 1.22157 0.469194 -0.311243 -0.59357 -0.635745 -0.933771 -0.545012 -0.47783 -0.835368 0.306837 -0.0679628 -0.441908 0.0496577 -0.338542 0.211415 -0.561076 -0.100107 0.904073 -0.149257 0.423643 -1.03953 0.379994 1.03038 -0.536728 -0.279275 0.133456 -0.0948706 0.141562 0.330519 0.271866 -0.0925191 1.26234 -1.06008 0.816822 -0.491668 -0.0842082 0.915172 0.293529 -0.920697 0.391971 0.0572125 -0.825774 -0.101997 0.0192603 0.0789535 1.05362 0.669958 -0.0314601 0 0
# implementation error by year in forecast:  0
#
#Fishing Mortality info 
0.3 # F ballpark
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
2.9 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
12  # N iterations for tuning F in hybrid method (recommend 3 to 7)
#
#_initial_F_parms; count = 2
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 1e-005 0.1 0.0125549 0.01 99 0 1 # InitF_seas_1_flt_7USA_TRAP
 1e-005 0.1 0.0022942 0.002 0.3 0 1 # InitF_seas_1_flt_9USA_CAN_HARPOON
#2021 2071
# F rates by fleet
# Yr:  1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# JAPAN_LL 0 0 0 0 0 0 0 0.000611869 0.000656366 0.00414796 0.00712224 0.00795491 0.0269781 0.15484 0.394153 0.428202 0.151012 0.0471807 0.0185924 0.00765028 0.00442691 0.10523 0.0302267 0.128923 0.122494 0.0426363 0.147041 0.165369 0.087306 0.132634 0.143491 0.21009 0.042852 0.121418 0.132377 0.209924 0.101155 0.137792 0.138661 0.0538033 0.0603882 0.0761263 0.0580146 0.0669105 0.0483928 0.0409757 0.0436065 0.0327658 0.0715579 0.0385039 0.0494158 0.0489983 0.0587115 0.00652853 0.0587954 0.034131 0.0461838 0.0309619 0.0490404 0.0143835 0.0383251 0.0598581 0.0261086 0.0237027 0.0209949 0.0230169 0.0244755 0.0231593 0.0264761 0.027347 0.0290484 0.0290484
# OTHER_ATL_LL 0 0 6.78891e-005 9.69673e-006 0 4.85547e-005 0 0.000155308 0.000389062 0.000811393 9.8343e-006 0 0.00132753 0.00388142 0.00361224 0.00451416 0.01015 0.0469576 0.0299513 0.0109873 0.00487758 0.000384052 0.000499843 0.000918983 0.0014201 0.00197194 0.0115143 0.00651754 0.00495107 0.00650676 0.0023659 0.00248603 0.00477859 0.00870649 0.00599931 0.00463824 0.0591807 0.01438 0.0204461 0.025102 0.0138052 0.0130627 0.0221162 0.0123324 0.0114742 0.0150815 0.0175424 0.0137458 0.0125877 0.0487788 0.0396576 0.0136077 0.023898 0.021299 0.0147888 0.0128043 0.0191155 0.0124095 0.0118148 0.0209087 0.0185483 0.0204905 0.0144236 0.0127125 0.0121719 0.00792673 0.00843978 0.0081346 0.00853131 0.010873 0.00666216 0.00666216
# GOM_US_MEX_LL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000314942 0.000426191 0.000621728 0.000422426 0.000738816 0.000325426 0.000764772 0.000703174 0.000368484 0.00371503 0.000615778 0.000559121 0.00370043 0.00534569 0.00758468 0.00964676 0.0128927 0.00813213 0.0128234 0.0157933 0.0102761 0.00570121 0.0044574 0.00458343 0.00437776 0.00206255 0.00199827 0.00467702 0.00550832 0.0023487 0.00352511 0.00580927 0.0117372 0.00929809 0.00747818 0.00652037 0.00868218 0.00873624 0.00490606 0.00176131 0.00917938 0.00302025 0.00470492 0.00302991 0.00307595 0.00202952 0.00372079 0.00182743 0.00138245 0.00138245
# JPNLL_GOM 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00288438 0.0513535 0.100172 0.15161 0.17179 0.196857 0.243759 0.201478 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# USA_CAN_PSFS 6.95923e-005 0.00698457 0 0 0.00390493 0 0 0 0.00985694 0.0573663 0.0208387 0.0689097 0.313147 0.471667 0.490599 0.354704 0.129164 0.343955 0.125175 0.247986 0.760423 0.92179 0.58004 0.464438 0.188736 0.340999 0.20493 0.213512 0.268074 0.383479 0.269902 0.278996 0.0507099 0.0407991 0.0172942 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# USA_CAN_PSFB 1.93706e-006 0.000193883 0 0 0.000106666 0 0 0 0.000268224 0.00152606 0.000544615 0.00178795 0.00756999 0.0121661 0.0122783 0.00964197 0.00357168 0.00889587 0.00343123 0 0.0358934 0.0233973 0.0189292 0.0120764 0.00351981 0.0190015 0.016314 0.019714 0.0128446 0.0451214 0.024876 0.0402614 0.0132732 0.0270043 0.0380794 0.0493957 0.0554627 0.0616951 0.0645949 0.0590047 0.0509216 0.0282904 0.0337098 0.0319872 0.0320982 0.026748 0.0262963 0.0251852 0.0234755 0.0234058 0.0275676 0.0201886 0.020237 0.024514 0.00292961 0.0172663 0.000370446 0.00296152 0 0.00112081 0 0 0.000118724 0.0027568 0.00259993 0.00239531 0 0 0 0 0 0
# USA_TRAP 0.00994518 0.0141351 0.00388784 0.0220958 0.0154374 0.0110105 0.00528476 0.0117873 0.0255452 0.00903209 0.00622674 0.00245942 0.00285001 0.00288206 0.00848445 0.0121335 0.0117763 0.0126321 0.00225429 0.00338384 0.0051195 0.0059593 0.00498874 0.00252667 0.00400791 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7.64534e-005 7.64534e-005
# CAN_TRAP 6.97719e-005 0.000181761 0.000437873 0 0 0 0 0 0 0.000535475 0.000217339 0.000537931 0.000938509 0.00159757 0.00231203 0.000627398 0.000725154 0.00156757 0.000986466 0.00204281 0.00149049 0.00073258 0.000389019 0.00207829 0.00398308 0.00244718 0.00328092 0.00820403 0.00572548 0.000948634 0.00170009 0.00172507 0.00315376 0.000341711 0.000155267 0.00111246 0 0.00114729 0.00104858 8.31501e-005 0.000179337 0 9.39787e-005 0.00270619 0.00727438 0.00657513 0.0081971 0.00533343 0.00604609 0.00390656 0.00141188 0.00140058 0.00251314 0.0074414 0.00274082 0.000695267 0.000242233 0.000286015 0.00181462 0.00184862 0.00303522 0.00198302 0.00117485 0.000742874 0.00117397 0.000362747 0.000504783 0.000635091 0.000134063 0.000180954 0.000159113 0.000159113
# USA_CAN_HARPOON 0.00339634 0.00194801 0.00239382 0.00145984 0.000956264 0.00100082 0.000348277 0.00042955 0.000452322 0.000930322 0.000889527 0.000586075 0.000334379 0.000173449 0.000206981 0.00054304 0.000521533 0.000681608 0.000873033 0.000461599 0.00117874 0.00288956 0.00300251 0.00176227 0.00486608 0.00599945 0.00563597 0.00555311 0.0066155 0.00670112 0.00493035 0.00551043 0.00458841 0.00888992 0.00706333 0.0114426 0.00980204 0.010232 0.0131622 0.0157858 0.0103669 0.0100139 0.0078986 0.00889548 0.00738347 0.00880642 0.00925271 0.0102887 0.0109822 0.0102041 0.0141204 0.00843966 0.00444291 0.00629238 0.00315196 0.00305352 0.00343811 0.00274032 0.00358104 0.00541608 0.0040398 0.00540638 0.00414196 0.00320909 0.00350211 0.00443702 0.00313744 0.00381714 0.00286752 0.00607578 0.00510026 0.00510026
# USA_HARPOON 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# USA_RRFS 0.00186649 4.92601e-005 0 0.000247518 0.00064942 0.000200829 0.000100303 0.000750183 0.000151226 0.000361387 0.000506741 0.00129281 0.00784492 0.0283021 0.0166504 0.0398905 0.157575 0.0133286 0.0242445 0.0153608 0.00915518 0.0271272 0.0320515 0.0083261 0.461631 0.0192439 0.00377956 0.00718766 0.00626739 0.0170766 0.0235392 0.0265076 0.0333523 0.0353589 0.0272965 0.0274013 0.0167872 0.0252624 0.022421 0.0304832 0.0886693 0.0947466 0.0221502 0.0566547 0.0210194 0.0661994 0.115772 0.0602995 0.0412983 0.0223343 0.0144348 0.0975749 0.200364 0.116226 0.108186 0.0493054 0.0402415 0.0855894 0.0678482 0.0309603 0.0274608 0.0442066 0.0356068 0.0229089 0.0226467 0.0333272 0.042339 0.0424004 0.0384795 0.0516858 0.0382438 0.0382438
# USA_RRFB 0.000577309 0.00101789 0.000624247 0.000565086 0.000302382 9.20331e-005 9.19846e-005 0.000124766 0.000420765 0.000382688 0.000301176 0.000287245 0.00159469 0.00467279 0.00236249 0.00513953 0.0217329 0.00219836 0.00350683 0.0101568 0.00641561 0.0146078 0.017649 0.00993673 0.00372078 0.0104155 0.00996681 0.0157944 0.023321 0.0258652 0.0232693 0.0208443 0.0177838 0.0312502 0.030681 0.0370409 0.028164 0.0409443 0.0351652 0.0457661 0.0358245 0.0396379 0.029871 0.036832 0.041879 0.0431623 0.03347 0.0456057 0.0374665 0.0403615 0.0394671 0.0606102 0.0584941 0.0396572 0.023142 0.0154827 0.0133115 0.014221 0.0179767 0.0408586 0.0305144 0.0202659 0.0188912 0.010507 0.0151727 0.0222491 0.025981 0.022905 0.0266744 0.0279045 0.0302823 0.0302823
# CAN_combinedHL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# CAN_SWNS_HLnoHP 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0264096 0.0567438 0.0373765 0.0386561 0.0300506 0.0181185 0.0139921 0.0179909 0.0289991 0.0221719 0.0268344 0.0228299 0.0215778 0.0264153 0.0260032 0.0185955 0.0167517 0.0215759 0.0269356 0.0154182 0.0176614 0.0117472 0.011801 0.00884175 0.00845579 0.00783967 0.00533313 0.00556688 0.00351992 0.00380286 0.00409771 0.00517367 0.0038102 0.0038102
# CAN_SWNS_HLwithHP 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# CAN_GSL_HL 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000601178 0 0.00301775 0.00475442 0.0101662 0.0202793 0.0138983 0.0327386 0.0140042 0.0139112 0.0157496 0.0231749 0.03352 0.021164 0.0291304 0.0277331 0.033633 0.0340259 0.040964 0.0269408 0.0326395 0.0211896 0.0152868 0.0149617 0.0158819 0.0140933 0.0149762 0.0166366 0.0141753 0.0137146 0.013525 0.0165017 0.015406 0.015406
# CAN_GSL_old 0.000474986 0.000545317 0.000437993 0.000184183 0.000311151 5.71161e-005 1.90193e-005 2.53306e-005 0 8.86234e-005 3.16819e-005 0.000260144 0.000254823 0.000580366 0.000655168 0.00064695 0.000802038 0.000427747 0.00146049 0.00147124 0.00140335 0.000883692 0.00203972 0.0027899 0.00512623 0.00279609 0.00514522 0.00517793 0.00413851 0.00499623 0.0071815 0.00920089 0.0164513 0.0175672 0.011588 0.00581157 0.0021234 0.00187948 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
        18         1         0         0         0         1  #  IDX1_JAPAN_LL
        19         1         0         0         0         1  #  IDX2_JAPAN_LL2
        22         1         0         0         0         1  #  IDX5_MEXUSLL_GOM_LL
        23         1         0         0         0         1  #  IDX6_JPNLL_GOM
        26         1         0         0         0         1  #  IDX9_US_RR_66_144
        27         1         0         0         0         1  #  IDX10_US_RR_LT145
        28         1         1         0         0         0  #  IDX11_US_RR_GT177
        29         1         0         0         0         1  #  IDX12_US_RR_GT195
        31         1         1         0         0         0  #  IDX14_CAN_SWNS
        32         1         1         0         0         0  #  IDX15_CAN_GSL
        33         1         1         0         0         0  #  IDX16_CAN_ACOUSTIC
        34         1         0         0         0         1  #  IDX17_GOMlarval
        36         1         0         0         0         1  #  IDX19_oceanographic
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -10            -2      -4.74914             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX1_JAPAN_LL(18)
           -10            -2      -4.44093             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX2_JAPAN_LL2(19)
           -10            -2      -4.18042             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX5_MEXUSLL_GOM_LL(22)
           -10            -2      -4.27071             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX6_JPNLL_GOM(23)
           -10            -2      -5.06323             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX9_US_RR_66_144(26)
           -10            -2      -5.44132             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX10_US_RR_LT145(27)
           -10            -2      -4.26025             0             1             0          1        101          0          0          0          0          0          0  #  LnQ_base_IDX11_US_RR_GT177(28)
           -10            -2      -3.82276             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX12_US_RR_GT195(29)
           -10            -2      -4.13578             0             1             0          1        101          0          0          0          0          0          0  #  LnQ_base_IDX14_CAN_SWNS(31)
           -10            -2      -6.10122             0             1             0          1        101          0          0          0          0          0          0  #  LnQ_base_IDX15_CAN_GSL(32)
           -10            -2      -6.55174             0             1             0          1        101          0          0          0          0          0          0  #  LnQ_base_IDX16_CAN_ACOUSTIC(33)
           -10            -2       -5.1509             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX17_GOMlarval(34)
           -10            -2      -1.54468             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_IDX19_oceanographic(36)
# timevary Q parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type     PHASE  #  parm_name
            -2             2      0.173377             0             0             0      3  # LnQ_base_IDX11_US_RR_GT177(28)_ENV_mult
            -2             2     -0.135056             0             0             0      3  # LnQ_base_IDX14_CAN_SWNS(31)_ENV_mult
            -2             2     -0.215487             0             0             0      3  # LnQ_base_IDX15_CAN_GSL(32)_ENV_mult
            -2             2    -0.0366599             0             0             0      3  # LnQ_base_IDX16_CAN_ACOUSTIC(33)_ENV_mult
# info on dev vectors created for Q parms are reported with other devs after tag parameter section 
#
#_size_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for all sizes
#Pattern:_1; parm=2; logistic; with 95% width specification
#Pattern:_5; parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6; parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8; parm=8; New doublelogistic with smooth transitions and constant above Linf option
#Pattern:_9; parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in size
#Pattern:_27; parm=3+special; cubic spline 
#Pattern:_42; parm=2+special+3; // like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 JAPAN_LL
 24 0 0 0 # 2 OTHER_ATL_LL
 24 0 0 0 # 3 GOM_US_MEX_LL
 24 0 0 0 # 4 JPNLL_GOM
 24 0 0 0 # 5 USA_CAN_PSFS
 24 0 0 0 # 6 USA_CAN_PSFB
 24 0 0 0 # 7 USA_TRAP
 24 0 0 0 # 8 CAN_TRAP
 24 0 0 0 # 9 USA_CAN_HARPOON
 1 0 0 0 # 10 USA_HARPOON
 24 0 0 0 # 11 USA_RRFS
 24 0 0 0 # 12 USA_RRFB
 1 0 0 0 # 13 CAN_combinedHL
 24 0 0 0 # 14 CAN_SWNS_HLnoHP
 1 0 0 0 # 15 CAN_SWNS_HLwithHP
 24 0 0 0 # 16 CAN_GSL_HL
 1 0 0 0 # 17 CAN_GSL_old
 15 0 0 1 # 18 IDX1_JAPAN_LL
 15 0 0 1 # 19 IDX2_JAPAN_LL2
 15 0 0 3 # 20 IDX3_USPLL_GOM
 15 0 0 3 # 21 IDX4_USPLL_GOM2
 15 0 0 3 # 22 IDX5_MEXUSLL_GOM_LL
 15 0 0 4 # 23 IDX6_JPNLL_GOM
 24 0 0 0 # 24 IDX7_US_RR_66_114
 24 0 0 0 # 25 IDX8_US_RR_115_144
 15 0 0 11 # 26 IDX9_US_RR_66_144
 15 0 0 7 # 27 IDX10_US_RR_LT145
 15 0 0 6 # 28 IDX11_US_RR_GT177
 15 0 0 6 # 29 IDX12_US_RR_GT195
 15 0 0 13 # 30 IDX13_CAN_combinedHL
 15 0 0 14 # 31 IDX14_CAN_SWNS
 15 0 0 16 # 32 IDX15_CAN_GSL
 15 0 0 16 # 33 IDX16_CAN_ACOUSTIC
 15 0 0 10 # 34 IDX17_GOMlarval
 30 0 0 0 # 35 IDX18_tagging
 31 0 0 0 # 36 IDX19_oceanographic
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#_Pattern Discard Male Special
 10 0 0 0 # 1 JAPAN_LL
 10 0 0 0 # 2 OTHER_ATL_LL
 10 0 0 0 # 3 GOM_US_MEX_LL
 10 0 0 0 # 4 JPNLL_GOM
 10 0 0 0 # 5 USA_CAN_PSFS
 10 0 0 0 # 6 USA_CAN_PSFB
 10 0 0 0 # 7 USA_TRAP
 10 0 0 0 # 8 CAN_TRAP
 10 0 0 0 # 9 USA_CAN_HARPOON
 10 0 0 0 # 10 USA_HARPOON
 10 0 0 0 # 11 USA_RRFS
 10 0 0 0 # 12 USA_RRFB
 10 0 0 0 # 13 CAN_combinedHL
 10 0 0 0 # 14 CAN_SWNS_HLnoHP
 10 0 0 0 # 15 CAN_SWNS_HLwithHP
 10 0 0 0 # 16 CAN_GSL_HL
 10 0 0 0 # 17 CAN_GSL_old
 10 0 0 0 # 18 IDX1_JAPAN_LL
 10 0 0 0 # 19 IDX2_JAPAN_LL2
 10 0 0 0 # 20 IDX3_USPLL_GOM
 10 0 0 0 # 21 IDX4_USPLL_GOM2
 10 0 0 0 # 22 IDX5_MEXUSLL_GOM_LL
 10 0 0 0 # 23 IDX6_JPNLL_GOM
 10 0 0 0 # 24 IDX7_US_RR_66_114
 10 0 0 0 # 25 IDX8_US_RR_115_144
 10 0 0 0 # 26 IDX9_US_RR_66_144
 10 0 0 0 # 27 IDX10_US_RR_LT145
 10 0 0 0 # 28 IDX11_US_RR_GT177
 10 0 0 0 # 29 IDX12_US_RR_GT195
 10 0 0 0 # 30 IDX13_CAN_combinedHL
 10 0 0 0 # 31 IDX14_CAN_SWNS
 10 0 0 0 # 32 IDX15_CAN_GSL
 10 0 0 0 # 33 IDX16_CAN_ACOUSTIC
 10 0 0 0 # 34 IDX17_GOMlarval
 0 0 0 0 # 35 IDX18_tagging
 10 0 0 0 # 36 IDX19_oceanographic
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   JAPAN_LL LenSelex
           120           250       223.829           120          1000             0          2          0          3       2011       2015          6          1          2  #  Size_DblN_peak_JAPAN_LL(1)
           -15             3      -11.6798      -1.16787          1000             0          2          0          0          0          0          0          1          2  #  Size_DblN_top_logit_JAPAN_LL(1)
            -5             9       7.09927       4.81298          1000             0          3          0          0          0          0          0          1          2  #  Size_DblN_ascend_se_JAPAN_LL(1)
            -5             9       5.74841       6.75951          1000             0          5          0          0          0          0          0          1          2  #  Size_DblN_descend_se_JAPAN_LL(1)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_JAPAN_LL(1)
           -20            10      -3.18679             2           100             0          6          0          0          0          0          0          1          2  #  Size_DblN_end_logit_JAPAN_LL(1)
# 2   OTHER_ATL_LL LenSelex
           120           285       214.211           120          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_OTHER_ATL_LL(2)
           -15             3      -11.6409      -1.16787          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_OTHER_ATL_LL(2)
            -5             9        8.0343       4.81298          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_OTHER_ATL_LL(2)
            -5             9       7.11862       6.75951          1000             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_OTHER_ATL_LL(2)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_OTHER_ATL_LL(2)
           -20            10      -2.52811             2           100             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_OTHER_ATL_LL(2)
# 3   GOM_US_MEX_LL LenSelex
           120           285       242.584           120          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_GOM_US_MEX_LL(3)
           -15             3      -11.9856      -1.16787          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_GOM_US_MEX_LL(3)
            -5             9       7.46492       4.81298          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_GOM_US_MEX_LL(3)
            -5             9      -4.99753       6.75951          1000             0         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_GOM_US_MEX_LL(3)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_GOM_US_MEX_LL(3)
           -20            10      0.463658             2           100             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_GOM_US_MEX_LL(3)
# 4   JPNLL_GOM LenSelex
           120           285       232.976           120          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_JPNLL_GOM(4)
           -15             3      -11.8237      -1.16787          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_JPNLL_GOM(4)
            -5             9       6.62472       4.81298          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_JPNLL_GOM(4)
            -5             9       6.21873       6.75951          1000             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_JPNLL_GOM(4)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_JPNLL_GOM(4)
           -20            10      -3.66616             2           100             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_JPNLL_GOM(4)
# 5   USA_CAN_PSFS LenSelex
            50           200       74.3773       68.4973           0.1             1          3          0          0          0          0          0          0          0  #  Size_DblN_peak_USA_CAN_PSFS(5)
            -5             3            -2          -1.5        0.0001             1         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_USA_CAN_PSFS(5)
            -4            12       4.72797           0.5           0.1             1          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_USA_CAN_PSFS(5)
            -5             6        5.9923           1.4          0.05             0         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_USA_CAN_PSFS(5)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_USA_CAN_PSFS(5)
           -15            10          -999          -4.6          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_USA_CAN_PSFS(5)
# 6   USA_CAN_PSFB LenSelex
           150           285       212.229           120           0.1             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_USA_CAN_PSFB(6)
            -5             3      -2.18515            -5          0.05             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_USA_CAN_PSFB(6)
            -4             8       6.85257           0.5           0.1             1          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_USA_CAN_PSFB(6)
            -2             6       5.99989           1.4          0.05             0         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_USA_CAN_PSFB(6)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_USA_CAN_PSFB(6)
           -15             5        -4.038           4.6          0.05             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_USA_CAN_PSFB(6)
# 7   USA_TRAP LenSelex
            80           150       124.726           120          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_peak_USA_TRAP(7)
            -5             3      -2.27338            -4           0.1             1          3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_USA_TRAP(7)
            -4            10       7.85593           2.2          0.05             0         -4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_USA_TRAP(7)
            -2            10       7.41112           1.2           0.1             1          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_USA_TRAP(7)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_USA_TRAP(7)
           -15            10          -999          -4.6          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_USA_TRAP(7)
# 8   CAN_TRAP LenSelex
           120           285       270.933           120          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_CAN_TRAP(8)
           -15             3      -12.1142      -1.16787          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_CAN_TRAP(8)
            -5             9       7.82217       4.81298          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_CAN_TRAP(8)
            -5             9       4.78631       6.75951          1000             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_CAN_TRAP(8)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_CAN_TRAP(8)
           -20            10      -2.61201             2           100             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_CAN_TRAP(8)
# 9   USA_CAN_HARPOON LenSelex
           120           285       192.194           120          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_USA_CAN_HARPOON(9)
           -15             3      -1.22254      -1.16787          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_USA_CAN_HARPOON(9)
            -5             9        5.7307       4.81298          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_USA_CAN_HARPOON(9)
            -5             9       7.33835       6.75951          1000             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_USA_CAN_HARPOON(9)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_USA_CAN_HARPOON(9)
           -20            10      -3.18928             2           100             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_USA_CAN_HARPOON(9)
# 10   USA_HARPOON LenSelex
           100           220       177.036           150           0.2             0         -2          0          0          0          0          0          0          0  #  Size_inflection_USA_HARPOON(10)
            10            60       17.0894            40           0.2             0         -2          0          0          0          0          0          0          0  #  Size_95%width_USA_HARPOON(10)
# 11   USA_RRFS LenSelex
            80           120       111.905           106            40             6          2          0          0          0          0          0          2          2  #  Size_DblN_peak_USA_RRFS(11)
            -5             3      -1.91511            -5             5             1          3          0          0          0          0          0          2          2  #  Size_DblN_top_logit_USA_RRFS(11)
            -4             8       6.51435           2.2          0.05             0         -4          0          0          0          0          0          2          2  #  Size_DblN_ascend_se_USA_RRFS(11)
            -5             4      -3.07737           1.2          0.05             0          5          0          0          0          0          0          2          2  #  Size_DblN_descend_se_USA_RRFS(11)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_USA_RRFS(11)
           -15            10          -999         -14.6          0.05             0         -6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_USA_RRFS(11)
# 12   USA_RRFB LenSelex
           140           220       195.425           190            50             6          2          0          0          0          0          0          0          0  #  Size_DblN_peak_USA_RRFB(12)
            -5             1     -0.262777            -5          0.05             0          3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_USA_RRFB(12)
            -4             8       6.68412           0.5          0.05             0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_USA_RRFB(12)
            -2             8        2.0829           1.4          0.05             1         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_USA_RRFB(12)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_USA_RRFB(12)
           -15             5      -1.70827           4.6          0.05             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_USA_RRFB(12)
# 13   CAN_combinedHL LenSelex
           160           220       194.826           150           0.2             0         -2          0          0          0          0          0          0          0  #  Size_inflection_CAN_combinedHL(13)
            10            50       33.0026            40           0.2             0         -2          0          0          0          0          0          0          0  #  Size_95%width_CAN_combinedHL(13)
# 14   CAN_SWNS_HLnoHP LenSelex
           120           285       210.265           120          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_peak_CAN_SWNS_HLnoHP(14)
           -15             3      -2.85716      -1.16787          1000             0          2          0          0          0          0          0          0          0  #  Size_DblN_top_logit_CAN_SWNS_HLnoHP(14)
            -5             9       6.60317       4.81298          1000             0          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_CAN_SWNS_HLnoHP(14)
            -5             9       7.73094       6.75951          1000             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_CAN_SWNS_HLnoHP(14)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          0  #  Size_DblN_start_logit_CAN_SWNS_HLnoHP(14)
           -20            10       -3.8286             2           100             0          6          0          0          0          0          0          0          0  #  Size_DblN_end_logit_CAN_SWNS_HLnoHP(14)
# 15   CAN_SWNS_HLwithHP LenSelex
           150           250       194.826           150           0.2             0         -2          0          0          0          0          0          0          0  #  Size_inflection_CAN_SWNS_HLwithHP(15)
            10            50       33.0026            40           0.2             0         -2          0          0          0          0          0          0          0  #  Size_95%width_CAN_SWNS_HLwithHP(15)
# 16   CAN_GSL_HL LenSelex
           120           330       249.713           120          1000             0          3          0          0          0          0          0          3          2  #  Size_DblN_peak_CAN_GSL_HL(16)
           -15             3      -11.4704      -1.16787          1000             0          3          0          0          0          0          0          3          2  #  Size_DblN_top_logit_CAN_GSL_HL(16)
            -5             9       7.32814       4.81298          1000             0          4          0          0          0          0          0          3          2  #  Size_DblN_ascend_se_CAN_GSL_HL(16)
            -5             9       6.33812       6.75951          1000             0          5          0          0          0          0          0          3          2  #  Size_DblN_descend_se_CAN_GSL_HL(16)
          -999            15          -999            -1             5             0         -3          0          0          0          0          0          0          2  #  Size_DblN_start_logit_CAN_GSL_HL(16)
           -20            10      -3.14319             2           100             0          6          0          0          0          0          0          3          2  #  Size_DblN_end_logit_CAN_GSL_HL(16)
# 17   CAN_GSL_old LenSelex
           210           330       245.057           150           0.2             0          2          0          0          0          0          0          0          0  #  Size_inflection_CAN_GSL_old(17)
             5            30       14.5234            40           0.2             0          2          0          0          0          0          0          0          0  #  Size_95%width_CAN_GSL_old(17)
# 18   IDX1_JAPAN_LL LenSelex
# 19   IDX2_JAPAN_LL2 LenSelex
# 20   IDX3_USPLL_GOM LenSelex
# 21   IDX4_USPLL_GOM2 LenSelex
# 22   IDX5_MEXUSLL_GOM_LL LenSelex
# 23   IDX6_JPNLL_GOM LenSelex
# 24   IDX7_US_RR_66_114 LenSelex
            40           200            65           120          1000             0         -3          0          0          0          0          0          0          0  #  Size_DblN_peak_IDX7_US_RR_66_114(24)
            -5             3          -1.7            -5          0.05             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_IDX7_US_RR_66_114(24)
            -4            12            -4           2.2          0.05             0         -3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_IDX7_US_RR_66_114(24)
          -2.5             6            -2           1.2          0.05             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_IDX7_US_RR_66_114(24)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_IDX7_US_RR_66_114(24)
           -15            10            -5         -14.6          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_IDX7_US_RR_66_114(24)
# 25   IDX8_US_RR_115_144 LenSelex
            40           200           115           120          1000             0         -3          0          0          0          0          0          0          0  #  Size_DblN_peak_IDX8_US_RR_115_144(25)
            -5             3          -2.1            -5          0.05             0         -3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_IDX8_US_RR_115_144(25)
            -4            12            -4           2.2          0.05             0         -3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_IDX8_US_RR_115_144(25)
          -2.5             6            -2           1.2          0.05             0         -3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_IDX8_US_RR_115_144(25)
           -15             5          -999         -14.5          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_IDX8_US_RR_115_144(25)
           -15            10            -5         -14.6          0.05             0         -2          0          0          0          0          0          0          0  #  Size_DblN_end_logit_IDX8_US_RR_115_144(25)
# 26   IDX9_US_RR_66_144 LenSelex
# 27   IDX10_US_RR_LT145 LenSelex
# 28   IDX11_US_RR_GT177 LenSelex
# 29   IDX12_US_RR_GT195 LenSelex
# 30   IDX13_CAN_combinedHL LenSelex
# 31   IDX14_CAN_SWNS LenSelex
# 32   IDX15_CAN_GSL LenSelex
# 33   IDX16_CAN_ACOUSTIC LenSelex
# 34   IDX17_GOMlarval LenSelex
# 35   IDX18_tagging LenSelex
# 36   IDX19_oceanographic LenSelex
# 1   JAPAN_LL AgeSelex
# 2   OTHER_ATL_LL AgeSelex
# 3   GOM_US_MEX_LL AgeSelex
# 4   JPNLL_GOM AgeSelex
# 5   USA_CAN_PSFS AgeSelex
# 6   USA_CAN_PSFB AgeSelex
# 7   USA_TRAP AgeSelex
# 8   CAN_TRAP AgeSelex
# 9   USA_CAN_HARPOON AgeSelex
# 10   USA_HARPOON AgeSelex
# 11   USA_RRFS AgeSelex
# 12   USA_RRFB AgeSelex
# 13   CAN_combinedHL AgeSelex
# 14   CAN_SWNS_HLnoHP AgeSelex
# 15   CAN_SWNS_HLwithHP AgeSelex
# 16   CAN_GSL_HL AgeSelex
# 17   CAN_GSL_old AgeSelex
# 18   IDX1_JAPAN_LL AgeSelex
# 19   IDX2_JAPAN_LL2 AgeSelex
# 20   IDX3_USPLL_GOM AgeSelex
# 21   IDX4_USPLL_GOM2 AgeSelex
# 22   IDX5_MEXUSLL_GOM_LL AgeSelex
# 23   IDX6_JPNLL_GOM AgeSelex
# 24   IDX7_US_RR_66_114 AgeSelex
# 25   IDX8_US_RR_115_144 AgeSelex
# 26   IDX9_US_RR_66_144 AgeSelex
# 27   IDX10_US_RR_LT145 AgeSelex
# 28   IDX11_US_RR_GT177 AgeSelex
# 29   IDX12_US_RR_GT195 AgeSelex
# 30   IDX13_CAN_combinedHL AgeSelex
# 31   IDX14_CAN_SWNS AgeSelex
# 32   IDX15_CAN_GSL AgeSelex
# 33   IDX16_CAN_ACOUSTIC AgeSelex
# 34   IDX17_GOMlarval AgeSelex
# 35   IDX18_tagging AgeSelex
# 36   IDX19_oceanographic AgeSelex
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
           120           285        165.61           120             1             0      5  # Size_DblN_peak_JAPAN_LL(1)_BLK1repl_1950
        0.0001           100            50            50            20             0      -5  # Size_DblN_peak_JAPAN_LL(1)_dev_se
         -0.99          0.99             0             0           0.5             6      -6  # Size_DblN_peak_JAPAN_LL(1)_dev_autocorr
           -10             1      -3.33571         -1.16             1             0      5  # Size_DblN_top_logit_JAPAN_LL(1)_BLK1repl_1950
            -1             9       7.62543          4.81             1             0      -5  # Size_DblN_ascend_se_JAPAN_LL(1)_BLK1repl_1950
            -1             9       7.47779          6.75             1             0      5  # Size_DblN_descend_se_JAPAN_LL(1)_BLK1repl_1950
           -20             1      -6.17582             2             1             0      5  # Size_DblN_end_logit_JAPAN_LL(1)_BLK1repl_1950
            60           110       83.5143            88            30             6      5  # Size_DblN_peak_USA_RRFS(11)_BLK2repl_1950
            -5             3      -1.11914            -5          0.05             1      5  # Size_DblN_top_logit_USA_RRFS(11)_BLK2repl_1950
            -4            10       6.00972           2.2          0.05             0      -5  # Size_DblN_ascend_se_USA_RRFS(11)_BLK2repl_1950
            -2             4      -1.92287           1.2          0.05             0      -5  # Size_DblN_descend_se_USA_RRFS(11)_BLK2repl_1950
           120           330       297.856           120             1             0      5  # Size_DblN_peak_CAN_GSL_HL(16)_BLK3repl_1950
           -15             3      -7.14244         -1.16             1             0      5  # Size_DblN_top_logit_CAN_GSL_HL(16)_BLK3repl_1950
            -5             9       7.62543          4.81             1             0      -5  # Size_DblN_ascend_se_CAN_GSL_HL(16)_BLK3repl_1950
            -5             9             9          6.75             1             0      5  # Size_DblN_descend_se_CAN_GSL_HL(16)_BLK3repl_1950
           -20            10            10             2             1             0     -5  # Size_DblN_end_logit_CAN_GSL_HL(16)_BLK3repl_1950
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity(0/1):  experimental feature
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      3     7     1     0     0     1     1     0     0     0     0     0
#      3     9     2     0     0     1     1     0     0     0     0     0
#      3    10     3     0     0     1     1     0     0     0     0     0
#      3    11     4     0     0     1     1     0     0     0     0     0
#      5     1     5     1     2     0     0     1     3  2011  2015     6 -0.758866 0.36702 0.464937 0.0324654 0.0584509
#      5     2     8     1     2     0     0     0     0     0     0     0
#      5     3     9     1     2     0     0     0     0     0     0     0
#      5     4    10     1     2     0     0     0     0     0     0     0
#      5     6    11     1     2     0     0     0     0     0     0     0
#      5    57    12     2     2     0     0     0     0     0     0     0
#      5    58    13     2     2     0     0     0     0     0     0     0
#      5    59    14     2     2     0     0     0     0     0     0     0
#      5    60    15     2     2     0     0     0     0     0     0     0
#      5    79    16     3     2     0     0     0     0     0     0     0
#      5    80    17     3     2     0     0     0     0     0     0     0
#      5    81    18     3     2     0     0     0     0     0     0     0
#      5    82    19     3     2     0     0     0     0     0     0     0
#      5    84    20     3     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1  0.405798
      4      2  0.453899
      4      3  0.428567
      4      4  0.722765
      4      5  0.057643
      4      6  0.172839
      4      7  0.122579
      4      8  0.380007
      4      9   0.55106
      4     11  0.174534
      4     12  0.544395
      4     14   0.92175
      4     16   0.69801
      4     17  0.292039
      5      1  0.125644
      5      2   0.25683
      5      3  0.668211
      5      5  0.598858
      5      6  0.233015
      5      7   0.18426
      5      8  0.605775
      5      9  0.282326
      5     12  0.603047
 -9999   1    0  # terminator
#
7 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 46 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 1 18 1 1 1
 1 19 1 1 1
 1 20 1 0 1
 1 21 1 0 1
 1 22 1 1 1
 1 23 1 1 1
 1 24 1 0 1
 1 25 1 0 1
 1 26 1 1 1
 1 27 1 1 1
 1 28 1 1 1
 1 29 1 1 1
 1 30 1 0 1
 1 31 1 1 1
 1 32 1 1 1
 1 33 1 1 1
 1 34 1 1 1
 1 35 1 0 1
 1 36 1 0 1
 4 1 1 1 1
 4 2 1 1 1
 4 3 1 1 1
 4 4 1 1 1
 4 5 1 1 1
 4 6 1 1 1
 4 7 1 1 1
 4 8 1 1 1
 4 9 1 1 1
 4 10 1 0 1
 4 11 1 1 1
 4 12 1 1 1
 4 13 1 0 1
 4 14 1 1 1
 4 15 1 0 1
 4 16 1 1 1
 4 17 1 1 1
 5 1 1 1 1
 5 2 1 1 1
 5 3 1 1 1
 5 5 1 1 1
 5 6 1 1 1
 5 7 1 1 1
 5 8 1 1 1
 5 9 1 1 1
 5 10 1 0 1
 5 12 1 1 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 0 0 0 #_CPUE/survey:_1
#  0 0 0 0 0 0 0 #_CPUE/survey:_2
#  0 0 0 0 0 0 0 #_CPUE/survey:_3
#  0 0 0 0 0 0 0 #_CPUE/survey:_4
#  0 0 0 0 0 0 0 #_CPUE/survey:_5
#  0 0 0 0 0 0 0 #_CPUE/survey:_6
#  0 0 0 0 0 0 0 #_CPUE/survey:_7
#  0 0 0 0 0 0 0 #_CPUE/survey:_8
#  0 0 0 0 0 0 0 #_CPUE/survey:_9
#  0 0 0 0 0 0 0 #_CPUE/survey:_10
#  0 0 0 0 0 0 0 #_CPUE/survey:_11
#  0 0 0 0 0 0 0 #_CPUE/survey:_12
#  0 0 0 0 0 0 0 #_CPUE/survey:_13
#  0 0 0 0 0 0 0 #_CPUE/survey:_14
#  0 0 0 0 0 0 0 #_CPUE/survey:_15
#  0 0 0 0 0 0 0 #_CPUE/survey:_16
#  0 0 0 0 0 0 0 #_CPUE/survey:_17
#  1 1 1 1 1 1 1 #_CPUE/survey:_18
#  1 1 1 1 1 1 1 #_CPUE/survey:_19
#  0 0 0 0 0 0 0 #_CPUE/survey:_20
#  0 0 0 0 0 0 0 #_CPUE/survey:_21
#  1 1 1 1 1 1 1 #_CPUE/survey:_22
#  1 1 1 1 1 1 1 #_CPUE/survey:_23
#  0 0 0 0 0 0 0 #_CPUE/survey:_24
#  0 0 0 0 0 0 0 #_CPUE/survey:_25
#  1 1 1 1 1 1 1 #_CPUE/survey:_26
#  1 1 1 1 1 1 1 #_CPUE/survey:_27
#  1 1 1 1 1 1 1 #_CPUE/survey:_28
#  1 1 1 1 1 1 1 #_CPUE/survey:_29
#  0 0 0 0 0 0 0 #_CPUE/survey:_30
#  1 1 1 1 1 1 1 #_CPUE/survey:_31
#  1 1 1 1 1 1 1 #_CPUE/survey:_32
#  1 1 1 1 1 1 1 #_CPUE/survey:_33
#  1 1 1 1 1 1 1 #_CPUE/survey:_34
#  0 0 0 0 0 0 0 #_CPUE/survey:_35
#  0 0 0 0 0 0 0 #_CPUE/survey:_36
#  1 1 1 1 1 1 1 #_lencomp:_1
#  1 1 1 1 1 1 1 #_lencomp:_2
#  1 1 1 1 1 1 1 #_lencomp:_3
#  1 1 1 1 1 1 1 #_lencomp:_4
#  1 1 1 1 1 1 1 #_lencomp:_5
#  1 1 1 1 1 1 1 #_lencomp:_6
#  1 1 1 1 1 1 1 #_lencomp:_7
#  1 1 1 1 1 1 1 #_lencomp:_8
#  1 1 1 1 1 1 1 #_lencomp:_9
#  0 0 0 0 0 0 0 #_lencomp:_10
#  1 1 1 1 1 1 1 #_lencomp:_11
#  1 1 1 1 1 1 1 #_lencomp:_12
#  0 0 0 0 0 0 0 #_lencomp:_13
#  1 1 1 1 1 1 1 #_lencomp:_14
#  0 0 0 0 0 0 0 #_lencomp:_15
#  1 1 1 1 1 1 1 #_lencomp:_16
#  1 1 1 1 1 1 1 #_lencomp:_17
#  0 0 0 0 0 0 0 #_lencomp:_18
#  0 0 0 0 0 0 0 #_lencomp:_19
#  0 0 0 0 0 0 0 #_lencomp:_20
#  0 0 0 0 0 0 0 #_lencomp:_21
#  0 0 0 0 0 0 0 #_lencomp:_22
#  0 0 0 0 0 0 0 #_lencomp:_23
#  0 0 0 0 0 0 0 #_lencomp:_24
#  0 0 0 0 0 0 0 #_lencomp:_25
#  0 0 0 0 0 0 0 #_lencomp:_26
#  0 0 0 0 0 0 0 #_lencomp:_27
#  0 0 0 0 0 0 0 #_lencomp:_28
#  0 0 0 0 0 0 0 #_lencomp:_29
#  0 0 0 0 0 0 0 #_lencomp:_30
#  0 0 0 0 0 0 0 #_lencomp:_31
#  0 0 0 0 0 0 0 #_lencomp:_32
#  0 0 0 0 0 0 0 #_lencomp:_33
#  0 0 0 0 0 0 0 #_lencomp:_34
#  0 0 0 0 0 0 0 #_lencomp:_35
#  0 0 0 0 0 0 0 #_lencomp:_36
#  1 1 1 1 1 1 1 #_agecomp:_1
#  1 1 1 1 1 1 1 #_agecomp:_2
#  1 1 1 1 1 1 1 #_agecomp:_3
#  0 0 0 0 0 0 0 #_agecomp:_4
#  1 1 1 1 1 1 1 #_agecomp:_5
#  1 1 1 1 1 1 1 #_agecomp:_6
#  1 1 1 1 1 1 1 #_agecomp:_7
#  1 1 1 1 1 1 1 #_agecomp:_8
#  1 1 1 1 1 1 1 #_agecomp:_9
#  0 0 0 0 0 0 0 #_agecomp:_10
#  0 0 0 0 0 0 0 #_agecomp:_11
#  1 1 1 1 1 1 1 #_agecomp:_12
#  0 0 0 0 0 0 0 #_agecomp:_13
#  0 0 0 0 0 0 0 #_agecomp:_14
#  0 0 0 0 0 0 0 #_agecomp:_15
#  0 0 0 0 0 0 0 #_agecomp:_16
#  0 0 0 0 0 0 0 #_agecomp:_17
#  0 0 0 0 0 0 0 #_agecomp:_18
#  0 0 0 0 0 0 0 #_agecomp:_19
#  0 0 0 0 0 0 0 #_agecomp:_20
#  0 0 0 0 0 0 0 #_agecomp:_21
#  0 0 0 0 0 0 0 #_agecomp:_22
#  0 0 0 0 0 0 0 #_agecomp:_23
#  0 0 0 0 0 0 0 #_agecomp:_24
#  0 0 0 0 0 0 0 #_agecomp:_25
#  0 0 0 0 0 0 0 #_agecomp:_26
#  0 0 0 0 0 0 0 #_agecomp:_27
#  0 0 0 0 0 0 0 #_agecomp:_28
#  0 0 0 0 0 0 0 #_agecomp:_29
#  0 0 0 0 0 0 0 #_agecomp:_30
#  0 0 0 0 0 0 0 #_agecomp:_31
#  0 0 0 0 0 0 0 #_agecomp:_32
#  0 0 0 0 0 0 0 #_agecomp:_33
#  0 0 0 0 0 0 0 #_agecomp:_34
#  0 0 0 0 0 0 0 #_agecomp:_35
#  0 0 0 0 0 0 0 #_agecomp:_36
#  1 1 1 1 1 1 1 #_init_equ_catch
#  1 1 1 1 1 1 1 #_recruitments
#  1 1 1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 0 0 0 0 0 0 0 0 # placeholder for # selex_fleet, 1=len/2=age/3=both, year, N selex bins, 0 or Growth pattern, N growth ages, 0 or NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999


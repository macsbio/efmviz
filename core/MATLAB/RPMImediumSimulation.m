%% RPMI medium composition. 
medium_composition={'EX_ala_L(e)'
'EX_arg_L(e)'
'EX_asn_L(e)'
'EX_asp_L(e)'
'EX_cys_L(e)'
'EX_gln_L(e)' 
'EX_glu_L(e)'
'EX_gly(e)'
'EX_his_L(e)'
'EX_ile_L(e)'
'EX_leu_L(e)'
'EX_lys_L(e)'
'EX_met_L(e)'
'EX_phe_L(e)'
'EX_4HPRO(e)' 
'EX_pro_L(e)'
'EX_ser_L(e)'
'EX_thr_L(e)'
'EX_trp_L(e)'
'EX_tyr_L(e)'
'EX_val_L(e)'
'EX_ascb_L(e)'
'EX_btn(e)'
'EX_chol(e)'
'EX_pnto_R(e)'
'EX_fol(e)'
'EX_ncam(e)'
'EX_pydxn(e)'
'EX_ribflv(e)'
'EX_thm(e)'
'EX_inost(e)'
'EX_ca2(e)'
'EX_fe3(e)'
'EX_k(e)'
'EX_hco3(e)'
'EX_na1(e)'
'EX_pi(e)'
'EX_glc(e)'
'EX_hxan(e)'
'EX_lnlc(e)'
'EX_lipoate(e)'
'EX_pyr(e)'
'EX_thymd(e)'
'EX_gthrd(e)'
'EX_anth(e)'
};

% Medium concentrations
met_Conc_mM=[0.1
1.15
0.15
0.379
0.208
2 
0.136
0.133
0.0968
0.382
0.382
0.274
0.101
0.0909
0.153
0.174
0.286
0.168
0.0245
0.129
0.171
0.00863
0.00082
0.0214
0.000524
0.00227
0.082
0.00485
0.000532
0.00297
0.194
0.424
0
5.33
23.81
127.26
5.63
11.11
0
0
0
1
0
0.00326
0.0073 
];


current_inf = 1000;
set_inf =1000;

cellConc = 2.17*1e6;
t= 48;
cellWeight = 3.645e-12;


%% Definition of basic medium (defines uptake from the medium, not captured by the medium composition, all with same constraints)
mediumCompounds = {'EX_co2(e)'; 'EX_h(e)'; 'EX_h2o(e)'; 'EX_hco3(e)'; 'EX_nh4(e)'; 'EX_o2(e)'; 'EX_pi(e)'; 'EX_so4(e)' };

 mediumCompounds_lb = -100;

%% Determine constraints to simulate medium: 
[modelRPMI,basisMediumRPMI] = setMediumConstraints(model, set_inf, current_inf, medium_composition, met_Conc_mM, cellConc, t, cellWeight, mediumCompounds, mediumCompounds_lb);

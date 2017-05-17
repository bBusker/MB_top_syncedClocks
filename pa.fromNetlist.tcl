
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name MB_top_syncedClocks -dir "D:/Shichen Lu/MB_top_syncedClocks/planAhead_run_4" -part xc6slx25tfgg484-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/Shichen Lu/MB_top_syncedClocks/top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/Shichen Lu/MB_top_syncedClocks} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "top.ucf" [current_fileset -constrset]
add_files [list {top.ucf}] -fileset [get_property constrset [current_run]]
link_design

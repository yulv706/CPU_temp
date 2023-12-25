#Copyright (C)2001-2008 Altera Corporation
#Any megafunction design, and related net list (encrypted or decrypted),
#support information, device programming or simulation file, and any other
#associated documentation or information provided by Altera or a partner
#under Altera's Megafunction Partnership Program may be used only to
#program PLD devices (but not masked PLD devices) from Altera.  Any other
#use of such megafunction design, net list, support information, device
#programming or simulation file, or any other related documentation or
#information is prohibited for any other purpose, including, but not
#limited to modification, reverse engineering, de-compiling, or use with
#any other silicon devices, unless such use is explicitly licensed under
#a separate agreement with Altera or a megafunction partner.  Title to
#the intellectual property, including patents, copyrights, trademarks,
#trade secrets, or maskworks, embodied in any such megafunction design,
#net list, support information, device programming or simulation file, or
#any other related documentation or information provided by Altera or a
#megafunction partner, remains with Altera, the megafunction partner, or
#their respective licensors.  No other licenses, including any licenses
#needed under any third party's intellectual property, are provided herein.
#Copying or modifying any file, or portion thereof, to which this notice
#is attached violates this copyright.






















package nios2_backend_control_regs;
use Exporter;
@ISA = Exporter;
@EXPORT = qw(
    &be_set_control_reg_pipeline_desc
    &be_make_control_regs
);

use cpu_utils;
use cpu_control_reg;
use cpu_control_reg_gen;
use nios_europa;
use nios_ptf_utils;
use nios_common;
use nios_isa;
use nios2_control_regs;
use nios2_common;
use europa_all;
use europa_utils;
use strict;





sub
be_set_control_reg_pipeline_desc
{
    my $Opt = shift;

    my $whoami = "Control registers pipeline desc";

    my $stages = manditory_array($Opt, "stages");
    my $cs = not_empty_scalar($Opt, "control_reg_stage");
    my $rs = check_opt_value($Opt, "rdctl_stage", ["E", "M"], $whoami);
    my $wss = not_empty_scalar($Opt, "wrctl_setup_stage");
    my $wd = not_empty_scalar($Opt, "wrctl_data");

    my $pipeline_desc = {
        stages => $stages,
        control_reg_stage => $cs,
        rdctl_stage => $rs,
        wrctl_setup_stage => $wss,
        wrctl_data => $wd,
        regnum_field_name => "control_regnum",
    };

    if (!defined(set_control_reg_pipeline_desc($pipeline_desc))) {
        &$error("set_control_reg_pipeline_desc() failed");
    }
}

sub 
be_make_control_regs
{
    my $Opt = shift;

    my $whoami = "Control registers";

    my $cs = not_empty_scalar($Opt, "control_reg_stage");
    my $rs = check_opt_value($Opt, "rdctl_stage", ["E", "M"], $whoami);
    my $wss = not_empty_scalar($Opt, "wrctl_setup_stage");
    my $control_regs = manditory_array($Opt, "control_regs");


    my $wdata = "${wss}_wrctl_data";




    foreach my $field (@{get_control_reg_fields($ienable_reg)}) {
        my $f = get_control_reg_field_name($field);
        my $irq = get_control_reg_field_lsb($field);


        set_control_reg_field_input_expr($field,
          "((${wss}_wrctl_ienable & ${wss}_valid) ? 
                   ${wdata}_ienable_reg_${f} :
                   ${cs}_ienable_reg_${f})");
    }
    



    foreach my $field (@{get_control_reg_fields($ipending_reg)}) {
        my $f = get_control_reg_field_name($field);
        my $irq = get_control_reg_field_lsb($field);


        set_control_reg_field_input_expr($field,
          "d_irq[$irq] & ${cs}_ienable_reg_${f} & oci_ienable[$irq]");


        set_control_reg_field_wr_en_expr($field, "1");
    }

    if ($sim_reg) {






        set_control_reg_no_rdctl($sim_reg, 1);

        if ($sim_reg_stop) {



            e_assign->adds(
              [["${cs}_sim_reg_stop_nxt", 1],
                "(${wss}_wrctl_sim & ${wss}_valid) ? ${wdata}_sim_reg_stop :
                                                     ${cs}_sim_reg_stop"],
            );

            e_register->adds(
              {out => ["${cs}_sim_reg_stop", 1],
               in => "${cs}_sim_reg_stop_nxt",       
               enable => "${cs}_en" },
            );
        }

        if ($sim_reg_perf_cnt_en) {
            set_control_reg_field_input_expr($sim_reg_perf_cnt_en,
              "(${wss}_wrctl_sim & ${wss}_valid) ? 
                    ${wdata}_sim_reg_perf_cnt_en :
                    ${cs}_sim_reg_perf_cnt_en");
        }
    }


    if ($advanced_exc) {
        e_assign->adds(




          [["${cs}_status_reg_pie_inst_nxt", $status_reg_pie_sz],
            "${wss}_op_eret         ? ${cs}_estatus_reg[$status_reg_pie_lsb] :
             ${wss}_op_bret         ? ${cs}_bstatus_reg[$status_reg_pie_lsb] :
             ${wss}_wrctl_status    ? ${wdata}_status_reg_pie :
                                      ${cs}_status_reg_pie"],

        );




        set_control_reg_field_input_expr($status_reg_pie,
          "${wss}_exc_any_active  ? 1'b0 :
           ${wss}_valid           ? ${cs}_status_reg_pie_inst_nxt : 
                                    ${cs}_status_reg_pie");

        if ($status_reg_u) {
            e_assign->adds(
              [["${cs}_status_reg_u_inst_nxt", $status_reg_u_sz],
                "${wss}_op_eret         ? ${cs}_estatus_reg[$status_reg_u_lsb] :
                 ${wss}_op_bret         ? ${cs}_bstatus_reg[$status_reg_u_lsb] :
                 ${wss}_wrctl_status    ? ${wdata}_status_reg_u :
                                          ${cs}_status_reg_u"],
            );

            set_control_reg_field_input_expr($status_reg_u,
              "${wss}_exc_any_active  ? 1'b0 :
               ${wss}_valid           ? ${cs}_status_reg_u_inst_nxt : 
                                        ${cs}_status_reg_u");
        }

        if ($status_reg_eh) {
            e_assign->adds(
              [["${cs}_status_reg_eh_inst_nxt", $status_reg_eh_sz],
                "${wss}_op_eret       ? ${cs}_estatus_reg[$status_reg_eh_lsb] :
                 ${wss}_op_bret       ? ${cs}_bstatus_reg[$status_reg_eh_lsb] :
                 ${wss}_wrctl_status  ? ${wdata}_status_reg_eh :
                                        ${cs}_status_reg_eh"],
            );

            set_control_reg_field_input_expr($status_reg_eh,
              "${wss}_exc_crst_active ? 1'b0 :
               ${wss}_exc_any_active ? 1'b1 :
               ${wss}_valid          ? ${cs}_status_reg_eh_inst_nxt : 
                                       ${cs}_status_reg_eh");
        }


        my $exc_handler_mode = $status_reg_eh ? "${cs}_status_reg_eh" : "0";


        foreach my $status_field (@{get_control_reg_fields($status_reg)}) {
            my $f = get_control_reg_field_name($status_field);
            my $sz = get_control_reg_field_sz($status_field);
            my $estatus_field = get_control_reg_field($estatus_reg, $f);
            my $bstatus_field = get_control_reg_field($bstatus_reg, $f);

            e_assign->adds(

              [["${cs}_estatus_reg_${f}_inst_nxt", $sz],
                "${wss}_wrctl_estatus ? ${wdata}_estatus_reg_${f}:
                                        ${cs}_estatus_reg_${f}"],


              [["${cs}_bstatus_reg_${f}_inst_nxt", $sz],
                "${wss}_wrctl_bstatus ? ${wdata}_bstatus_reg_${f}:
                                        ${cs}_bstatus_reg_${f}"],
            );

            set_control_reg_field_input_expr($estatus_field,
                "${wss}_exc_crst_active          ? 0 :
                (${wss}_exc_active_no_break & ~$exc_handler_mode) ?
                                                   ${cs}_status_reg_${f} :
                 ${wss}_valid           ? ${cs}_estatus_reg_${f}_inst_nxt : 
                                          ${cs}_estatus_reg_${f}");

            set_control_reg_field_input_expr($bstatus_field,
                "${wss}_exc_break_active ? ${cs}_status_reg_${f} :
                 ${wss}_valid            ? ${cs}_bstatus_reg_${f}_inst_nxt :
                                           ${cs}_bstatus_reg_${f}");
        }

        if ($exception_reg) {



            if ($exception_reg_mea) {
                e_assign->adds(

                  [["${cs}_exception_reg_mea_inst_nxt", $exception_reg_mea_sz],
                    "${wss}_wrctl_exception ? ${wdata}_exception_reg_mea:
                                              ${cs}_exception_reg_mea"],
                );






                set_control_reg_field_input_expr($exception_reg_mea,
                    "${wss}_exc_crst_active ? 0 :
                     ${wss}_exc_slave_access_error_active ? 1 :
                     ${wss}_valid           ? ${cs}_exception_reg_mea_inst_nxt : 
                                              ${cs}_exception_reg_mea");
            }

            if ($exception_reg_mee) {
                e_assign->adds(

                  [["${cs}_exception_reg_mee_inst_nxt", $exception_reg_mee_sz],
                    "${wss}_wrctl_exception ? ${wdata}_exception_reg_mee :
                                              ${cs}_exception_reg_mee"],
                );






                set_control_reg_field_input_expr($exception_reg_mee,
                    "${wss}_exc_crst_active ? 0 :
                     ${wss}_exc_slave_access_error_active ? 0 :
                     ${wss}_valid           ? ${cs}_exception_reg_mee_inst_nxt : 
                                              ${cs}_exception_reg_mee");
            }

            if ($exception_reg_cause) {
                set_control_reg_field_input_expr($exception_reg_cause,
                    "${wss}_exc_active_no_break ? 
                        ${wss}_exc_highest_pri_cause_code :
                        ${cs}_exception_reg_cause");
            }
        }

        if ($badaddr_reg) {
            set_control_reg_field_input_expr($badaddr_reg_baddr,
                "${wss}_exc_crst_active  ? 0 :
                 ${wss}_exc_record_baddr ? ${wss}_exc_highest_pri_baddr :
                                           ${cs}_badaddr_reg_baddr");
        }

        if ($pteaddr_reg) {




            set_control_reg_need_testbench_version($pteaddr_reg, 1);


            set_control_reg_field_input_expr($pteaddr_reg_ptbase,
              "${wss}_exc_crst_active ? 0 : ${wdata}_pteaddr_reg_ptbase");

            set_control_reg_field_wr_en_expr($pteaddr_reg_ptbase, 
                "${cs}_en & 
                  ((${wss}_wrctl_pteaddr & ${wss}_valid) | 
                   ${wss}_exc_crst_active)");



            set_control_reg_field_input_expr($pteaddr_reg_vpn,
                "${wss}_exc_crst_active  ? 0 :
                 (${wss}_exc_tlb_active & ~${cs}_status_reg_eh) ? 
                                           ${wss}_exc_vpn :
                 ${cs}_tlb_rd_operation  ? tlb_rd_vpn :
                                           ${wdata}_pteaddr_reg_vpn");
    
            set_control_reg_field_wr_en_expr($pteaddr_reg_vpn, 
                "${cs}_en &
                  ((${wss}_exc_tlb_active & ~${cs}_status_reg_eh) |
                   ${cs}_tlb_rd_operation |
                   (${wss}_wrctl_pteaddr & ${wss}_valid) |
                   ${wss}_exc_crst_active)");

            set_control_reg_field_testbench_expr($pteaddr_reg_vpn,
               "${cs}_tlb_rd_operation ? ${cs}_pteaddr_reg_vpn_nxt
                                       : ${cs}_pteaddr_reg_vpn");
        }

        if ($tlbacc_reg) {




            set_control_reg_need_testbench_version($tlbacc_reg, 1);



            my $wr_en_expr =
                "${cs}_en &
                  (${cs}_tlb_rd_operation |
                   (${wss}_wrctl_tlbacc & ${wss}_valid) |
                   ${wss}_exc_crst_active)";
    
            set_control_reg_field_input_expr($tlbacc_reg_pfn,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_pfn :
                                            ${wdata}_tlbacc_reg_pfn");
            set_control_reg_field_wr_en_expr($tlbacc_reg_pfn, $wr_en_expr);
            set_control_reg_field_testbench_expr($tlbacc_reg_pfn,
             "${cs}_tlb_rd_operation ? ${cs}_tlbacc_reg_pfn_nxt :
                                       ${cs}_tlbacc_reg_pfn");
    
            set_control_reg_field_input_expr($tlbacc_reg_g,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_g :
                                            ${wdata}_tlbacc_reg_g");
            set_control_reg_field_wr_en_expr($tlbacc_reg_g, $wr_en_expr);
            set_control_reg_field_testbench_expr($tlbacc_reg_g,
             "${cs}_tlb_rd_operation ? ${cs}_tlbacc_reg_g_nxt :
                                       ${cs}_tlbacc_reg_g");

            set_control_reg_field_input_expr($tlbacc_reg_x,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_x :
                                            ${wdata}_tlbacc_reg_x");
            set_control_reg_field_wr_en_expr($tlbacc_reg_x, $wr_en_expr);
            set_control_reg_field_testbench_expr($tlbacc_reg_x,
             "${cs}_tlb_rd_operation ? ${cs}_tlbacc_reg_x_nxt :
                                       ${cs}_tlbacc_reg_x");

            set_control_reg_field_input_expr($tlbacc_reg_w,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_w :
                                            ${wdata}_tlbacc_reg_w");
            set_control_reg_field_wr_en_expr($tlbacc_reg_w, $wr_en_expr);
            set_control_reg_field_testbench_expr($tlbacc_reg_w,
             "${cs}_tlb_rd_operation ? ${cs}_tlbacc_reg_w_nxt :
                                       ${cs}_tlbacc_reg_w");

            set_control_reg_field_input_expr($tlbacc_reg_r,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_r :
                                            ${wdata}_tlbacc_reg_r");
            set_control_reg_field_wr_en_expr($tlbacc_reg_r, $wr_en_expr);
            set_control_reg_field_testbench_expr($tlbacc_reg_r,
             "${cs}_tlb_rd_operation ? ${cs}_tlbacc_reg_r_nxt :
                                       ${cs}_tlbacc_reg_r");

            set_control_reg_field_input_expr($tlbacc_reg_c,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_c :
                                            ${wdata}_tlbacc_reg_c");
            set_control_reg_field_wr_en_expr($tlbacc_reg_c, $wr_en_expr);
            set_control_reg_field_testbench_expr($tlbacc_reg_c,
             "${cs}_tlb_rd_operation ? ${cs}_tlbacc_reg_c_nxt :
                                       ${cs}_tlbacc_reg_c");
        }

        if ($tlbmisc_reg) {




            set_control_reg_need_testbench_version($tlbmisc_reg, 1);


            set_control_reg_field_input_expr($tlbmisc_reg_we,
                "${wss}_exc_crst_active                ? 0 :
                 (${wss}_exc_tlb_active & ~${cs}_status_reg_eh) ? 1 :
                 (${wss}_wrctl_tlbmisc & ${wss}_valid) ? 
                                            ${wdata}_tlbmisc_reg_we :
                                            ${cs}_tlbmisc_reg_we");
    


            set_control_reg_field_input_expr($tlbmisc_reg_way,
                "${wss}_exc_crst_active              ? 0 :
                (${wss}_wrctl_tlbacc & ${wss}_valid & ${cs}_tlbmisc_reg_we) ?
                   (${cs}_tlbmisc_reg_way + 1) :
                   ${wdata}_tlbmisc_reg_way");
            set_control_reg_field_wr_en_expr($tlbmisc_reg_way,
                "${cs}_en & 
                  ((${wss}_wrctl_tlbacc & ${wss}_valid & ${cs}_tlbmisc_reg_we) |
                   (${wss}_wrctl_tlbmisc & ${wss}_valid) |
                   ${wss}_exc_crst_active)");
    


            set_control_reg_field_input_expr($tlbmisc_reg_pid,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_tlb_rd_operation   ? tlb_rd_pid :
                                            ${wdata}_tlbmisc_reg_pid");
            set_control_reg_field_wr_en_expr($tlbmisc_reg_pid,
                "${cs}_en & 
                  (${cs}_tlb_rd_operation |
                   (${wss}_wrctl_tlbmisc & ${wss}_valid) |
                   ${wss}_exc_crst_active)");
            set_control_reg_field_testbench_expr($tlbmisc_reg_pid,
               "${cs}_tlb_rd_operation ? ${cs}_tlbmisc_reg_pid_nxt :
                                         ${cs}_tlbmisc_reg_pid");
    

            set_control_reg_field_input_expr($tlbmisc_reg_dbl,
                "(${wss}_exc_tlb_inst_miss_active | 
                  ${wss}_exc_tlb_data_miss_active) ?
                                              ${cs}_status_reg_eh :
                 ${wss}_exc_active_no_break ? 0 :
                                              ${cs}_tlbmisc_reg_dbl");
    

            set_control_reg_field_input_expr($tlbmisc_reg_bad,
                "${wss}_exc_bad_virtual_addr_active ? 1 :
                 ${wss}_exc_active_no_break         ? 0 :
                                                      ${cs}_tlbmisc_reg_bad");
    

            set_control_reg_field_input_expr($tlbmisc_reg_perm,
                "(${wss}_exc_tlb_x_perm_active | ${wss}_exc_tlb_r_perm_active |
                  ${wss}_exc_tlb_w_perm_active) ?  1 :
                 ${wss}_exc_active_no_break ? 0 :
                                              ${cs}_tlbmisc_reg_perm");
    

            set_control_reg_field_input_expr($tlbmisc_reg_d,
                "${wss}_exc_crst_active                             ? 0 :
                 (${wss}_exc_data & ~${cs}_status_reg_eh)           ? 1 :
                 (${wss}_exc_active_no_break & ~${cs}_status_reg_eh) ? 0 :
                                            ${cs}_tlbmisc_reg_d");
        }

        if ($mmu_present) {



            e_assign->adds(

              [["${wss}_tlb_rd_operation", 1],
                "${wss}_wrctl_tlbmisc & ${wdata}_tlbmisc_reg_rd & 
                 ${wss}_valid"],
            );

            e_register->adds(
              {out => ["${cs}_tlb_rd_operation", 1], 
               in => "${wss}_tlb_rd_operation", enable => "${cs}_en"},
            );
        }

        if ($config_reg) {
            e_assign->adds(

              [["${cs}_config_reg_pe_inst_nxt", $config_reg_pe_sz],
                "${wss}_wrctl_config ? ${wdata}_config_reg_pe :
                                       ${cs}_config_reg_pe"],
            );



            set_control_reg_field_input_expr($config_reg_pe,
                "${wss}_exc_crst_active ? 0 :
                 ${wss}_valid           ? ${cs}_config_reg_pe_inst_nxt : 
                                          ${cs}_config_reg_pe");
        }

        if ($mpubase_reg) {




            set_control_reg_need_testbench_version($mpubase_reg, 1);



            set_control_reg_field_input_expr($mpubase_reg_base,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_dmpu_rd_operation  ? dmpu_rd_base :
                 ${cs}_impu_rd_operation  ? impu_rd_base :
                                            ${wdata}_mpubase_reg_base");
            set_control_reg_field_wr_en_expr($mpubase_reg_base,
                "${cs}_en & 
                  (${cs}_dmpu_rd_operation |
                   ${cs}_impu_rd_operation |
                   (${wss}_wrctl_mpubase & ${wss}_valid) |
                   ${wss}_exc_crst_active)");
            set_control_reg_field_testbench_expr($mpubase_reg_base,
              "${cs}_mpu_rd_operation ? ${cs}_mpubase_reg_base_nxt :
                                        ${cs}_mpubase_reg_base");

            e_assign->adds(

              [["${cs}_mpubase_reg_index_inst_nxt", $mpubase_reg_index_sz],
                "${wss}_wrctl_mpubase ? ${wdata}_mpubase_reg_index :
                                        ${cs}_mpubase_reg_index"],
            );
        


            set_control_reg_field_input_expr($mpubase_reg_index,
                "${wss}_exc_crst_active ? 0 :
                 ${wss}_valid           ? ${cs}_mpubase_reg_index_inst_nxt : 
                                          ${cs}_mpubase_reg_index");

            e_assign->adds(

              [["${cs}_mpubase_reg_d_inst_nxt", $mpubase_reg_d_sz],
                "${wss}_wrctl_mpubase ? ${wdata}_mpubase_reg_d :
                                        ${cs}_mpubase_reg_d"],
            );
        


            set_control_reg_field_input_expr($mpubase_reg_d,
                "${wss}_exc_crst_active ? 0 :
                 ${wss}_valid           ? ${cs}_mpubase_reg_d_inst_nxt : 
                                          ${cs}_mpubase_reg_d");
        }

        if ($mpuacc_reg) {




            set_control_reg_need_testbench_version($mpuacc_reg, 1);




            my $wr_en_expr =
                "${cs}_en &
                  (${cs}_mpu_rd_operation |
                   (${wss}_wrctl_mpuacc & ${wss}_valid) |
                   ${wss}_exc_crst_active)";



            if ($mpuacc_reg_limit) {
                set_control_reg_field_input_expr($mpuacc_reg_limit,
                  "${wss}_exc_crst_active   ? 0 :
                   ${cs}_dmpu_rd_operation  ? dmpu_rd_limit :
                   ${cs}_impu_rd_operation  ? impu_rd_limit :
                                              ${wdata}_mpuacc_reg_limit");
                set_control_reg_field_wr_en_expr($mpuacc_reg_limit, 
                  $wr_en_expr);
                set_control_reg_field_testbench_expr($mpuacc_reg_limit,
                  "${cs}_mpu_rd_operation ? ${cs}_mpuacc_reg_limit_nxt :
                                            ${cs}_mpuacc_reg_limit");
            }

            if ($mpuacc_reg_mask) {
                set_control_reg_field_input_expr($mpuacc_reg_mask,
                  "${wss}_exc_crst_active   ? 0 :
                   ${cs}_dmpu_rd_operation  ? dmpu_rd_mask :
                   ${cs}_impu_rd_operation  ? impu_rd_mask :
                                              ${wdata}_mpuacc_reg_mask");
                set_control_reg_field_wr_en_expr($mpuacc_reg_mask, 
                  $wr_en_expr);
                set_control_reg_field_testbench_expr($mpuacc_reg_mask,
                  "${cs}_mpu_rd_operation ? ${cs}_mpuacc_reg_mask_nxt :
                                            ${cs}_mpuacc_reg_mask");
            }
    


            set_control_reg_field_input_expr($mpuacc_reg_c,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_dmpu_rd_operation  ? dmpu_rd_c :
                 ${cs}_impu_rd_operation  ? 0 :
                                            ${wdata}_mpuacc_reg_c");
            set_control_reg_field_wr_en_expr($mpuacc_reg_c, $wr_en_expr);
            set_control_reg_field_testbench_expr($mpuacc_reg_c,
              "${cs}_mpu_rd_operation ? ${cs}_mpuacc_reg_c_nxt :
                                        ${cs}_mpuacc_reg_c");

            set_control_reg_field_input_expr($mpuacc_reg_perm,
                "${wss}_exc_crst_active   ? 0 :
                 ${cs}_dmpu_rd_operation  ? dmpu_rd_perm :
                 ${cs}_impu_rd_operation  ? impu_rd_perm :
                                            ${wdata}_mpuacc_reg_perm");
            set_control_reg_field_wr_en_expr($mpuacc_reg_perm, $wr_en_expr);
            set_control_reg_field_testbench_expr($mpuacc_reg_perm,
              "${cs}_mpu_rd_operation ? ${cs}_mpuacc_reg_perm_nxt :
                                        ${cs}_mpuacc_reg_perm");
        }

        if ($mpu_present) {



            e_assign->adds(


              [["${wss}_impu_rd_operation", 1],
                "${wss}_wrctl_mpuacc & ${wdata}_mpuacc_reg_rd &
                 ${wss}_valid & ~${cs}_mpubase_reg_d"],
            


              [["${wss}_dmpu_rd_operation", 1],
                "${wss}_wrctl_mpuacc & ${wdata}_mpuacc_reg_rd &
                 ${wss}_valid & ${cs}_mpubase_reg_d"],
    
              [["${cs}_mpu_rd_operation", 1], 
                "${cs}_impu_rd_operation | ${cs}_dmpu_rd_operation"],



              [["${wss}_impu_wr_operation", 1],
                "${wss}_wrctl_mpuacc & ${wdata}_mpuacc_reg_wr &
                 ${wss}_valid & ~${cs}_mpubase_reg_d"],
            


              [["${wss}_dmpu_wr_operation", 1],
                "${wss}_wrctl_mpuacc & ${wdata}_mpuacc_reg_wr &
                 ${wss}_valid & ${cs}_mpubase_reg_d"],
            );

            e_register->adds(

              {out => ["${cs}_impu_rd_operation", 1], 
               in => "${wss}_impu_rd_operation", enable => "${cs}_en"},
              {out => ["${cs}_dmpu_rd_operation", 1], 
               in => "${wss}_dmpu_rd_operation", enable => "${cs}_en"},
              {out => ["${cs}_impu_wr_operation", 1], 
               in => "${wss}_impu_wr_operation", enable => "${cs}_en"},
              {out => ["${cs}_dmpu_wr_operation", 1], 
               in => "${wss}_dmpu_wr_operation", enable => "${cs}_en"},
            );
        }
    } else {



        e_assign->adds(




          [["${cs}_status_reg_pie_inst_nxt", $status_reg_pie_sz],
            "(${wss}_ctrl_exception | ${wss}_ctrl_break |
              ${wss}_ctrl_crst)      ? 1'b0 :
              ${wss}_op_eret         ? ${cs}_estatus_reg[$status_reg_pie_lsb] :
              ${wss}_op_bret         ? ${cs}_bstatus_reg[$status_reg_pie_lsb] :
              ${wss}_wrctl_status    ? ${wdata}_status_reg_pie :
                                       ${cs}_status_reg_pie"],
        );
    


        set_control_reg_field_input_expr($status_reg_pie,
            "${wss}_valid           ? ${cs}_status_reg_pie_inst_nxt : 
                                      ${cs}_status_reg_pie");


        foreach my $status_field (@{get_control_reg_fields($status_reg)}) {
            my $f = get_control_reg_field_name($status_field);
            my $sz = get_control_reg_field_sz($status_field);
            my $estatus_field = get_control_reg_field($estatus_reg, $f);
            my $bstatus_field = get_control_reg_field($bstatus_reg, $f);

            e_assign->adds(

              [["${cs}_estatus_reg_${f}_inst_nxt", $sz],
                 "${wss}_ctrl_crst       ? 0 :
                 ${wss}_ctrl_exception  ? ${cs}_status_reg_${f} :
                 ${wss}_wrctl_estatus   ? ${wdata}_estatus_reg_${f} :
                                          ${cs}_estatus_reg_${f}"],
            );

            set_control_reg_field_input_expr($estatus_field,
              "${wss}_valid ? ${cs}_estatus_reg_${f}_inst_nxt : 
                              ${cs}_estatus_reg_${f}");
      
            e_assign->adds(

              [["${cs}_bstatus_reg_${f}_inst_nxt", $sz],
                "${wss}_ctrl_break      ? ${cs}_status_reg_${f} :
                 ${wss}_wrctl_bstatus   ? ${wdata}_bstatus_reg_${f} :
                                          ${cs}_bstatus_reg_${f}"],
            );

            set_control_reg_field_input_expr($bstatus_field,
              "${wss}_valid ? ${cs}_bstatus_reg_${f}_inst_nxt : 
                              ${cs}_bstatus_reg_${f}");
        }

        if ($exception_reg) {
            e_assign->adds(





              [["${cs}_exception_reg_mea_inst_nxt", $exception_reg_mea_sz],
                "${wss}_ctrl_crst       ? 0 :
                 (${wss}_ctrl_exception & mem_exception_pending) ? 1 :
                 ${wss}_wrctl_exception ? ${wdata}_exception_reg_mea :
                                          ${cs}_exception_reg_mea"],
            );
        


            set_control_reg_field_input_expr($exception_reg_mea,
                "${wss}_valid           ? ${cs}_exception_reg_mea_inst_nxt : 
                                          ${cs}_exception_reg_mea");
    
            e_assign->adds(





              [["${cs}_exception_reg_mee_inst_nxt", $exception_reg_mee_sz],
                "${wss}_ctrl_crst       ? 0 :
                 (${wss}_ctrl_exception & mem_exception_pending) ? 0 :
                 ${wss}_wrctl_exception ? ${wdata}_exception_reg_mee :
                                          ${cs}_exception_reg_mee"],
            );
        


            set_control_reg_field_input_expr($exception_reg_mee,
                "${wss}_valid           ? ${cs}_exception_reg_mee_inst_nxt : 
                                          ${cs}_exception_reg_mee");
        }
    }

    if ($debugger_present) { 

        if (manditory_int($Opt, "internal_irq_mask") == 0) {


            e_assign->adds(
              [["oci_ienable_dummy_sink", 32, 0, $force_never_export], 
                "oci_ienable"],
            );
        }
    } else {

        e_assign->adds(
          [["oci_ienable", 32, 0, $force_never_export], "{32{1'b1}}"],
        );
    }


    my %rdctl_info = (



      "D" => [$status_reg, $estatus_reg, $bstatus_reg, $ienable_reg,
               $ipending_reg, $cpuid_reg],



      "E" => "remaining",
    );


    if (!defined(gen_control_regs($control_regs, 
      \&nios_europa_assignment, \&nios_europa_register, 
      \&nios_europa_binary_mux, \%rdctl_info))) {
        &$error("$whoami: gen_control_regs() failed");
    }

    my @control_registers = (
        { divider => "control_registers" },
        { radix => "x", signal => "${rs}_ctrl_rdctl_inst" },
        { radix => "x", signal => "${rs}_valid" },
        { radix => "x", signal => "${rs}_iw_control_regnum" },
        { radix => "x", signal => "${rs}_rdctl_data" },
        { radix => "x", signal => "${wss}_ctrl_wrctl_inst" },
        { radix => "x", signal => "${wss}_valid" },
        { radix => "x", signal => "${wss}_iw_control_regnum" },
        { radix => "x", signal => "${wss}_wrctl_status" },
        { radix => "x", signal => "${wss}_wrctl_estatus" },
        { radix => "x", signal => "${wss}_wrctl_bstatus" },
        { radix => "x", signal => "${wss}_wrctl_ienable" },
        { radix => "x", signal => "${wss}_ctrl_exception" },
        { radix => "x", signal => "${wss}_op_intr" },
        { radix => "x", signal => "${wss}_op_trap" },
        { radix => "x", signal => "${wss}_op_break" },
        { radix => "x", signal => "${wss}_op_hbreak" },
        { radix => "x", signal => "${wss}_op_eret" },
        { radix => "x", signal => "${wss}_op_bret" },
        @{get_control_regs_for_waves($control_regs)},
    );

    if ($Opt->{full_waveform_signals}) {
        push(@plaintext_wave_signals, @control_registers);
    }
}

1;

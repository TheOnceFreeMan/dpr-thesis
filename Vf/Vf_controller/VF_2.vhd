-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\paul.rogers\OldStuff\GradSchool\MATLAB\Both_Test\vf_hdl_prj\hdlsrc\VF_2\VF_2.vhd
-- Created: 2017-10-05 15:19:44
-- 
-- Generated by MATLAB 9.1 and HDL Coder 3.9
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 2e-06
-- Target subsystem base rate: 2e-06
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        2e-06
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Va                            ce_out        2e-06
-- Vb                            ce_out        2e-06
-- Vc                            ce_out        2e-06
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: VF_2
-- Source Path: VF_2
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.VF_2_pkg.ALL;

ENTITY VF_2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        freq                              :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En12
        ce_out                            :   OUT   std_logic;
        Va                                :   OUT   std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
        Vb                                :   OUT   std_logic_vector(83 DOWNTO 0);  -- sfix84_En66
        Vc                                :   OUT   std_logic_vector(83 DOWNTO 0)  -- sfix84_En66
        );
END VF_2;


ARCHITECTURE rtl OF VF_2 IS

  -- Component Declarations
  COMPONENT cosinea
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          u                               :   IN    std_logic_vector(63 DOWNTO 0);  -- sfix64_En35
          x                               :   OUT   std_logic_vector(50 DOWNTO 0)  -- sfix51_En42
          );
  END COMPONENT;

  COMPONENT cosineb
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          u                               :   IN    std_logic_vector(64 DOWNTO 0);  -- sfix65_En35
          x                               :   OUT   std_logic_vector(50 DOWNTO 0)  -- sfix51_En42
          );
  END COMPONENT;

  COMPONENT cosinec
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          u                               :   IN    std_logic_vector(64 DOWNTO 0);  -- sfix65_En35
          x                               :   OUT   std_logic_vector(50 DOWNTO 0)  -- sfix51_En42
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : cosinea
    USE ENTITY work.cosinea(rtl);

  FOR ALL : cosineb
    USE ENTITY work.cosineb(rtl);

  FOR ALL : cosinec
    USE ENTITY work.cosinec(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL freq_signed                      : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL freq_1                           : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL gain_out1                        : signed(31 DOWNTO 0);  -- sfix32_En24
  SIGNAL gain_out1_1                      : signed(31 DOWNTO 0);  -- sfix32_En24
  SIGNAL reduced_reg                      : vector_of_signed32(0 TO 1);  -- sfix32 [2]
  SIGNAL gain_out1_2                      : signed(31 DOWNTO 0);  -- sfix32_En24
  SIGNAL Discrete_Time_Integrator_indtc   : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Discrete_Time_Integrator_indtc_1 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL gain_mul_temp                    : signed(31 DOWNTO 0);  -- sfix32_En8
  SIGNAL Discrete_Time_Integrator_u_gain  : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL Discrete_Time_Integrator_u_gain_1 : signed(63 DOWNTO 0);  -- sfix64
  SIGNAL Discrete_Time_Integrator_u_dtc   : signed(63 DOWNTO 0);  -- sfix64_En35
  SIGNAL Discrete_Time_Integrator_x_reg   : signed(63 DOWNTO 0);  -- sfix64_En35
  SIGNAL Discrete_Time_Integrator_u_add   : signed(63 DOWNTO 0);  -- sfix64_En35
  SIGNAL Cosine                           : std_logic_vector(50 DOWNTO 0);  -- ufix51
  SIGNAL Cosine_signed                    : signed(50 DOWNTO 0);  -- sfix51_En42
  SIGNAL Cosine_1                         : signed(50 DOWNTO 0);  -- sfix51_En42
  SIGNAL phaseamultiplier_out1            : signed(82 DOWNTO 0);  -- sfix83_En66
  SIGNAL phaseamultiplier_out1_1          : signed(82 DOWNTO 0);  -- sfix83_En66
  SIGNAL DCoffset_out1                    : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL phaseadc_add_cast                : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phaseadc_add_cast_1              : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phaseadc_out1                    : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phaseb_out1                      : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL subtractb_sub_cast               : signed(64 DOWNTO 0);  -- sfix65_En35
  SIGNAL subtractb_sub_cast_1             : signed(64 DOWNTO 0);  -- sfix65_En35
  SIGNAL subtractb_out1                   : signed(64 DOWNTO 0);  -- sfix65_En35
  SIGNAL Cosine_2                         : std_logic_vector(50 DOWNTO 0);  -- ufix51
  SIGNAL Cosine_signed_1                  : signed(50 DOWNTO 0);  -- sfix51_En42
  SIGNAL Cosine_3                         : signed(50 DOWNTO 0);  -- sfix51_En42
  SIGNAL phasebmultiplier_out1            : signed(82 DOWNTO 0);  -- sfix83_En66
  SIGNAL phasebmultiplier_out1_1          : signed(82 DOWNTO 0);  -- sfix83_En66
  SIGNAL phasebdc_add_cast                : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phasebdc_add_cast_1              : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phasebdc_out1                    : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phasec_out1                      : signed(15 DOWNTO 0);  -- sfix16_En12
  SIGNAL subtractc_sub_cast               : signed(64 DOWNTO 0);  -- sfix65_En35
  SIGNAL subtractc_sub_cast_1             : signed(64 DOWNTO 0);  -- sfix65_En35
  SIGNAL subtractc_out1                   : signed(64 DOWNTO 0);  -- sfix65_En35
  SIGNAL Cosine_4                         : std_logic_vector(50 DOWNTO 0);  -- ufix51
  SIGNAL Cosine_signed_2                  : signed(50 DOWNTO 0);  -- sfix51_En42
  SIGNAL Cosine_5                         : signed(50 DOWNTO 0);  -- sfix51_En42
  SIGNAL phasecmultiplier_out1            : signed(82 DOWNTO 0);  -- sfix83_En66
  SIGNAL phasecmultiplier_out1_1          : signed(82 DOWNTO 0);  -- sfix83_En66
  SIGNAL phasecdc_add_cast                : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phasecdc_add_cast_1              : signed(83 DOWNTO 0);  -- sfix84_En66
  SIGNAL phasecdc_out1                    : signed(83 DOWNTO 0);  -- sfix84_En66

BEGIN
  -- <Root>/cosinea
  u_cosinea : cosinea
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              u => std_logic_vector(Discrete_Time_Integrator_x_reg),  -- sfix64_En35
              x => Cosine  -- sfix51_En42
              );

  -- <Root>/cosineb
  u_cosineb : cosineb
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              u => std_logic_vector(subtractb_out1),  -- sfix65_En35
              x => Cosine_2  -- sfix51_En42
              );

  -- <Root>/cosinec
  u_cosinec : cosinec
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              u => std_logic_vector(subtractc_out1),  -- sfix65_En35
              x => Cosine_4  -- sfix51_En42
              );

  freq_signed <= signed(freq);

  enb <= clk_enable;

  HwModeRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      freq_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        freq_1 <= freq_signed;
      END IF;
    END IF;
  END PROCESS HwModeRegister1_process;


  -- <Root>/gain
  gain_out1 <= to_signed(16#0344#, 16) * freq_1;

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      gain_out1_1 <= to_signed(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        gain_out1_1 <= gain_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      reduced_reg <= (OTHERS => to_signed(0, 32));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        reduced_reg(0) <= gain_out1_1;
        reduced_reg(1) <= reduced_reg(0);
      END IF;
    END IF;
  END PROCESS reduced_process;

  gain_out1_2 <= reduced_reg(1);

  Discrete_Time_Integrator_indtc <= freq_signed;

  HwModeRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      Discrete_Time_Integrator_indtc_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Discrete_Time_Integrator_indtc_1 <= Discrete_Time_Integrator_indtc;
      END IF;
    END IF;
  END PROCESS HwModeRegister_process;


  gain_mul_temp <= to_signed(16#10C7#, 16) * Discrete_Time_Integrator_indtc_1;
  Discrete_Time_Integrator_u_gain <= resize(gain_mul_temp(31 DOWNTO 8), 64);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      Discrete_Time_Integrator_u_gain_1 <= to_signed(0, 64);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Discrete_Time_Integrator_u_gain_1 <= Discrete_Time_Integrator_u_gain;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Discrete_Time_Integrator_u_dtc <= Discrete_Time_Integrator_u_gain_1;

  Discrete_Time_Integrator_u_add <= Discrete_Time_Integrator_x_reg + Discrete_Time_Integrator_u_dtc;

  -- <Root>/Discrete-Time Integrator
  Discrete_Time_Integrator_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      Discrete_Time_Integrator_x_reg <= to_signed(0, 64);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Discrete_Time_Integrator_x_reg <= Discrete_Time_Integrator_u_add;
      END IF;
    END IF;
  END PROCESS Discrete_Time_Integrator_reg_process;


  Cosine_signed <= signed(Cosine);

  HwModeRegister3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      Cosine_1 <= to_signed(0, 51);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Cosine_1 <= Cosine_signed;
      END IF;
    END IF;
  END PROCESS HwModeRegister3_process;


  -- <Root>/phaseamultiplier
  phaseamultiplier_out1 <= gain_out1_2 * Cosine_1;

  PipelineRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      phaseamultiplier_out1_1 <= to_signed(0, 83);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        phaseamultiplier_out1_1 <= phaseamultiplier_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister2_process;


  -- <Root>/DCoffset
  DCoffset_out1 <= to_unsigned(16#0019#, 16);

  -- <Root>/phaseadc
  phaseadc_add_cast <= resize(phaseamultiplier_out1_1, 84);
  phaseadc_add_cast_1 <= signed(resize(DCoffset_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 84));
  phaseadc_out1 <= phaseadc_add_cast + phaseadc_add_cast_1;

  Va <= std_logic_vector(phaseadc_out1);

  -- <Root>/phaseb
  phaseb_out1 <= to_signed(16#0555#, 16);

  -- <Root>/subtractb
  subtractb_sub_cast <= resize(Discrete_Time_Integrator_x_reg, 65);
  subtractb_sub_cast_1 <= resize(phaseb_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 65);
  subtractb_out1 <= subtractb_sub_cast - subtractb_sub_cast_1;

  Cosine_signed_1 <= signed(Cosine_2);

  HwModeRegister5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      Cosine_3 <= to_signed(0, 51);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Cosine_3 <= Cosine_signed_1;
      END IF;
    END IF;
  END PROCESS HwModeRegister5_process;


  -- <Root>/phasebmultiplier
  phasebmultiplier_out1 <= gain_out1_2 * Cosine_3;

  PipelineRegister3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      phasebmultiplier_out1_1 <= to_signed(0, 83);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        phasebmultiplier_out1_1 <= phasebmultiplier_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister3_process;


  -- <Root>/phasebdc
  phasebdc_add_cast <= resize(phasebmultiplier_out1_1, 84);
  phasebdc_add_cast_1 <= signed(resize(DCoffset_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 84));
  phasebdc_out1 <= phasebdc_add_cast + phasebdc_add_cast_1;

  Vb <= std_logic_vector(phasebdc_out1);

  -- <Root>/phasec
  phasec_out1 <= to_signed(16#0AAB#, 16);

  -- <Root>/subtractc
  subtractc_sub_cast <= resize(Discrete_Time_Integrator_x_reg, 65);
  subtractc_sub_cast_1 <= resize(phasec_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 65);
  subtractc_out1 <= subtractc_sub_cast - subtractc_sub_cast_1;

  Cosine_signed_2 <= signed(Cosine_4);

  HwModeRegister7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      Cosine_5 <= to_signed(0, 51);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Cosine_5 <= Cosine_signed_2;
      END IF;
    END IF;
  END PROCESS HwModeRegister7_process;


  -- <Root>/phasecmultiplier
  phasecmultiplier_out1 <= gain_out1_2 * Cosine_5;

  PipelineRegister4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '0' THEN
      phasecmultiplier_out1_1 <= to_signed(0, 83);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        phasecmultiplier_out1_1 <= phasecmultiplier_out1;
      END IF;
    END IF;
  END PROCESS PipelineRegister4_process;


  -- <Root>/phasecdc
  phasecdc_add_cast <= resize(phasecmultiplier_out1_1, 84);
  phasecdc_add_cast_1 <= signed(resize(DCoffset_out1 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 84));
  phasecdc_out1 <= phasecdc_add_cast + phasecdc_add_cast_1;

  Vc <= std_logic_vector(phasecdc_out1);

  ce_out <= clk_enable;

END rtl;


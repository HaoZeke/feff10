potSRC = \
./POT/pot.f90 ./PAR/parallel.f90 ./COMMON/wlog.f90 \
./COMMON/str.f90 ./COMMON/chopen.f90 ./POT/reapot.f90 \
./KSPACE/crystalstructure.f90 ./KSPACE/readcrystaldata.f90 ./KSPACE/pointgroup.f90 \
./MATH/invertmatrix.f90 ./KSPACE/spacegroup.f90 ./KSPACE/subtract_a.f90 \
./KSPACE/change_car.f90 ./KSPACE/symmetrycheck.f90 ./KSPACE/kmesh.f90 \
./POT/kpreppot.f90 ./MATH/cwig3j.f90 ./KSPACE/calccgc.f90 \
./KSPACE/strinit.f90 ./KSPACE/strvecgen.f90 ./KSPACE/strgaunt.f90 \
./KSPACE/cgcrac.f90 ./KSPACE/strsmat.f90 ./MATH/lu.f90 \
./MATH/seigen.f90 ./KSPACE/straa.f90 ./KSPACE/strconfra.f90 \
./KSPACE/strfunqjl.f90 ./KSPACE/strharpol.f90 ./KSPACE/strcc.f90 \
./KSPACE/change_eta.f90 ./KSPACE/bastrans.f90 ./KSPACE/makerotations.f90 \
./COMMON/rdhead.f90 ./POT/potsub.f90 ./POT/inipot.f90 \
./POT/moveh.f90 ./POT/istprm.f90 ./MATH/dist.f90 \
./POT/sidx.f90 ./COMMON/xx.f90 ./EXCH/vbh.f90 \
./EXCH/edp.f90 ./POT/movrlp.f90 ./POT/ovp2mt.f90 \
./MATH/terp.f90 ./MATH/polint.f90 ./MATH/somm2.f90 \
./POT/fermi.f90 ./POT/afolp.f90 ./POT/corval.f90 \
./COMMON/fixvar.f90 ./COMMON/fixdsx.f90 ./POT/rholie.f90 \
./FOVRG/dfovrg.f90 ./FOVRG/inmuac.f90 ./COMMON/getorb.f90 \
./RDINP/rdline.f90 ./COMMON/nxtunt.f90 ./FOVRG/diff.f90 \
./FOVRG/wfirdc.f90 ./FOVRG/nucdec.f90 ./ATOM/nucmass.f90 \
./FOVRG/potdvp.f90 ./FOVRG/aprdep.f90 ./FOVRG/solout.f90 \
./FOVRG/intout.f90 ./FOVRG/solin.f90 ./MATH/besjh.f90 \
./MATH/bjnser.f90 ./FOVRG/muatcc.f90 ./FOVRG/potex.f90 \
./FOVRG/aprdec.f90 ./FOVRG/yzkrdc.f90 ./FOVRG/yzktec.f90 \
./MATH/besjn.f90 ./MATH/phamp.f90 ./MATH/exjlnl.f90 \
./MATH/terpc.f90 ./MATH/csomm2.f90 ./POT/importpot.f90 \
./COMMON/rdpot.f90 ./COMMON/padlib.f90 ./POT/scmt.f90 \
./POT/grids.f90 ./POT/fmsie.f90 ./FMS/yprep.f90 \
./FMS/xstaff.f90 ./FMS/fmskspace.f90 ./FMS/kkrintegral.f90 \
./COMMON/writematrix.f90 ./KSPACE/structurefactor.f90 ./KSPACE/strset.f90 \
./KSPACE/strbbdd2.f90 ./KSPACE/strbbdd.f90 ./FMS/fmspack.f90 \
./MATH/ylm.f90 ./FMS/gglu.f90 ./FMS/ggbi.f90 \
./FMS/ggrm.f90 ./FMS/gggm.f90 ./FMS/ggtf.f90 \
./POT/ff2g.f90 ./POT/broydn.f90 ./POT/coulom.f90 \
./ATOM/potslw.f90 ./POT/frnrm.f90 ./POT/scmtmp.f90 \
./POT/wpot.f90 ./COMMON/head.f90 ./TDLDA/correorb.f90 \
./TDLDA/cdos.f90 ./POT/wrpot.f90 ./POT/rhofmslie.f90 \
./MATH/qsortd.f90 
pot_MODULESRC = \
./PAR/m_par.f90 ./COMMON/m_constants.f90 ./KSPACE/m_struct.f90 \
./KSPACE/m_controls.f90 ./KSPACE/m_boundaries.f90 ./KSPACE/m_kklist.f90 \
./KSPACE/m_kgenwork.f90 ./KSPACE/m_tetrahedra.f90 ./KSPACE/m_controlkgen.f90 \
./KSPACE/m_energygrid.f90 ./KSPACE/m_workstrfacs2.f90 ./KSPACE/m_workstrfacs.f90 \
./KSPACE/m_workstrfacssimple.f90 ./KSPACE/m_trafo.f90 ./KSPACE/m_strfacs.f90 \
./KSPACE/m_wigner3j.f90 ./COMMON/m_dimsmod.f90 ./COMMON/m_inpmodules.f90 \
./EXCH/m_pdw.f90 ./EXCH/m_pz.f90 ./EXCH/m_ksdt.f90 \
./COMMON/m_ifuns.f90 ./COMMON/m_config.f90 ./COMMON/m_rotx.f90 \
./COMMON/m_lnlm.f90 ./COMMON/m_xstruc.f90 ./COMMON/m_afctr.f90 \
./ERRORMODS/m_errormod.f90 ./IOMODS/m_iofiles.f90 ./IOMODS/m_padio.f90 \
./IOMODS/m_iomod.f90 ./COMMON/m_stkets.f90 ./FMS/m_fms.f90 \
./COMMON/m_t3j.f90 ./POT/m_broydn_workspace.f90 ./ERRORMODS/m_errorfile.f90 \
./COMMON/m_kinds.f90 ./POT/m_mtdp.f90 ./POT/m_atomicpotio.f90 \
./POT/m_thermal_scf.f90 ./POT/m_sommerfeld_scf.f90 
select ltrim(rtrim(n.nv_value_string))
                           from invoice_dtl_nvpair n
                          where n.invoice = 1433
                            and n.nv_attrib = 'TT_CFOP';
                         
SELECT * FROM invoice_dtl_nvpair WHERE invoice = 1433; 

SELECT *
  FROM invoice_hdr_nvpair
 WHERE invoice = 1433
   AND nv_attrib = 'NFE_XML_DECODED';
   SELECT * FROM invoice_hdr WHERE invoice = 1433; 
select x.*,n.nv_value_string
  from invoice_hdr        h,
       invoice_dtl_nfexml x,
       invoice_dtl_nvpair n
 where h.invoice = 1433
   and h.invoice = x.invoice
   AND n.invoice = x.invoice
   AND nv_attrib = 'TT_CFOP_ENT'; 

SELECT nv_value_string FROM invoice_dtl_nvpair WHERE invoice = 1433 AND nv_attrib = 'TT_CFOP_ENT'; 

SELECT * FROM invoice_hdr WHERE invoice = 1433; 
SELECT * FROM TTAX_HDR WHERE TTAX_HDR = 2280; 
SELECT * FROM TTAX_HDR WHERE erp_hdr_ref = 1433; 
SELECT * FROM ttax_dtl WHERE TTAX_HDR = 2280; 

SELECT * FROM invoice_dtl_nvpair ORDER BY CREATE_DATETIME DESC; 

SELECT * FROM ttax_dtl ORDER BY CREATE_DATETIME DESC; 



  merge into ttax_dtl r
   using (select t.line_id,
               t.cfop_sai,
               t.cfop_ent
          from ttax_hdr_nvpair n,
               JSON_TABLE(n.nv_value_clob,
                          '$.data.items[*]'
                          COLUMNS(line_id NUMBER(20) path '$.id',
                                  cfop_sai VARCHAR2(20) path '$.cfop',
                                  cfop_ent VARCHAR2(20) path '$.cfopEntrada')) t
         where ttax_hdr = 2280
           and nv_group = 'TURBOTAX'
           and nv_attrib = 'RESPONSE') t
   on (r.ttax_dtl = t.line_id and r.orig_erp = 280 and r.dest_erp = 284)
   when matched then
   update
      set r.cfop_ttax    = t.cfop_ent,
          r.cfop_invoice = nvl(r.cfop_invoice, t.cfop_sai);
          
          
          
          select t.line_id,
               t.cfop_sai,
               t.cfop_ent,
               n.nv_value_clob
          from ttax_hdr_nvpair n,
               JSON_TABLE(n.nv_value_clob,
                          '$.data.items[*]'
                          COLUMNS(line_id NUMBER(20) path '$.id',
                                  cfop_sai VARCHAR2(20) path '$.cfop',
                                  cfop_ent VARCHAR2(20) path '$.cfopEntrada')) t
         where ttax_hdr = 2280
           and nv_group = 'TURBOTAX'
           and nv_attrib = 'RESPONSE';
           
 SELECT x.invoice
       ,x.nf_det_prod_cprod
       ,x.nf_det_prod_cean
       ,x.nf_det_prod_xprod
       ,x.nf_det_prod_ncm
       ,x.nf_det_prod_nve
       ,x.nf_det_prod_cest
       ,x.nf_det_prod_indescala
       ,x.nf_det_prod_cnpjfab
       ,x.nf_det_prod_cbenef
       ,x.nf_det_prod_extipi
       ,CASE
           WHEN h.invoice_type = 'TSF' THEN
            n.nv_value_string
           ELSE
            x.nf_det_prod_cfop 
        END nf_det_prod_cfop
       ,x.nf_det_prod_ucom
       ,x.nf_det_prod_qcom
       ,x.nf_det_prod_vuncom
       ,x.nf_det_prod_vprod
       ,x.nf_det_prod_ceantrib
       ,x.nf_det_prod_utrib
       ,x.nf_det_prod_qtrib
       ,x.nf_det_prod_vuntrib
       ,x.nf_det_prod_vfrete
       ,x.nf_det_prod_vseg
       ,x.nf_det_prod_vdesc
       ,x.nf_det_prod_voutro
       ,x.nf_det_prod_indtot
       ,x.nf_det_prod_di
       ,x.nf_det_prod_detexport
       ,x.nf_det_prod_xped
       ,x.nf_det_prod_nitemped
       ,x.nf_det_prod_nfci
       ,x.nf_det_prod_rastro
       ,x.nf_det_prod_veicprod
       ,x.nf_det_prod_med
       ,x.nf_det_prod_arma
       ,x.nf_det_prod_comb
       ,x.nf_det_prod_nrecopi
       ,x.nf_det_imp_icms_orig
       ,x.nf_det_imp_icms_cst
       ,x.nf_det_imp_icms_modbc
       ,x.nf_det_imp_icms_predbc
       ,x.nf_det_imp_icms_vbc
       ,x.nf_det_imp_icms_picms
       ,x.nf_det_imp_icms_vicms
       ,x.nf_det_imp_icms_vbcfcp
       ,x.nf_det_imp_icms_pfcp
       ,x.nf_det_imp_icms_vfcp
       ,x.nf_det_imp_icms_modbcst
       ,x.nf_det_imp_icms_pmvast
       ,x.nf_det_imp_icms_predbcst
       ,x.nf_det_imp_icms_vbcst
       ,x.nf_det_imp_icms_picmsst
       ,x.nf_det_imp_icms_vicmsst
       ,x.nf_det_imp_icms_vbcfcpst
       ,x.nf_det_imp_icms_pfcpst
       ,x.nf_det_imp_icms_vfcpst
       ,x.nf_det_imp_icms_vbcstret
       ,x.nf_det_imp_icms_pst
       ,x.nf_det_imp_icms_vicmsstret
       ,x.nf_det_imp_icms_vbcfcpstret
       ,x.nf_det_imp_icms_pfcpstret
       ,x.nf_det_imp_icms_vfcpstret
       ,x.nf_det_imp_icms_vicmsdeson
       ,x.nf_det_imp_icms_motdesicms
       ,x.nf_det_imp_ipi_cienq
       ,x.nf_det_imp_ipi_cnpjprod
       ,x.nf_det_imp_ipi_cselo
       ,x.nf_det_imp_ipi_qselo
       ,x.nf_det_imp_ipi_cenq
       ,x.nf_det_imp_ipi_cst
       ,x.nf_det_imp_ipi_vbc
       ,x.nf_det_imp_ipi_pipi
       ,x.nf_det_imp_ipi_qunid
       ,x.nf_det_imp_ipi_vunid
       ,x.nf_det_imp_ipi_vipi
       ,x.nf_det_imp_pis_cst
       ,x.nf_det_imp_pis_vbc
       ,x.nf_det_imp_pis_ppis
       ,x.nf_det_imp_pis_vpis
       ,x.nf_det_imp_pis_qbcprod
       ,x.nf_det_imp_pis_valiqprod
       ,x.nf_det_imp_cofins_cst
       ,x.nf_det_imp_cofins_vbc
       ,x.nf_det_imp_cofins_pcofins
       ,x.nf_det_imp_cofins_vcofins
       ,x.nf_det_imp_cofins_qbcprod
       ,x.nf_det_imp_cofins_valiqprod
       ,x.nf_det_imp_devol_pdevol
       ,x.nf_det_imp_devol_vipidevol
       ,x.nf_det_infadprod
       ,x.nf_det_line_no
   FROM invoice_hdr        h
       ,invoice_dtl_nfexml x
       ,invoice_dtl_nvpair n
  WHERE h.invoice = 1433
    AND h.invoice = x.invoice
    AND n.invoice = x.invoice
    AND nv_attrib = 'TT_CFOP_ENT';

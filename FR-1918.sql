SELECT * FROM ADMRFA.INTEGRATION_MESSAGE im
WHERE im.INTEG_MSG_REF  = '174928027';

SELECT * FROM invoice_hdr WHERE invoice = 326172 FOR UPDATE; 
SELECT * FROM invoice_dtl WHERE invoice = 326172; 
SELECT * FROM invoice_dtl_nvpair WHERE invoice = 326172;  -- NF_CFOP
SELECT * FROM ttax_hdr WHERE erp_hdr_ref = '326172'; 
SELECT * FROM ttax_dtl WHERE ttax_hdr = 353749; 
SELECT * FROM invoice_hdr WHERE invoice_type = 'RSALE' order by 1 desc; 

SELECT * FROM fiscal_group WHERE fiscal_operation = '12'; 
SELECT * FROM fiscal_group WHERE fiscal_group = 5; 
SELECT * FROM fiscal_group WHERE fiscal_group = 7501; 
SELECT * FROM fiscal_group_nvpair WHERE fiscal_group = 5; 
SELECT * FROM fiscal_group_nvpair WHERE fiscal_group = 7501; 

SELECT DISTINCT NAME from dba_source where upper(text) like '%INSERT INTO INVOICE_DTL_NVPAIR%';
SELECT * from dba_source where upper(text) like '%NV_ATTRIB%' AND upper(text) like  '%NF_CFOP%'; 

SELECT * FROM system_log_hdr WHERE log_ref = '326172' ORDER BY 1 DESC; 

select n.nv_value_string from invoice_dtl_nvpair n where /*n.invoice_line = d.invoice_line and*/ n.nv_attrib = 'NF_CFOP' and rownum = 1;

SELECT * FROM invoice_hdr_nvpair WHERE invoice = 326172; 
select t.* from system_log_hdr t where t.log_ref = '326172' order by 1;

SELECT * from dba_source where upper(text) like '%1918%'; -- INTEGRATION_LAYER_STD_SQL
SELECT * from dba_source where upper(text) like '%CUSTOMERORDER_RETURN%'; 

SELECT * FROM invoice_hdr WHERE invoice_key = 35220730008267000196550010000002172074163530;
SELECT * FROM invoice_hdr WHERE invoice = 326172; 
SELECT * FROM integration_message WHERE integ_msg_ref = '999999998'; 
SELECT * FROM integration_message WHERE integ_msg_ref = '100000021'; 
SELECT * FROM integration_message WHERE integ_msg >= 3681934; 
SELECT * FROM integration_process; 

SELECT * FROM invoice_hdr_nvpair WHERE invoice = 326172; 
SELECT * FROM sale_hdr WHERE sale = 305921; 
  select max(ih.invoice) invoice
        from sale_hdr            sh,
             invoice_hdr         ih,
             invoice_hdr_nvpair  ihn,
             integration_message i,
             JSON_TABLE(i.message, '$' COLUMNS (sale_ref    VARCHAR(25) path '$.customer_order_no',
                                                sale_subref VARCHAR(25) path '$.fulfill_order_no' )) s
       where i.integ_msg      = '3682061'
         and sh.sale_ref      = s.sale_ref
         and sh.sale_subref   = s.sale_subref
         and sh.company       = i.company
         and sh.sale          = ihn.nv_value_number
        -- and ihn.nv_group     = 'INVOICE_ATTR'
         --and ihn.nv_attrib    = 'RSALE'
         and ihn.invoice      = ih.invoice
         and ih.invoice_type  = 'RSALE'
         ;
         

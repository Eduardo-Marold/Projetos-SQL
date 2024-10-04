SELECT * FROM invoice_cost_dtl WHERE cost_name LIKE '%ICMS%';
SELECT * FROM invoice_cost_dtl WHERE cost_type = 'FN_TAX_OTHER';

SELECT * FROM invoice_cost_dtl_nvpair WHERE nv_attrib = 'NF_CST_ICMS';

SELECT * FROM invoice_hdr WHERE invoice_subtype = 'EXIT' ORDER BY invoice DESC;
SELECT * FROM invoice_cost_dtl_nvpair WHERE nv_value_string = '4';

SELECT *
  FROM invoice_hdr_nvpair
 WHERE invoice = 1329
   AND nv_attrib = 'NFE_XML_DECODED';

SELECT * FROM invoice_hdr_nvpair ORDER BY invoice_nvpair DESC;

select invoice_type
        from invoice_hdr
       where invoice = 1329;

-------------------------------------------------------------------------------------------------------

select NVL((select ltrim(rtrim(n.nv_value_string))
                   from invoice_cost_dtl_nvpair n
                  where n.nv_attrib = 'TT_CST'
                    and n.invoice_cost_line = c.invoice_cost_line
                    and rownum = 1),
                 '00') icms_cst,
             c.cost_name
        from invoice_cost_dtl c, invoice_hdr h
       where c.invoice_line = 3011
         and c.invoice = h.invoice
            -- #verificar alterado de FN_ para NF_
         and ((c.cost_type = 'TT_TAX' and c.cost_name = 'ICMS') or
             (c.cost_type = 'TT_TAX_RET' and c.cost_name = 'VICMSSTRET'))
         and not exists (select 'Y'
                from fiscal_group_nvpair n
               where n.nv_attrib = 'FINNFE'
                 and n.fiscal_group = h.fiscal_group
                 and n.nv_value_string = '4');

SELECT * FROM invoice_cost_dtl c WHERE ((c.cost_type = 'TT_TAX' and c.cost_name = 'ICMS') OR (c.cost_type = 'TT_TAX_RET' and c.cost_name = 'VICMSSTRET')); 
SELECT * FROM invoice_cost_dtl WHERE invoice_line = 3011; 
                
SELECT * FROM INVOICE_DTL WHERE invoice = 1300; 
SELECT * FROM fiscal_group_nvpair n where n.nv_attrib = 'FINNFE' AND n.nv_value_string = '4'; -- 9001 9011 9021 9031
SELECT * FROM invoice_hdr WHERE fiscal_group IN (9001, 9011, 9021, 9031); -- Não existe mesmo


------------------------------------------------

SELECT * FROM invoice_cost_dtl WHERE cost_name IN ('ICMSSUBSTITUTO', 'VICMSSUBSTITUTO'); 
SELECT * FROM invoice_cost_dtl WHERE cost_name IN ('ICMSSTRET', 'VICMSSTRET');

SELECT * FROM all_source t WHERE t.text LIKE UPPER('%INVOICE_NFE_TOOLS_SQL.IMPOSTO_ICMS%');

SELECT * FROM all_source t WHERE t.text LIKE UPPER('%INVOICE_NFE_TOOLS_SQL.CREATE_NFE%');

SELECT * FROM invoice_cost_dtl WHERE cost_type = 'ST_TAX'; 
SELECT * FROM invoice_cost_dtl WHERE cost_name = 'ICMSSTRET'; -- 1460
SELECT t.*, t.ROWID FROM invoice_cost_dtl T WHERE INVOICE = 1392 AND cost_name = 'ICMSSTRET';

SELECT * FROM invoice_cost_dtl WHERE cost_name = 'ICMSSUBSTITUTO'; -- 1461
SELECT t.*, t.ROWID FROM invoice_cost_dtl T WHERE INVOICE = 1020 AND cost_name IN ('ICMSST','ICMS');

SELECT * FROM invoice_hdr_nvpair WHERE CREATE_DATETIME >= TRUNC(SYSDATE) ORDER BY invoice DESC;
SELECT * FROM invoice_hdr WHERE invoice = 1072;
SELECT t.*, t.ROWID FROM invoice_hdr t WHERE invoice = 2255;
SELECT t.*, t.ROWID FROM invoice_cost_dtl T WHERE COST_TYPE = 'TT_TAX';

SELECT dtl.* 
FROM INVOICE_HDR hdr
JOIN invoice_cost_dtl dtl ON dtl.invoice = hdr.invoice
WHERE cost_name = 'ICMS' AND hdr.invoice_subtype = 'EXIT';

SELECT dtl.* 
FROM INVOICE_HDR hdr
JOIN invoice_cost_dtl dtl ON dtl.invoice = hdr.invoice
WHERE cost_name = 'ICMS' AND hdr.invoice_type = 'TSF' AND hdr.invoice_subtype = 'EXIT'; 

SELECT * FROM invoice_hdr_nvpair WHERE CREATE_DATETIME >= TRUNC(SYSDATE) ORDER BY CREATE_DATETIME DESC;

SELECT * FROM invoice_cost_dtl WHERE INVOICE = 2255; 


SELECT * FROM invoice_cost_dtl ORDER BY invoice_cost_line DESC; 

SELECT * 
  FROM entity_nvpair en
  JOIN entity        et
    ON et.entity = en.entity
 WHERE et.entity_type = 'STORE'
   AND en.nv_group = 'FISCAL_ENTITY_ATTRIBUTES'
 ORDER BY en.create_datetime DESC; 
 

















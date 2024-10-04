SELECT * FROM item WHERE item = 2173; 

select * from item_nvpair
WHERE item  = 2173
AND nv_attrib = 'FIT_ORIG'
and nv_group = 'FISCAL_ITEM_ATTRIBUTES'; -- cadastro

select * from invoice_dtl WHERE item = 2173; -- NF

SELECT DISTINCT h.invoice
      ,d.item "Código Item - RFA"
      ,i.item_ref "Código Item - ORMS"
      ,itn.nv_value_string "Origem de Mercadoria - Cadastro"
      ,d.merch_origin "Origem de Mercadoria - NF"
      ,h.create_datetime "Data Criação NF"
  FROM invoice_hdr h
  JOIN invoice_dtl d
    ON h.invoice = d.invoice
  JOIN item i
    ON i.item = d.item
  JOIN item_nvpair itn
    ON d.item = itn.item
 WHERE h.invoice_type = 'PO'
   AND to_char(h.create_datetime, 'YYYY-MM-DD') >= '2022-02-01'
   AND itn.nv_attrib = 'FIT_ORIG'
   AND itn.nv_group = 'FISCAL_ITEM_ATTRIBUTES';


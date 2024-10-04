﻿-- O que é RNF?
-- NET COST?
-- Ambiente de PRD do GRN
-- Observei que na proc INVOICE_LAYER_SQL.process_cost parece faltar NVL no campo d.cost_value na query abaixo, que calcula o NET_COST:
-- Favor verificar se para outros calculos similares o NVL também precisa ser adicionado.

select * from invoice_cost_dtl  where invoice = 11130 AND cost_type = 'FN_TAX'; --and invoice_line = 472908;

SELECT * FROM INVOICE_HDR WHERE invoice = 11130; 

select * from invoice_cost_dtl  where invoice = 11130 AND cost_name = 'NET_COST';

SELECT * FROM invoice_dtl WHERE invoice = 11130; 

SELECT ROUND( - SUM(NVL(0.000,0)) / MAX(1.000),4) FROM dual;

SELECT ROUND( - SUM(NVL(1.9900,0)) / MAX(1.000),4) FROM dual; -- else



-- cost_cr_value
-- cost_value
-- cost_quantity

SELECT d.invoice_line invoice_line
      ,d.invoice invoice
      ,'FN_ITEM_COST' cost_type
      ,'NET_COST' cost_name
      ,MAX(d.cost_quantity) cost_quantity
      ,CASE
          WHEN d.cost_cr_value > 0
               AND d.cost_cr_value > nvl(d.cost_value, 0) THEN
           round(-sum(nvl(d.cost_cr_value, 0)) / MAX(d.cost_quantity), 4)
          ELSE
           round(-sum(nvl(d.cost_value, 0)) / MAX(d.cost_quantity), 4)
       END cost_unit_value
      ,CASE
          WHEN d.cost_cr_value > 0
               AND d.cost_cr_value > nvl(d.cost_value, 0) THEN
           round(-sum(nvl(d.cost_cr_value, 0)), 4)
          ELSE
           round(-sum(nvl(d.cost_value, 0)), 4)
       END cost_value
--ROUND( - SUM(NVL(d.cost_value,0)) / MAX(d.cost_quantity)                           ,4) cost_unit_value       ,
--ROUND( - SUM(NVL(d.cost_value,0))                                                  ,4) cost_value
  FROM invoice_hdr      h
      ,invoice_cost_dtl d
 WHERE h.invoice = 11130
   AND d.invoice = h.invoice
   AND d.cost_type = 'FN_TAX'
   AND EXISTS (SELECT 1
          FROM company_code_dtl cc
         WHERE cc.comp_code = 'UNIT_COST_TAX_INCLUDED'
           AND cc.comp_code_line = d.cost_name
           AND cc.company = h.inv_company)
 GROUP BY d.invoice_line
         ,d.invoice
         ,d.cost_cr_value
         ,d.cost_value;
         
         

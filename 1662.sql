SELECT * FROM invoice_cost_dtl WHERE invoice = 220205; 
SELECT * FROM invoice_cost_dtl WHERE invoice = 220205 AND cost_name = 'VOUTRO'; 
SELECT * FROM invoice_cost_dtl WHERE invoice = 220205 AND cost_name IN ('FCPST','ICMSST'); 
SELECT * FROM all_source WHERE upper(text) LIKE '%FN_OTHER_ICMSST%'; 
SELECT * FROM invoice_hdr WHERE invoice = 220205; 

select h.invoice invoice_b,
       NVL((select c.code_name from general_code_dtl c where c.gen_code_hdr = 7 and c.code = h.invoice_type ),'Tipo indefinido') invoice_type,
       h.invoice_ref,
       h.invoice_sub_ref,
       NVL((select c.code_name from general_code_dtl c where c.gen_code_hdr = 5 and c.code = h.inv_status ),'Status indefinido') status,
       NVL((select 'Y' from invoice_financial_dtl where invoice = h.invoice and rownum = 1),'N') financial_ind,
        case when h.invoice_type      IN ('TSF','RTSF','IC','RIC','ALLOC','RALLOC') and 
                  h.inv_status        IN ('F','CA','NE')                            and 
                  NVL(e.rollouted,'N') = 'Y'                                        then
          'N'
            when h.invoice_type IN ('STOCK') and h.inv_status IN ('CA') then
          'N'
       else
          'Y'
       end cancel_ind,      
       h.inv_status,
       (select n.nv_value_string from invoice_hdr_nvpair n where n.invoice = h.invoice and nv_group = 'NFE_AUTHORIZATION' and nv_attrib = 'NF_CHNFE') access_key,
       (select n.nv_value_string from invoice_hdr_nvpair n where n.invoice = h.invoice and nv_group = 'NFE_AUTHORIZATION' and nv_attrib = 'NF_PROTOCOLO') access_prot, 
       h.create_user,
       h.inv_company company,
       NVL((select 'Y' from general_code_dtl g where g.gen_code_hdr = 5 and g.code = h.inv_status and g.code_seq <= (select code_seq from general_code_dtl where gen_code_hdr = 5 and code_value = 'INVOICE_VALIDATED')),'N') edit_ind,
       NVL(x.NF_EMIT_CNPJ,x.NF_EMIT_CPF) EMIT_CNPJ_CPF,
       NVL(x.NF_DEST_CNPJ,x.NF_DEST_CPF) DEST_CNPJ_CPF,
       x.*
  from invoice_hdr        h,
       invoice_hdr_nfexml x,
       entity             e
 where h.invoice     = 220205
   and h.invoice     = x.invoice
   and h.entity_dest = e.entity;   
   
   
SELECT *
FROM INVOICE_COST_DTL CD
JOIN INVOICE_HDR IH
ON IH.invoice = CD.invoice
WHERE cost_name = 'STE'
AND IH.invoice_type = 'TSF'
ORDER BY CD.INVOICE DESC;

SELECT * FROM INVOICE_HDR WHERE invoice = 1433; 

SELECT * FROM INVOICE_COST_DTL WHERE invoice_line = '215733';

SELECT * FROM integration_message WHERE(TRUNC(create_datetime) = '20/04/2022') AND integ_msg_ref LIKE '%220205%'; 

SELECT t.*, t.ROWID FROM integration_message t WHERE(TRUNC(create_datetime) = '20/04/2022') AND integ_msg_ref LIKE '%220205%';
SELECT t.*, t.ROWID FROM integration_message t WHERE integ_msg_ref LIKE '%220205%';

SELECT * FROM integration_message ORDER BY create_datetime DESC; 

SELECT * FROM INVOICE_COST_DTL WHERE invoice = '239460' AND INVOICE_LINE = 327335 ORDER BY 2, 6;
----------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO cost_type  (COST_TYPE, COST_TYPE_DESC, COST_NAME, COST_NAME_DESC, CREATE_USER, CREATE_DATETIME, UPDATE_USER, UPDATE_DATETIME) VALUES ('FN_OTHER_ICMSST', 'NF Other expenses' , 'FCPST', 'FCPST retido anteriormente' , 1 , SYSDATE, 1, SYSDATE);
SELECT * FROM cost_type WHERE cost_type = 'FN_OTHER_ICMSST'; 
----------------------------------------------------------------------------------
   -- PROCESS ST
   ----------------------------------------------------------------------------------
   insert into invoice_cost_dtl (invoice_cost_line,invoice_line ,invoice ,cost_type ,cost_name ,cost_quantity ,cost_unit_value ,cost_value ,create_user ,create_datetime ,update_user,update_datetime)
   select INVOICE_COST_LINE_SEQ.NEXTVAL                                       invoice_cost_line     ,
          d.invoice_line                                                      invoice_line          ,
          d.invoice                                                           invoice               ,
          'FN_EXPENSE'                                                        cost_type             ,
          'VOUTRO'                                                            cost_name             ,
          d.quantity                                                          cost_quantity         ,
          0                                                                   cost_unit_value       ,
          0                                                                   cost_value            ,
          I_user                                                             create_user            ,
          SYSDATE                                                             create_datetime        ,
          I_user                                                             update_user            ,
          SYSDATE                                                             update_datetime
     from invoice_dtl d
    where d.invoice = I_invoice
      and NOT EXISTS (select 'Y' from invoice_cost_dtl c where c.invoice_line = d.invoice_line and c.cost_type = 'FN_EXPENSE' and c.cost_name = 'VOUTRO');
   
   -- Mudar o COST_TYPE do ICMSST E FCPST de FN_TAX para FN_OTHER_ICMSST PARA QUE NA NOTA SAIA COM ESSES TRIBUTOS ZERADOS E O VALOR DESSES TRIBUTOS SEJAM SOMADO A OUTRAS DEPENSAS
   delete from invoice_cost_dtl d where d.invoice = I_invoice and d.cost_type = 'FN_OTHER_ICMSST' and d.cost_name = 'ICMSST';
   update invoice_cost_dtl d
      set d.cost_type = 'FN_OTHER_ICMSST'
    where d.invoice   = I_invoice
      and d.cost_type = 'FN_TAX'
      and d.cost_name IN ('ICMSST','FCPST') -- HOTFIX ??? - TRATAR FCPST
      and d.cost_value > 0;

   -- Se existe devolucao de ST, joga tag zerada pois nesses casos o tributos destacado vai ser zerado e o valor do tributo vai ser somado em outras despesas
   insert into invoice_cost_dtl (invoice_cost_line,invoice_line ,invoice ,cost_type ,cost_name ,cost_quantity, cost_base ,cost_rate_type, cost_rate, cost_unit_value ,cost_value ,create_user ,create_datetime ,update_user,update_datetime)
   select INVOICE_COST_LINE_SEQ.NEXTVAL                                       invoice_cost_line     ,
          d.invoice_line                                                      invoice_line          ,
          d.invoice                                                           invoice               ,
          'FN_TAX'                                                            cost_type             ,
          d.cosst_name                                                        cost_name             ,  -- HOTFIX ??? - TRATAR FCPST
          d.cost_quantity                                                     cost_quantity         ,
          0                                                                   cost_base             ,
          d.cost_rate_type                                                    cost_rate_type        ,
          0                                                                   cost_rate             ,
          0                                                                   cost_unit_value       ,
          0                                                                   cost_value            ,
          I_user                                                             create_user            ,
          SYSDATE                                                             create_datetime        ,
          I_user                                                             update_user            ,
          SYSDATE
     from invoice_cost_dtl d
    where d.invoice   = I_invoice
      and d.cost_type = 'FN_OTHER_ICMSST'
      and d.cost_name IN ('ICMSST', 'FCPST')
      and d.cost_value > 0;
   
   -- SOMAR O ICMST E O FCPST A OUTRAS DEPESAS (VOUTRO) e ao VALOR TOTAL DOS TRIBUTOS (VTOTTRIB)
   update invoice_cost_dtl d
       set d.cost_unit_value  = d.cost_unit_value + NVL((select SUM(NVL(c.cost_unit_value,0))          -- HOTFIX ??? - TRATAR FCPST
                                                           from invoice_cost_dtl c
                                                          where c.invoice_line = d.invoice_line
                                                            and c.cost_type    = 'FN_OTHER_ICMSST'
                                                            and c.cost_name   IN ('ICMSST', 'FCPST')   -- HOTFIX ??? - TRATAR FCPST
                                                            --and ROWNUM         = 1                   -- HOTFIX ??? - TRATAR FCPST
                                                         ),0)                                          
         ,  d.cost_value      = d.cost_value      + NVL((select SUM(NVL(c.cost_value,0))               -- HOTFIX ??? - TRATAR FCPST
                                                           from invoice_cost_dtl c
                                                          where c.invoice_line = d.invoice_line
                                                            and c.cost_type    = 'FN_OTHER_ICMSST'
                                                            and c.cost_name   IN ('ICMSST', 'FCPST')   -- HOTFIX ??? - TRATAR FCPST
                                                            --and ROWNUM         = 1                   -- HOTFIX ??? - TRATAR FCPST   
                                                         ),0)
     where d.invoice   = I_invoice
       AND (d.cost_type, d.cost_name) IN ( ('FN_EXPENSE', 'VOUTRO'), ('FN_TAX', 'VTOTTRIB');           -- HOTFIX ??? - TRATAR FCPST 
       
       
-- HOTFIX ??? - TRATAR FCPST - START COMMENT
-- O UPDATE ABAIXO FOI MOVIDO PAR AO UPDATE ACIMA, COMO OS UPDATES ERAM IGUAIS, FOI TRATATO EM UM UNICO CODIGO.
/*   update invoice_cost_dtl d
       set d.cost_unit_value  = d.cost_unit_value + NVL((select NVL(c.cost_unit_value,0)
                                                           from invoice_cost_dtl c
                                                          where c.invoice_line = d.invoice_line
                                                            and c.cost_type    = 'FN_OTHER_ICMSST'
                                                            and c.cost_name    = 'ICMSST'
                                                            and ROWNUM         = 1),0),
            d.cost_value      = d.cost_value      + NVL((select NVL(c.cost_value,0)
                                                           from invoice_cost_dtl c
                                                          where c.invoice_line = d.invoice_line
                                                            and c.cost_type    = 'FN_OTHER_ICMSST'
                                                            and c.cost_name    = 'ICMSST'
                                                            and ROWNUM         = 1),0)
     where d.invoice   = I_invoice
       and d.cost_type = 'FN_TAX'
       and d.cost_name = 'VTOTTRIB';*/
-- HOTFIX ??? - TRATAR FCPST - END COMMENT

---------------------------------------------------------------------------------------

select cdtl.invoice_line, 
       cdtl.cost_name                                                  Tipo_de_custo,
       (select ct.cost_name_desc 
          from cost_type ct
         where ct.cost_name = cdtl.cost_name
           and ct.cost_type = cdtl.cost_type)                                 Descrição,
       TO_CHAR(nvl(cdtl.cost_unit_value,0),'FML999G999G990D9990')                                      Valor_unitário,
       nvl(cdtl.cost_mva_rate,0)||'%'                                        mva,
       TO_CHAR(nvl(cdtl.cost_base,0),'FML999G999G990D9990')                                            Base_de_cálculo,
       nvl(cdtl.cost_base_chg_rate,0)                                   Base_reduzida,
       nvl(decode(cdtl.cost_rate_type,'P','Percentual'
                                     ,'V','Valor'),'Sem Informação')    Tipo_Taxa,
       nvl(cdtl.cost_rate,0)||'%'                                       Taxa,
       TO_CHAR(nvl(cdtl.cost_value,0) ,'FML999G999G990D9990')                                          Valor_total,
       TO_CHAR(nvl(cdtl.cost_cr_value,0),'FML999G999G990D9990')                                        Valor_Recuperável
  from invoice_cost_dtl  cdtl,
       invoice_hdr       hdr
  where cdtl.cost_type like 'FN_%'
   and hdr.invoice = cdtl.invoice
   and hdr.invoice = 262280
   AND cdtl.cost_name = 'FCPST';
   
SELECT * FROM invoice_cost_dtl WHERE invoice = 262280; 
SELECT * FROM invoice_cost_dtl WHERE invoice_line = 4846172; 
SELECT * FROM invoice_hdr WHERE invoice = 239460; -- RNF
-- RNF: 239460
-- Nota de entrada 1 REF: 233230, 227050
SELECT * FROM invoice_hdr WHERE invoice = 233230; -- ORIGINAL
SELECT * FROM invoice_dtl WHERE invoice = 233230; 
SELECT * FROM invoice_cost_HDR WHERE invoice = 233230; 
SELECT * FROM invoice_cost_dtl WHERE invoice = 233230; 

SELECT * FROM invoice_hdr WHERE invoice = 227050; -- ORIGINAL
SELECT * FROM invoice_dtl WHERE invoice = 227050; 
SELECT * FROM invoice_cost_HDR WHERE invoice = 227050; 
SELECT * FROM invoice_cost_dtl WHERE invoice = 227050; 

select cdtl.invoice_line, 
       cdtl.cost_name                                                  Tipo_de_custo,
       (select ct.cost_name_desc 
          from cost_type ct
         where ct.cost_name = cdtl.cost_name
           and ct.cost_type = cdtl.cost_type)                                 Descrição,
       TO_CHAR(nvl(cdtl.cost_unit_value,0),'FML999G999G990D9990')                                      Valor_unitário,
       nvl(cdtl.cost_mva_rate,0)||'%'                                        mva,
       TO_CHAR(nvl(cdtl.cost_base,0),'FML999G999G990D9990')                                            Base_de_cálculo,
       nvl(cdtl.cost_base_chg_rate,0)                                   Base_reduzida,
       nvl(decode(cdtl.cost_rate_type,'P','Percentual'
                                     ,'V','Valor'),'Sem Informação')    Tipo_Taxa,
       nvl(cdtl.cost_rate,0)||'%'                                       Taxa,
       TO_CHAR(nvl(cdtl.cost_value,0) ,'FML999G999G990D9990')                                          Valor_total,
       TO_CHAR(nvl(cdtl.cost_cr_value,0),'FML999G999G990D9990')                                        Valor_Recuperável
  from invoice_cost_dtl  cdtl,
       invoice_hdr       hdr
  where cdtl.cost_type like 'FN_%'
   and hdr.invoice = cdtl.invoice
   and hdr.invoice = 262280
   ORDER BY tipo_de_custo;
   
  
   

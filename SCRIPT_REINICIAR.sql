-- :P10_EDIT_IND = 'Y' and :P10_INV_STATUS != 'W'   EDIT_IND / INV_STATUS

declare

  L_error_message CLOB;

-- Chamada Reiniciar
  
  cursor C_CHECK_INVOICE is
     select hdr.invoice invoice --, inv_status
       from invoice_hdr hdr
      where INVOICE_TYPE IN ('RSALE')
        --AND invoice_subtype = 'EXIT'
        AND INVOICE IN (896565); 

R_get_invoice_info C_CHECK_INVOICE%ROWTYPE;

begin

  open  C_CHECK_INVOICE;
  LOOP
  fetch C_CHECK_INVOICE 
   INTO R_get_invoice_info; 
   EXIT WHEN C_CHECK_INVOICE%NOTFOUND;

    if DYNAMIC_PROCESS_SQL.CALL_PROCESS(L_error_message      ,
                                        R_get_invoice_info.invoice         , --INVOICE_B
                                        'PROCESS_INVOICE_RESET_STATUS',
                                        3         ,           --P10_RN_COMPANY
                                        1     ) = FALSE THEN  --P10_RN_USER
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro no reprocessamento da nota. Verifique o LOG de erros.' || ' ' || L_error_message);          
    end if;
       end LOOP;
  close C_CHECK_INVOICE;
end;
